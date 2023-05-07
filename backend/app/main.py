from . import app
from . import config
from . import helpers


# root route
@app.route("/", methods=["GET"])
def get_products():
    products = fetch_products()
    product_count = len(products)
    return jsonify({"count": product_count, "products": products})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
