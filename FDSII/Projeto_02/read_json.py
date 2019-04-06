import json

with open('tweet_json.txt') as json_file:  
    data = json.load(json_file)
    for p in data['tweet']:
        print(p['id'])