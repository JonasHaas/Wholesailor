from flask import jsonify
from app import app
from woocommerce import API
import os
from dotenv import load_dotenv

load_dotenv()

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
    response = wcapi.get("products")
    if response.status_code == 200:
        return response.json()
    else:
        return []

@app.route('/products', methods=['GET'])
def get_products():
    products = fetch_products()
    product_count = len(products)
    return jsonify({"count": product_count, "products": products})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)