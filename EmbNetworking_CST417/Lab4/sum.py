import requests
import json

url = "http://192.168.0.29:8000/api/sum"
data = [123.38, -2.72]
headers = {'Content-type': 'application/json'}
response = requests.post(url, data=json.dumps(data), headers=headers)
print(response.text)
