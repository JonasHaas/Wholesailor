import requests

response = requests.get('http://wordpress/wp-json/wc/v3/')
print("Status code:", response.status_code)

json_data = response.json()
print("JSON data:", json_data)