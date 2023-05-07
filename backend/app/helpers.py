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
