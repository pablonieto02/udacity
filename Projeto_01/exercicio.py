import csv
import matplotlib.pyplot as plt

# Vamos ler os dados como uma lista
print("Lendo o documento...")
with open("chicago.csv", "r") as file_read:
    reader = csv.reader(file_read)
    data_list = list(reader)

data_list = data_list[1:]

def count_none(data_list, coluna):
    countnone = 0
    for valor in column_to_list(data_list, coluna):
        if valor is None or valor.strip() == '' :
            countnone += 1
    return countnone

def column_to_list(data, index):
    column_list = []
    column_list = [amostra[index] for amostra in data]
    # Dica: Você pode usar um for para iterar sobre as amostras, pegar a feature pelo seu índice, e dar append para uma lista
    return column_list

column_list = column_to_list(data_list, -2)
item_types = []
count_items = []

item_types = set(column_list)
aux = {}
# popula o dicionario com zero
for item in item_types:
    aux[item] = 0
# intera os valores da colula e incrementa o contador conforme indice do dicionario
for item in column_list:
        aux[item] += 1

print(aux)
