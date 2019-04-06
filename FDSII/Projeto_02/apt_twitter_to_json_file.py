import csv
import tweepy
import pandas as pd
import json
import time

df = pd.read_csv('twitter-archive-enhanced.csv', sep = ',', encoding='utf-8')

with open('keys_tweet.json') as json_file:  
    data = json.load(json_file)
    consumer_key = data['keys_tweet'][0]['consumer_key']
    consumer_secret = data['keys_tweet'][0]['consumer_secret']
    access_token = data['keys_tweet'][0]['access_token']
    access_secret = data['keys_tweet'][0]['access_secret']

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)
api = tweepy.API(auth)

data = {}
data['tweet'] = []
list_tweets_id = []

def get_status_tweet(id):
    while True:
        try:
            tweet = api.get_status(id)
            break
        except tweepy.RateLimitError as tweep_error:
            print(str(id) + ' - Erro:' + str(tweep_error))
            print('Aguardando 1 minuto.')
            time.sleep(60)
            continue
        except tweepy.TweepError as tweep_error:
            print(str(id) + ' - Erro:' + str(tweep_error))
            return -1
    return tweet

for i, row in df.iterrows():
    tweet = get_status_tweet(row['tweet_id'])
    if tweet != -1:
        data['tweet'].append(tweet._json)
        list_tweets_id.append(int(tweet._json['id']))
        print(str(i) + ' - ' + str(tweet._json['id']) + ' - ok')    
            
with open('tweet_json.txt', 'w') as outfile:
    json.dump(data, outfile, sort_keys=True, indent=4)