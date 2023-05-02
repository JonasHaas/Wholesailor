import os
from woocommerce import API
import boto3

# WooCommerce configuration
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

# DynamoDB configuration
DYNAMODB_TABLE_NAME = os.getenv('DYNAMODB_TABLE_NAME')
DYNAMODB_ENDPOINT_URL = os.getenv('DYNAMODB_ENDPOINT_URL')
DYNAMODB_REGION = os.getenv('DYNAMODB_REGION')

dynamodb = boto3.resource('dynamodb', endpoint_url=DYNAMODB_ENDPOINT_URL, region_name=DYNAMODB_REGION)
table = dynamodb.Table(DYNAMODB_TABLE_NAME)