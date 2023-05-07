from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
# app = Flask(__name__, static_url_path="/../../frontend/index.html")
CORS(app)

from . import main
