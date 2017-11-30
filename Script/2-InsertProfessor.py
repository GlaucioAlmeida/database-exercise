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
		titulo=['Mestrado em ','Doutorado em ', 'Bacharel em ']
		cursor=connection.cursor()
		pessoas=[]
		for line in lista.splitlines():
			count=0
			while(count<4):
				p=randint(1,200) ## randint(201,400) range para 2º escola de um total de 400 pessoas divididas pra 2 escolas
				while p in pessoas:
					p=randint(1,200)
				sql = "INSERT INTO `Professor` (`cod_pessoa`, `rg`, `cpf`, `titulo`) VALUES (%s , %s, %s, %s)"
				cursor.execute(sql, (p, ndigitos(9), ndigitos(11), titulo[randint(0,2)]+line))
				pessoas.append(p)
				count+=1
		connection.commit()
	finally:
		connection.close()
x="""Português
Matemática
Geografia
História
Física
Química
Sociologia
Filosofia
Biologia
Anarquia"""
execute(x)