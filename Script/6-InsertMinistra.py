#!/usr/bin/python
# -*- coding: utf8-*-
import random, pymysql, pymysql.cursors
from random import randint

# Connect to the database
connection = pymysql.connect(host='localhost',
                             user='user',
                             password='pass',
                             db='bd_Escola',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

def execute():
	try:
		cursor=connection.cursor()
		#### Relação de professores e a disciplina que um determinado ###
		######## professor pode ministrar de acordo com sua titulação ###
		sql="""SELECT P.cod_pessoa, D.codigo cod_disciplina
				FROM `Disciplina` D, `Professor` P
				WHERE (P.titulo = Concat("Mestrado em ",  D.nome) or
						P.titulo = Concat("Doutorado em ",  D.nome) or
						P.titulo = Concat("Bacharel em ",  D.nome)) ORDER BY D.nome"""
		#################################################################
		#Professores que ministram a disciplina 1(portugues) podem ministrar a 2(literatura) também
		#sql="""SELECT 2 `cod_disciplina`, `cod_professor` FROM `Ministra` WHERE cod_disciplina=1"""
		
		count=cursor.execute(sql)
		professores=cursor.fetchall()
		index=0
		while index<count:
			sql = "INSERT INTO `Ministra` (`cod_disciplina`, `cod_professor`) VALUES (%s , %s)"
			cursor.execute(sql, (professores[index]['cod_disciplina'], professores[index]['cod_pessoa']))
				
			index+=1
		connection.commit()
	finally:
		connection.close()

execute()