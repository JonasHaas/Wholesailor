import requests

x = requests.get('http://172.23.0.3:80')
print(x.status_code)