#!/usr/bin/python
# -*- coding: utf8-*-
import random, pymysql, pymysql.cursors, urllib2 
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

def execute():
	try:
		cursor=connection.cursor()
		sql="SELECT `cod_pessoa` FROM `Aluno`"
		#sql="SELECT `cod_pessoa` FROM `Aluno` WHERE `cod_turma`>8" ## Pra 2° escola
		aux=cursor.execute(sql)
		aluno=cursor.fetchall()
		print "### gerador de nomes 1 a 1 demorado 3min ###"
		request = urllib2.Request("http://www.wjr.eti.br/nameGenerator/index.php?q=1&o=plain")
		for  x in range(0, aux):
			y=randint(1,3)
			while y>0:
				y-=1
				response = urllib2.urlopen(request)
				sql = "INSERT INTO `Contato` (`nome`, `cod_aluno`, `telefone`) VALUES (%s , %s, %s)"
				cursor.execute(sql, (response.read(), aluno[x]['cod_pessoa'], ndigitos(11)))
		connection.commit()
	finally:
		connection.close()

execute()