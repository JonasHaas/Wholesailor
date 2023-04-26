from flask import Flask, jsonify
from app import app
from woocommerce import API
import os

WC_API_URL = os.getenv('WC_API_URL')
WC_CONSUMER_KEY = os.getenv('WC_CONSUMER_KEY')
WC_CONSUMER_SECRET = os.getenv('WC_CONSUMER_SECRET')

wcapi = API(
    url=WC_API_URL,
    consumer_key=WC_CONSUMER_KEY,
    consumer_secret=WC_CONSUMER_SECRET,
    wp_api=True,
    version="wc/v3"
)

def fetch_products():
    try:
        products = []
        page = 1

        while True:
            response = wcapi.get("products", params={"per_page": 100, "page": page}).json()

            if not response:
                break

            products.extend(response)
            page += 1
        
        # Filter the products to only include the ID and name
        filtered_products = [{"id": product["id"], "name": product["name"]} for product in products]

        return filtered_products
    except Exception as e:
        error = {"error": str(e)}
        return jsonify(error)


# this is just a test endpoint
@app.route('/products', methods=['GET'])
def get_products():
    products = fetch_products()
    product_count = len(products)
    return jsonify({"count": product_count, "products": products})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)