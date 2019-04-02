
# copiar um Data Frame
df_clean = df.copy()

# replace de string em toda a coluna
df['Coluna'] = df['Coluna'].str.replace('!','.');