import pandas as pd

df = pd.read_csv('games_data.csv', encoding='unicode_escape', low_memory=False)
print(df)
df_json = df.to_json(orient='records', indent=4)

with open('games_data.json', 'w') as f:
    f.write(df_json)
