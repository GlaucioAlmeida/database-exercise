--##############################--

--#### QUESTAO_1 ####--
SELECT E.nome Escola, C.nome Cidade
FROM Escola E, Cidade C
WHERE E.cod_cidade=C.codigo AND E.codigo NOT IN
	(SELECT DISTINCT E.codigo
	FROM Cidade C, Turma T, Aluno A, Pessoa P
	WHERE (E.cod_cidade=C.codigo AND T.cod_escola=E.codigo AND
	P.codigo=A.cod_pessoa AND A.cod_turma=T.codigo AND P.cod_cidade<>E.cod_cidade))

--#### QUESTAO_2 ####--
SELECT P.nome, A.matricula 
FROM Aluno A, Pessoa P 
WHERE A.cod_pessoa=P.codigo AND 
P.codigo NOT IN (SELECT C.cod_aluno 
				FROM Contato C 
				WHERE A.cod_pessoa=C.cod_aluno)
				
SELECT P.nome, A.matricula 
FROM Aluno A, Pessoa P
WHERE A.cod_pessoa=P.codigo AND 
P.codigo NOT IN (SELECT C.cod_aluno FROM Contato C)

--#### QUESTAO_3 ####--
SELECT T.codigo, T.nome
FROM Turma T, Aluno A
WHERE A.cod_turma=T.codigo 
GROUP BY T.codigo HAVING COUNT(*)>5

--#### QUESTAO_4 ####--
SELECT PA.cod_professor, P.nome, PR.titulo
FROM ProfessoresAtivos PA, Pessoa P, Professor PR
WHERE PA.cod_professor=P.codigo AND P.codigo=PR.cod_pessoa
GROUP BY PA.cod_professor 
HAVING COUNT(DISTINCT PA.cod_turma)>2

--#### QUESTAO_5 ####--
SELECT M.cod_disciplina, COUNT(DISTINCT M.cod_professor) Professores, COUNT(DISTINCT PA.cod_professor) Ativos
FROM Ministra M, ProfessoresAtivos PA
WHERE PA.cod_disciplina=M.cod_disciplina
GROUP BY M.cod_disciplina

--#### QUESTAO_6 ####--
SELECT E.nome Escola, P.nome Diretor
FROM Escola E, Pessoa P
WHERE E.cod_cidade<>P.cod_cidade AND
E.cod_professor=P.codigo

--#### QUESTAO_7 ####--
SELECT T.cod_escola, COUNT(DISTINCT PA.cod_turma) qtd_Turmas, COUNT(DISTINCT PA.cod_professor) qtd_Professores
FROM Turma T, ProfessoresAtivos PA
WHERE PA.cod_turma=T.codigo
GROUP BY T.cod_escola

--#### QUESTAO_8 ####--
SELECT T.cod_escola, 
Round(COUNT(DISTINCT A.cod_pessoa) / COUNT(DISTINCT PA.cod_professor),1) RAZAO_PROFESSOR_POR_ALUNO
FROM Turma T, ProfessoresAtivos PA, Aluno A
WHERE PA.cod_turma=T.codigo AND
A.cod_turma=T.codigo
GROUP BY T.cod_escola

--#### QUESTAO_9 ####--
SELECT A.matricula, P.nome Aluno, C.nome Contato, C.telefone
FROM Contato C, Aluno A, Pessoa P
WHERE P.codigo=A.cod_pessoa AND C.cod_aluno=A.cod_pessoa
ORDER BY A.matricula, C.nome

--#### QUESTAO_10####--
--## DISTINCT se torna opcional ##--
SELECT PA.cod_professor, P.nome
FROM ProfessoresAtivos PA, Pessoa P
WHERE PA.cod_professor=P.codigo
GROUP BY PA.cod_professor 
HAVING COUNT(DISTINCT PA.cod_turma)=1


--###########################################--
--$$$ QUESTOES DE ALTERACOES DO bd_Escola $$$--
--###########################################--

--#### QUESTAO_1####--
UPDATE `Contato` SET cod_aluno=1 WHERE cod_aluno=4

--#### QUESTAO_2####--
DELETE FROM Professor WHERE cod_pessoa = 2;
UPDATE Escola E
SET cod_professor=( SELECT DISTINCT PA.cod_professor
					FROM ProfessoresAtivos PA, Turma T
					WHERE T.codigo=PA.cod_turma and E.codigo=T.cod_escola
					ORDER BY RAND() LIMIT 1) 
where cod_professor IS NULL

--#### QUESTAO_3####--
UPDATE ProfessoresAtivos PA 
SET PA.cod_professor=(SELECT M.cod_professor 
                      FROM Ministra M
                      WHERE M.cod_disciplina=PA.cod_disciplina
                      ORDER BY RAND() LIMIT 1)
WHERE cod_professor=2