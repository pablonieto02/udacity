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

def count_user_type(data_list):
    customer = 0
    subscriber = 0
    for user_type in column_to_list(data_list, -3):
        if user_type == 'Customer':
            customer += 1
        elif user_type == 'Subscriber':
            subscriber += 1
    return [customer, subscriber]

def count_items(column_list):
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

    count_items = [valor for valor in aux.values()]

    return item_types, count_items

print(count_items(column_to_list(data_list, -3)))

print(count_user_type(data_list))
