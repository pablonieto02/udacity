import json

with open('tweet_json.json') as json_file:  
    data = json.load(json_file)
    for row in data['tweet']:
        print(row['id'])