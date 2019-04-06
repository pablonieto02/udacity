import csv
import tweepy
import pandas as pd
import json
import time

#retweet_count
#favorite_count
#retweeted

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
'''
# guarda o id dos tweets já salvos numa lista
with open('tweet_json.json') as json_file:
    arquivo = json.load(json_file)
    for row in arquivo['tweet']:
        list_tweets_id.append(row['id'])
'''
data = {}
data['tweet'] = []
list_tweets_id = []

limit = 1
for i, row in df.iterrows():

    if i >= 200:
        break
    '''
    if int(row['tweet_id']) in list_tweets_id:
        print(str(row['tweet_id']) + ' - tweet já salvo no arquivo.')
    else:  '''  
    tweet = api.get_status(row['tweet_id'])
    data['tweet'].append(tweet._json)
    list_tweets_id.append(int(tweet._json['id']))
    print(str(tweet._json['id']) + ' - adicionado' + str(i))

with open('tweet_json.json', 'w') as outfile:
    json.dump(data, outfile, sort_keys=True, indent=4)