import requests
import os
import pandas as pd

df_img_pred = pd.read_csv('image-predictions.tsv', sep='\t')

folder_name = 'dogs_jpg'
if not os.path.exists(folder_name):
    os.makedirs(folder_name)

for url in df_img_pred['jpg_url']:
    response = requests.get(url)
    with open(os.path.join(folder_name, url.split('/')[-1]), mode = 'wb') as file:
              file.write(response.content)
print(os.listdir(folder_name))
--