import boto3
import html
from woocommerce import API

logging = False
logs = []


def get_secret(secret_name):
    secretsmanager_client = boto3.client("secretsmanager")
    try:
        response = secretsmanager_client.get_secret_value(SecretId=secret_name)
        if logging == True:
            logs.append("Successfully retrieved secret")
        return response["SecretString"]
    except Exception as e:
        if logging == True:
            logs.append(f"Failed to retrieve secret {secret_name}: {str(e)}")
        return None


def fetch_products(limit=4, items_per_page=4, starting_from_page=1):
    WC_API_URL = get_secret("WC_API_URL")
    WC_CONSUMER_KEY = get_secret("WC_CONSUMER_KEY")
    WC_CONSUMER_SECRET = get_secret("WC_CONSUMER_SECRET")

    wcapi = API(
        url=WC_API_URL,
        consumer_key=WC_CONSUMER_KEY,
        consumer_secret=WC_CONSUMER_SECRET,
        wp_api=True,
        version="wc/v3",
    )

    try:
        products = []
        fetched_count = 0

        while True:
            # getting products
            response = wcapi.get(
                "products",
                params={"per_page": items_per_page, "page": starting_from_page},
            ).json()

            if not response:
                break

            products.extend(response)
            fetched_count += len(response)

            # Break the loop if the limit has been reached
            if fetched_count >= limit:
                break

            starting_from_page += 1

        # Extract the keys of each product
        # product_keys = [list(product.keys()) for product in products]
        # return product_keys

        return products
    except Exception as e:
        error = {"error": str(e)}
        return error


def process_products(products=None):
    if products is None:
        products = fetch_products()

    # Filter the products to only include the ID and name purchasable and only if they are published
    filtered_products = [
        {
            "id": product["id"],
            "name": html.unescape(product["name"]),
            "status": product["status"],
            "sku": product["sku"],
            "isDropship": False,
            "wholesalerName": "",
        }
        for product in products
        if product["status"] == "publish"
    ]

    return filtered_products


def sync_products_to_dynamodb(products=None):
    try:
        dynamodb = boto3.resource("dynamodb", region_name="eu-central-1")
        table = dynamodb.Table("products")
        logs.append("Successfully connected to DynamoDB")
    except Exception as e:
        logs.append(f"Error connecting to DynamoDB: {str(e)}")

    if products is None:
        products = process_products(fetch_products())

    for product in products:
        table.put_item(
            Item={
                "id": product["id"],
                "name": product["name"],
                "status": product["status"],
                "sku": product["sku"],
                "isDropship": product["isDropship"],
                "wholesalerName": product["wholesalerName"],
            }
        )


def handler(event, context):
    products = fetch_products()
    processed_products = process_products(products)
    sync_products_to_dynamodb(processed_products)
    return {"statusCode": 200, "body": logs}
