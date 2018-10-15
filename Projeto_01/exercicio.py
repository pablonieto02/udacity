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
    for amostra in data:
        column_list.append(amostra[index])
    # Dica: Você pode usar um for para iterar sobre as amostras, pegar a feature pelo seu índice, e dar append para uma lista
    return column_list

answer = "yes"

start_stations = set(column_to_list(data_list, 3))

def count_items(column_list):
    item_types = []
    count_items = []

    item_types = set(column_list)
    aux = {}

    for item in item_types:
        aux[item] = 0

    for item in column_list:
        if item in aux:
            aux[item] += 1

    for item in aux.values():
        count_items.append(item)

    return item_types, count_items

if answer == "yes":
    # ------------ NÃO MUDE NENHUM CÓDIGO AQUI ------------
    column_list = column_to_list(data_list, -2)
    types, counts = count_items(column_list)

    print("Tipos:", len(types), "Counts:", sum(counts))
    assert len(types) == 3, "TAREFA 12: Há 3 tipos de gênero!"
    assert sum(counts) == 1551505, "TAREFA 12: Resultado de retorno incorreto!"
    # -----------------------------------------------------
