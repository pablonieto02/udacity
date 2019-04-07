import json

with open('tweet_json.text') as json_file:  
    data = json.load(json_file)
    for row in data['tweet']:
        print(row['id'])