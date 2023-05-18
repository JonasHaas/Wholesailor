from flask import jsonify, send_from_directory
from . import app
from . import helpers
import os


@app.route("/")
def home():
    # return app.static_folder
    return send_from_directory(app.static_folder, "index.html")


@app.route("/products", methods=["GET"])
def get_products():
    products = helpers.process_products(helpers.fetch_products())
    helpers.sync_products_to_dynamodb(products)
    product_count = len(products)
    return jsonify({"count": product_count, "products": products})


@app.route("/db", methods=["GET"])
def get_db_items():
    items = helpers.get_all_items_from_dynamodb()
    return jsonify({"count": len(items), "items": items})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
