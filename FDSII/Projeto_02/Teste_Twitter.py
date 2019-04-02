import tweepy

consumer_key = '1oQF3Zj6t7R3ylTZqgqXgOufn'
consumer_secret = '20gmonFIHe9eBegDQlH0wqZTxx434nK4G8fOBru6j2bDGurmBK'
access_token = '908690448826486785-q8D7MWqUk9ZmwwycKggyRZd0QuFA3YF'
access_secret = 'YeVILFpJFysYCK5cNgrKgPqJIUXYqhGjapcO7193xaOCe'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)

api = tweepy.API(auth)
