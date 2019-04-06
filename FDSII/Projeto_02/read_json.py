import json

with open('keys_tweet.json') as json_file:  
    data = json.load(json_file)
    print(data['keys_tweet'][0]['consumer_key'])
        