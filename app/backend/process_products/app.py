import boto3
from woocommerce import API

logging = False
secretsmanager_responses = []


def get_secret(secret_name):
    secretsmanager_client = boto3.client("secretsmanager")
    try:
        response = secretsmanager_client.get_secret_value(SecretId=secret_name)
        if logging == True:
            secretsmanager_responses.append("Successfully retrieved secret")
        return response["SecretString"]
    except Exception as e:
        if logging == True:
            secretsmanager_responses.append(
                f"Failed to retrieve secret {secret_name}: {str(e)}"
            )
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


def handler(event, context):
    products = fetch_products()
    return {"statusCode": 200, "body": products}
