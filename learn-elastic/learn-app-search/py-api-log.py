from elastic_app_search import Client
import json

# Create App-Search client
client = Client(
    # You must add 'api/as/v1' to the end of the endpoint without including 'https://'
    base_endpoint="Put your Endpoint",
    api_key="Put your API key",
    use_https=True
)

engine_name = "Put your app search engine name"
options = {"filters": {
    "date": {
        "from": "2023-01-16T00:00:00+00:00",
        "to": "2023-01-18T00:00:00+00:00"
        }
    },
    "pages": {
        "size": 20
    },
    "query": "/api/as/v1/engines/best-books-engine/search.json",
    "sort_direction": "desc"
}
result_json = client.get_api_logs(engine_name, options)['results']
json_arr = json.dumps(result_json, indent=4, sort_keys=True)

print(json_arr)