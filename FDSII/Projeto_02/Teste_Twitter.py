import csv
import tweepy
import pandas as pd
import json

df = pd.read_csv('twitter-archive-enhanced.csv', sep = ',', encoding='utf-8')

consumer_key = '1oQF3Zj6t7R3ylTZqgqXgOufn'
consumer_secret = '20gmonFIHe9eBegDQlH0wqZTxx434nK4G8fOBru6j2bDGurmBK'
access_token = '908690448826486785-q8D7MWqUk9ZmwwycKggyRZd0QuFA3YF'
access_secret = 'YeVILFpJFysYCK5cNgrKgPqJIUXYqhGjapcO7193xaOCe'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)
api = tweepy.API(auth)

data = {}
data['tweet'] = [] 

for i, row in df.iterrows():
    tweet = api.get_status(row['tweet_id'])
    data['tweet'].append(tweet._json)
        
    if i > 1:
        break

with open('tweet_json.txt', 'w') as outfile:
    json.dump(data, outfile, sort_keys=True, indent=4)



#retweet_count
#favorite_count
#retweeted