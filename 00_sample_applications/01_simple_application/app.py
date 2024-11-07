from flask import Flask, jsonify
app = Flash(__name__)
@app.route('/products', methods=['GET'])
def get_products():
    products = [
        {"id": 1, "name": "Laptop", "price": 1000},
        {"id": 2, "name": "Smartphone", "price": 700}
    ]
    return jsonify(products)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)