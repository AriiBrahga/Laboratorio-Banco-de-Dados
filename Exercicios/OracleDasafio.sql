-- Exercicio 1

SELECT e.nome || ' trabalha para ' || d.nm_departamento
      || ' localizado na cidade ' || l.cidade
      || ' estado ' || l.estado || ' pais '
      || p.nm_pais "Informação dos Empregados"

FROM tb_empregado e
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON (d.id_localizacao = l.id_localizacao)
INNER JOIN tb_pais p ON (l.id_pais = p.id_pais)
ORDER BY 1 ASC;


-- Exericio 2

SELECT nome || '' || sobrenome
FROM tb_empregado
WHERE LOWER(nome) LIKE 'e______e%'
AND id_departamento = 80
OR  id_gerente = 148;

-- Exercicio 3

SELECT NVL(g.nome, 'Os acionistas') || ' gerencia ' || e.nome 
FROM tb_empregado e
RIGHT OUTER JOIN tb_empregado g ON(e.id_empregado = g.id_empregado)
ORDER BY g.nome DESC;

-- EXERCICIO 04

SELECT sobrenome, 
  ROUND((SYSDATE - data_admissao), 0) AS "Numero de Dias Trabalhado"
FROM tb_empregado
WHERE id_departamento = 80
AND ROUND((SYSDATE - data_admissao),0) > 5000;


-- EXERCICIO 5

DESCRIBE tb_empregado;

--SET ECHO OFF
--SET VERIFY OFF

--SELECT e.id_empregado ,e.nome || ' ' || e.sobrenome, f.ds_funcao, e.data_admissao 
--FROM tb_empregado e
--INNER JOIN tb_funcao f ON (e.id_funcao = f.id_funcao)
--ORDER BY e.id_empregado;
--

@\home\oracle\Desktop\ExercicioSQL\item_5.sql

-- EXERCICIO 6

SELECT id_empregado||', ' || nome ||', ' || sobrenome || ', ' || email|| ',' ||telefone|| ', '|| data_admissao|| ', ' ||id_funcao ||', ' ||
       salario ||', '|| percentual_comissao ||', ' ||id_gerente||', ' || id_departamento AS "SAIDA" 
FROM tb_empregado;


-- EXERCICIO 7

SELECT RPAD(nome ||' '|| sobrenome,18)||' '||
       RPAD(' ',salario/1000 +1,'*') Empregados_e_Seus_Salarios
FROM tb_empregado
ORDER BY salario DESC;


-- EXERCICIO 8

--SELECT 'O departamento ' || nm_departamento || ' possui ' ||  
&qtd_empregado = 0;

SELECT 'O departamento ' || nm_departamento || ' possui ' ||  COUNT(e.ROWID) || ' empregados alocados '
AS "Informação dos Deptos"
FROM tb_departamento d
INNER JOIN tb_empregado e ON(d.id_departamento = e.id_departamento)
GROUP BY nm_departamento
ORDER BY d.nm_departamento DESC;

