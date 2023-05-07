import html
from flask import jsonify
from .config import wcapi, table


# Fetch products from shop via api
def fetch_products(limit=4, items_per_page=4, starting_from_page=1):
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
        return jsonify(error)


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


def get_all_items_from_dynamodb():
    response = table.scan()
    items = response["Items"]

    while "LastEvaluatedKey" in response:
        response = table.scan(ExclusiveStartKey=response["LastEvaluatedKey"])
        items.extend(response["Items"])

    return items
