from flask import Flask, jsonify
from . import app
from .config import wcapi, table
from woocommerce import API

# Fetch stored products from DynamoDB
def get_stored_products():
    response = table.scan()
    return response['Items']

def store_product_in_dynamodb(product):
    table.put_item(Item=product)


def fetch_products(limit=4, items_per_page=4, starting_from_page=1):
    try:
        products = []
        fetched_count = 0

        while True:
            # getting products
            response = wcapi.get("products", params={"per_page": items_per_page, "page": starting_from_page}).json()

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

        # Filter the products to only include the ID and name purchasable
        filtered_products = [{
            "id": product["id"],
            "name": product["name"],
            "status": product["status"],
        } for product in products if product["status"] == "publish"]

        return filtered_products
    
    except Exception as e:
        error = {"error": str(e)}
        return jsonify(error)

# def fetch_products():
#     try:
#         products = []
#         page = 1

#         while True:
#             response = wcapi.get("products", params={"per_page": 100, "page": page}).json()

#             if not response:
#                 break

#             products.extend(response)
#             page += 1
        
#         # Filter the products to only include the ID and name
#         filtered_products = [{"id": product["id"], "name": product["name"]} for product in products]

#         return filtered_products
#     except Exception as e:
#         error = {"error": str(e)}
#         return jsonify(error)


# this is just a test endpoint
@app.route('/products', methods=['GET'])
def get_products():
    products = fetch_products()
    product_count = len(products)
    return jsonify({"count": product_count, "products": products})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)