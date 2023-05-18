import boto3

logging = False
logs = []


def get_all_items_from_dynamodb():
    try:
        dynamodb = boto3.resource("dynamodb", region_name="eu-central-1")
        table = dynamodb.Table("products")

        if logging == True:
            logs.append("Successfully connected to DynamoDB")

        response = table.scan()
        items = response["Items"]

        while "LastEvaluatedKey" in response:
            response = table.scan(ExclusiveStartKey=response["LastEvaluatedKey"])
            items.extend(response["Items"])
        return items
    except Exception as e:
        if logging == True:
            logs.append(f"Error connecting to DynamoDB: {str(e)}")
        return None


def handler(event, context):
    items = get_all_items_from_dynamodb()
    return {"statusCode": 200, "body": f"Hello from Lambda! {items}"}
