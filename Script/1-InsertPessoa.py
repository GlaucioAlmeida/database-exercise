#!/usr/bin/python
# -*- coding: utf8-*-

import pymysql, pymysql.cursors
from random import randint
# Connect to the database
connection = pymysql.connect(host='localhost',
                             user='user',
                             password='pass',
                             db='bd_Escola',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

def ndigitos(n):
	range_start = 10**(n-1)
	range_end = (10**n)-1
	return randint(range_start, range_end)

def execute(lista):
	try:
		cursor=connection.cursor()
		for line in lista.splitlines():
			#print(line)
			sql = "INSERT INTO `Pessoa` (`nome`, `telefone`, `cod_cidade`) VALUES (%s, %s, (SELECT FLOOR(1 + (RAND() * 2))))"
			cursor.execute(sql, (line, ndigitos(11)))
		connection.commit()
	finally:
		connection.close()

#***Lista gerada em http://www.wjr.eti.br/nameGenerator/index.php?q=10&o=plain
x="""Acacio Canário
Adolfo Marrero
Anind Antas
Anind Macena
Apuã Franco
Armando Pestana
Armindo Pederneiras
Arnaldo Varanda
Aurélia Madeira
Belmifer Manso
Benedito Mansilla
(...) """

execute(x)