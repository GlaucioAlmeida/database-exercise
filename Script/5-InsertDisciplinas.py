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

def execute(lista):
	try:
		titulo=['Mestrado em ','Doutorado em ', 'Bacharel em ']
		cursor=connection.cursor()
		pessoas=[]
		for line in lista.splitlines():
			sql = "INSERT INTO `Disciplina` (`nome`) VALUES (%s)"
			cursor.execute(sql, (line))
		connection.commit()
	finally:
		connection.close()
x="""Português
Literatura
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