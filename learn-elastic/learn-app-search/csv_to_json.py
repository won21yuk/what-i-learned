import pandas as pd

# origin data set can download blow link:
# https://www.kaggle.com/datasets/thedevastator/comprehensive-overview-of-52478-goodreads-best-b

df = pd.read_csv('books_1.Best_Books_Ever.csv', encoding='unicode_escape', low_memory=False)

# App search fields can only contain lowercase letters, numbers, and underscores
# So if field is camel case, it should be converted to snake case.
columns = list(df.columns)
for i in range(len(columns)):
    col = columns[i]
    for j in range(len(col)):
        if col[j].islower():
            pass
        else:
            col = col[:j] + '_' + col[j].lower() + col[j+1:]
            columns[i] = col

df.columns = columns

# Make json file for indexing
df_json = df.to_json(orient='records', indent=4)
with open('best_books.json', 'w') as f:
    f.write(df_json)

