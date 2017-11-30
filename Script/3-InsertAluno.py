#!/usr/bin/python
# -*- coding: utf8-*-

import random, pymysql, pymysql.cursors
from random import randint
from datetime import date

# Connect to the database
connection = pymysql.connect(host='localhost',
                             user='user',
                             password='pass',
                             db='bd_Escola',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

							 

def born():
	year = random.choice(range(1997, 2002))#15 a 20 anos
	month = random.choice(range(1, 13))
	day = random.choice(range(1, 29))
	return date(year, month, day)

def ndigitos(n):
	range_start = 10**(n-1)
	range_end = (10**n)-1
	return randint(range_start, range_end)

def execute():
	try:#total_professores=40
		total_alunos=160
		professores=[]
		cursor=connection.cursor()
		sql="SELECT `cod_pessoa` FROM `Professor`"
		#sql="SELECT `cod_pessoa` FROM `Professor` WHERE `cod_pessoa` > 200" ##PARA 2° escola
		aux=cursor.execute(sql)
		result=cursor.fetchall()
		for  x in range(0, aux):
			professores.append(result[x]['cod_pessoa'])
		#############################################################
		pessoas=[]
		x=[0,0,0,0,0,0,0,0]
		#x=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] # 32 turmas para 2° escola
		while total_alunos>0:
			pos=randint(0,7) #pos=randint(0,31) turmas para 2° escola
			if x[pos]<21:#20 alunos por turma
			#if x[pos]<6:#6 alunos por turma para 2° escola
				x[pos]+=1
				total_alunos-=1
				p=randint(1,200)## randint(201,400) range para 2º escola de um total de 400 divididas pra 2 escolas
				while (p in pessoas) or (p in professores):
					p=randint(1,200)
				sql = "INSERT INTO `Aluno` (`cod_pessoa`, `matricula`, `dt_nascimento`, `cod_turma`) VALUES (%s , %s, %s, %s)"
				cursor.execute(sql, (p, ndigitos(6), born(), pos+1))#pos+9)) pra 2° escola
				pessoas.append(p)

		connection.commit()
	finally:
		connection.close()

execute()