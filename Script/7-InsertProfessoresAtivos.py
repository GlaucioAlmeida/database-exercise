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
		disciplina=1
		while disciplina<12: #de 1 a 11 cod de disciplinas possiveis
			sql="SELECT `cod_professor`, `cod_disciplina` FROM `Ministra` WHERE cod_disciplina=%s and `cod_professor`<200"
			total=cursor.execute(sql, disciplina)
			professores=cursor.fetchall()
			turma=1
			while turma<9: #1 a 8 cod de turmas possiveis para 1º escola
				sql = "INSERT INTO `ProfessoresAtivos` (`cod_professor`, `cod_turma`) VALUES (%s, %s)"
				x=randint(1,total-1)
				cursor.execute(sql, (professores[x]['cod_professor'], turma, (professores[x]['cod_disciplina']))
				turma+=1
			disciplina+=1
		connection.commit()
	finally:
		connection.close()

execute()