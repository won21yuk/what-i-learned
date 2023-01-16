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

# # Print exist engines
# engines = client.list_engines(current=1, size=20)
# print(json.dumps(engines, indent=2))

# Search
search_result = client.search(engine_name, 'counter-strike', {})
# print(json.dumps(search_result, indent=2))

# Print top3 titles in the counter-strike series
print("score:", search_result['results'][0]['_meta']['score'], "\ttitle:", search_result['results'][0]['title']['raw'])
print("score:", search_result['results'][1]['_meta']['score'], "\ttitle:", search_result['results'][1]['title']['raw'])
print("score:", search_result['results'][2]['_meta']['score'], "\ttitle:", search_result['results'][2]['title']['raw'])
