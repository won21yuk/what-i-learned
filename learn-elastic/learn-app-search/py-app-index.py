# pip install elastic-app-search
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

# # Index Single Document
# document = {
#         "id": "0",
#         "title": "Counter-Strike:  Global Offensive",
#         "release_date": "2012-08-21",
#         "developer": "Valve;Hidden Path Entertainment",
#         "publisher": "Valve",
#         "genres": "Action;Free to Play",
#         "multiplayer_or_singleplayer": "Multi-player;Steam Achievements;Full controller support;Steam Trading Cards;Steam Workshop;In-App Purchases;Valve Anti-Cheat enabled;Stats",
#         "price": "Free to play",
#         "dc_price": "Free to play",
#         "overall_review": "Positive",
#         "detailed_review": "Very Positive",
#         "reviews": "6774812",
#         "percent_positive": "88%",
#         "win_support": "1",
#         "mac_support": 1.0,
#         "lin_support": 1.0
#     }
#
# client.index_document(engine_name=engine_name, document=document)

# Index Multiple Documents : read from games_data.json
# You may face an error message '413 Client Error: Request Entity Too Large for url'
# Then, Adjust the size of the count being added (In my case, it is possible up to 100)
with open("games_data.json", "r") as f:
    data = json.load(f)
count = 0
while count < len(data):
    if count+100 < len(data):
        data_end = count+100
    else:
        data_end = len(data)
    documents = data[count: data_end]
    client.index_documents(engine_name, documents)
    print(data_end, " documents are indexed")
    count += 100
