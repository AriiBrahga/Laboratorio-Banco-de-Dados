-- NOME: ARIELSON DA SILVA BRAGA

------------------------------- SIMULADO ------------------------------------

-- Questão 1

SELECT nome, NVL(TO_CHAR(percentual_comissao), 'Nenhuma Comissão') AS "COMISSÃO"
FROM tb_empregado;

-- Questão 2

SELECT MAX(salario) "Salário Máximo", MIN(salario) "Salário Mínimo", ROUND(AVG(salario)) "Média", SUM(salario) "Somatório"
FROM tb_empregado; 

-- Questão 3

SELECT e.id_gerente, e.salario
FROM tb_empregado e 
LEFT OUTER JOIN tb_empregado g ON (e.id_gerente = g.id_empregado)
WHERE e.salario = (SELECT MIN(salario) 
                   FROM tb_empregado 
                   WHERE id_gerente = g.id_empregado
                   AND salario >= 1000)
AND e.id_gerente IS NOT NULL
ORDER BY e.salario DESC;

-- Questão 4

-- Jeito errado
SELECT COUNT(id_empregado) AS "Empregados Contratados", TO_CHAR(data_admissao, 'YYYY')
FROM tb_empregado
WHERE TO_CHAR(data_admissao, 'YYYY') IN ('1990', '1991', '1992', '1993');

-- Jeito Certo

SELECT
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e) AS "Total Empregados Contratados",
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e WHERE TO_CHAR(e.data_admissao,'YYYY') = '1990') AS "1990",
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e WHERE TO_CHAR(e.data_admissao,'YYYY') = '1991') AS "1991",
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e WHERE TO_CHAR(e.data_admissao,'YYYY') = '1992') AS "1992",
  (SELECT COUNT(e.id_empregado) FROM tb_empregado e WHERE TO_CHAR(e.data_admissao,'YYYY') = '1993') AS "1993"
FROM dual;

-- Questão 5


SELECT  id_empregado || ', '|| nome || ', ' || sobrenome || ', ' || email || ', ' || telefone || ', ' || data_admissao || ', ' || id_funcao || ', ' || salario || ', '|| percentual_comissao || ', ' || id_gerente || ', ' || id_departamento AS "Saída"
FROM tb_empregado;

-- Questão 6

SELECT * 
FROM tb_funcao

SELECT id_funcao,
CASE
  WHEN id_funcao = 'SH_CLERK' THEN 'A'
  WHEN id_funcao = 'ST_MAN' THEN 'B'
  WHEN id_funcao = 'AC_ACCOUNT' THEN 'C'
  WHEN id_funcao = 'AC_MGR' THEN 'D'
  WHEN id_funcao = 'IT_PROG' THEN 'E'
ELSE '0'
END  Grade
FROM tb_funcao
ORDER BY Grade;


-- Questão 7

SELECT nome || sobrenome "Nome Empregado", ROUND((SYSDATE - data_admissao)/30) "Meses Trabalhados" 
FROM tb_empregado
ORDER BY (SYSDATE - data_admissao)/30;


-- Questão 8

SELECT e.nome "Nome Empregado", d.nm_departamento "Nome Departamento", l.cidade "Cidade", l.estado "Estado"
FROM tb_empregado e 
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON (d.id_localizacao = l.id_localizacao)
WHERE e.percentual_comissao IS NOT NULL;

-- Questão 9

-- No usuario SYSTEM

GRANT SELECT, UPDATE, INSERT ON tb_departamento TO Joao WITH ADMIN OPTION;

-- Questão 10


SELECT REPLACE(id_funcao, 'SH', 'SHIPPING')
FROM tb_empregado;



