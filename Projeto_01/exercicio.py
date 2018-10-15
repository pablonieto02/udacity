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

def count_items(column_list):
    item_types = []
    count_items = []

    item_types = set(column_list)
    item_types.remove('')

    for item in column_list:
        for tipo in item_types:
            if item == tipo:
                
    return item_types, count_items


if answer == "yes":
    # ------------ NÃO MUDE NENHUM CÓDIGO AQUI ------------
    column_list = column_to_list(data_list, -2)
    types, counts = count_items(column_list)
    print("\nTAREFA 12: Imprimindo resultados para count_items()")
    print("Tipos:", types, "Counts:", counts)
    assert len(types) == 3, "TAREFA 12: Há 3 tipos de gênero!"
    assert sum(counts) == 1551505, "TAREFA 12: Resultado de retorno incorreto!"
    # -----------------------------------------------------

column_list = column_to_list(data_list, -2)

teste = set(column_list)
teste.remove('')



print(len(column_list))
