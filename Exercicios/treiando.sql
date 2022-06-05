-- Fazendo todas as listas de SQL

-- NP2

-- 1

SELECT nome, NVL(TO_CHAR(percentual_comissao), 'Nenhuma comissao') as "COMISSÃO"
FROM tb_empregado;

-- 2

SELECT MAX(salario) Maximo, MIN(salario) Minimo, AVG(salario) Media, SUM(salario) Somatoria
FROM tb_empregado;

-- 3
SELECT e.id_gerente, e.salario
FROM tb_empregado e 
LEFT OUTER JOIN tb_empregado g ON (e.id_gerente = g.id_empregado)
WHERE e.salario = (SELECT MIN(salario) 
                   FROM tb_empregado 
                   WHERE id_gerente = g.id_empregado
                   AND salario >= 1000)
AND e.id_gerente IS NOT NULL
ORDER BY e.salario DESC;

SELECT id_gerente, MIN(salario)
FROM tb_empregado
WHERE id_gerente IS NOT NULL
GROUP BY id_gerente
HAVING salario >= 1000
ORDER BY MIN(salario) DESC;

-- 4


SELECT COUNT(id_empregado) AS "Total Empregados",
SUM(DECODE(TO_CHAR(data_admissao, 'YYYY'),'1990', 1, 0)) "1990",
SUM(DECODE(TO_CHAR(data_admissao, 'YYYY'),'1991', 1 ,0)) "1991",
SUM(DECODE(TO_CHAR(data_admissao, 'YYYY'),'1992', 1 ,0)) "1992",
SUM(DECODE(TO_CHAR(data_admissao, 'YYYY'),'1993', 1 ,0)) "1993"
FROM tb_empregado;

SELECT 
    (SELECT COUNT(id_empregado) FROM tb_empregado) AS "TOTAL",
    (SELECT COUNT(id_empregado) FROM tb_empregado WHERE TO_CHAR(data_admissao, 'YYYY') = '1990') AS "1990",
    (SELECT COUNT(id_empregado) FROM tb_empregado WHERE TO_CHAR(data_admissao, 'YYYY') = '1991')AS "1991",
    (SELECT COUNT(id_empregado) FROM tb_empregado WHERE TO_CHAR(data_admissao, 'YYYY') = '1992')AS "1992",
    (SELECT COUNT(id_empregado) FROM tb_empregado WHERE TO_CHAR(data_admissao, 'YYYY') = '1993')AS "1993"
FROM dual;

-- 5


SELECT  id_empregado || ', '|| nome || ', ' || sobrenome || ', ' || email || ', ' || telefone || ', ' || data_admissao || ', ' || id_funcao || ', ' || salario || ', '|| percentual_comissao || ', ' || id_gerente || ', ' || id_departamento AS "Saída"
FROM tb_empregado;

-- 6

SELECT id_funcao,
CASE
    WHEN id_funcao = 'SH_CLERK' THEN 'A'
    WHEN id_funcao = 'ST_MAN' THEN 'B'
    WHEN id_funcao = 'AC_ACCOUNT' THEN 'C'
    WHEN id_funcao = 'AC_MGR' THEN 'D'
    WHEN id_funcao = 'IT_PROG' THEN 'E'
    ELSE '0'
END AS "Grade"
FROM tb_empregado;

-- 7

SELECT nome, MOTHS_BETWEEN(SYSDATE, data_admissao) as "Meses Trabalhados"
FROM tb_empregado
ORDER BY MOTHS_BETWEEN(SYSDATE, data_admissao);

-- 8

SELECT e.nome "Nome Empregado", d.nm_departamento "Nome Departamento", l.cidade "Cidade", l.estado "Estado"
FROM tb_empregado e 
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON (d.id_localizacao = l.id_localizacao)
WHERE e.percentual_comissao IS NOT NULL;

-- 9

-- SYSTEM DO ORACLE
GRANT UPDATE ON tb_departamento TO Joao WITH GRANT OPTION;

-- USUARIO JOAO

SELECT *
FROM user_privs;

-- 10

SELECT REPLACE(id_funcao, 'SH', 'SHIPPING')
FROM tb_empregado
WHERE id_funcao LIKE 'SH%';



------------------- FAZENDO A LISTA 8


SELECT nome, sobrenome
FROM tb_clientes 
WHERE LOWER(nome) LIKE '%li%';

-- 2

SELECT nome ||' ' || sobrenome,
CASE 
    WHEN LENGTH(nome||sobrenome) > 10 THEN SUBSTR(nome, 1,1) || ' ' || SUBSTR(sobrenome, 1, 10) 
    ELSE nome || ' ' || sobrenome
END AS "Nome Formal"
FROM tb_empregado;

-- 3

SELECT COUNT(id_empregado), id_funcao, data_termino
FROM tb_historico_funcao
GROUP BY data_termino 
ORDER BY COUNT(id_empregado) ASC;

-- 4

SELECT TO_CHAR(data_admissao, 'Day') "Dia da Semana", COUNT(id_empregado) "Contratados"
FROM tb_empregado
GROUP BY TO_CHAR(data_admissao, 'Day') 
HAVING COUNT(id_empregado) >= 20; 

------------------- FAZENDO A LISTA 7

-- 1

SELECT e.nome, f.ds_funcao, e.data_admissao
FROM tb_empregado e, tb_funcao f 
WHERE e.id_funcao = f.id_funcao
AND e.data_admissao BETWEEN '20/02/1987' AND '01/05/1989'
ORDER BY e.data_admissao ASC;

-- 2

SELECT UPPER(e.nome) "Nome", LENGTH(e.sobrenome) "Sobrenome", d.nm_departamento, p.nm_pais
FROM tb_empregado e 
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON (d.id_localizacao = l.id_localizacao)
INNER JOIN tb_pais p ON (l.id_pais = l.id_pais)
WHEN e.nome LIKE 'B%'
OR e.nome LIKE 'L%' 
OR e.nome LIKE 'A%';

SELECT UPPER(nome) "Nome em Maiúsculo",
       LENGTH(sobrenome) "Comprimento Sobrenome",
       d.nm_departamento "Nome Depto", p.nm_pais "Nome País"
FROM tb_empregado e
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON (d.id_localizacao = l.id_localizacao)
INNER JOIN tb_pais p ON (l.id_pais = p.id_pais)
WHERE e.nome LIKE 'B%'
OR e.nome LIKE 'L%'
OR e.nome LIKE 'A%';

---


--- ENUNCIADO
-- FAÇA UMA CONSULTA em que mostre o nome do empregado completo, a descrição de sua funcao e o seu tempo trabalhado na empresa,
-- orderne de pelo nome de maneira ascendente. 

SELECT e.nome || ' ' || e.sobrenome, f.ds_funcao, TO_CHAR(SYSDATE - e.data_admissao, 'DD-MM-YYYY')
FROM tb_empregado e 
INNER JOIN tb_funcao f ON (e.id_funcao = f.id_funcao)
ORDER BY e.nome ASC;

-- Elabore uma consulta em que exiba a media salarial dos empregados geridos por cada gerente, onde o gerente não pode ser nulo
-- orderne o salario de maneira decrescente

SELECT id_gerente, AVG(salario)
FROM tb_empregado
WHERE id_gerente IS NOT NULL
GROUP BY id_gerente
ORDER BY AVG(salario) DESC;

-- Voce como um administrador do banco deseja conceder ao seu empregado carlos uma permissão no banco, para fazer consultas, atualizar e inserir dados na tabela empregado. Qual comando voce utilizaria?

GRANT SELECT, UPDATE, INSERT ON tb_empregado TO carlos;


-- Elabore uma consulta para exibir o total de empregados em cada função.

SELECT COUNT(id_empregado), id_funcao
FROM tb_empregado
GROUP BY id_funcao;

-- Selecione todos os empregados que possuam o salario superior a 1000 e que moram nos USA

SELECT e.id_empregado ,e.nome, e.salario, p.nm_pais
FROM tb_empregado e 
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON (d.id_localizacao = l.id_localizacao)
INNER JOIN tb_pais p ON (l.id_pais = p.id_regiao) 


-- Sabendo que a formula do triangulo quadrado é x^2 = a^2 + b^2:
-- Calcule a hipotenusa sabendo que os lados medem 2 e 3

SELECT SQRT( 2 * 2 + 3 * 3)
FROM dual;

-- Uma empresa deseja saber quais funcionarios recebem comissao e qual a sua função na empresa e quando esse empregado foi contratado.

SELECT id_empregado, id_funcao, data_admissao
FROM tb_empregado 

WHERE percentual_comissao IS NOT NULL;
-- Uma empresa quer consultar todos os seus empregados e quanto de comissão eles recebem, caso o empregado não receba comissão coloque que não recebem comissao 

SELECT id_empregado, nome, NVL(to_char(percentual_comissao), 'Nao possui comissao') AS "Comissao"
FROM tb_empregado;

-- Mostre o nome dos funcionarios que trabalhem no departamento 50, ou que tenham o gerente com o id 103 
SELECT id_empregado, nome, id_departamento, id_gerente
FROM tb_empregado
WHERE id_departamento = 50 OR id_gerente = 103;

-- A empresa deseja fazer uma consulta no id_funcao dos empregados trocando os id que começam em 'IT' para 'TEC', ordene pelo id_empregado

SELECT id_empregado, REPLACE(id_funcao, 'IT', 'TEC') AS "Funcão" 
FROM tb_empregado 
ORDER BY id_empregado;

-- faça uma consulta que mostre o nome dos funcionarios completo e localize em que posição fica a primeira e segunda letra 'a'.

SELECT nome || ' ' || sobrenome, INSTR(LOWER(nome || ' ' || sobrenome),'a' ,1,2 ) 
FROM tb_empregado;

-- SUBCONSULTAS

SELECT sobrenome, id_departamento, salario
FROM tb_empregado
WHERE id_departamento, salario = (SELECT id_departamento, salario
                                  FROM tb_empregado e
                                  WHERE percentual_comissao IS NOT NULL
                                  AND e.salario = salario
                                  AND e.id_departamento = id_departamento);


-- 

SELECT e.sobrenome, d.nm_departamento, e.salario 
FROM tb_empregado e
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
WHERE (salario, NVL(percentual_comissao)) IN (SELECT salario, NVL(percentual_comissao)
                                              FROM tb_empregado
                                              WHERE id_empregado = 1700);

--

SELECT e.sobrenome, e.salario
FROM tb_empregado e 
WHERE (e.salario, e.percentual_comissao) IN (SELECT salario, percentual_comissao 
                                             FROM tb_empregado
                                             WHERE nome = 'Kochhar');

-- 


SELECT e.id_empregado, e.nome , e.sobrenome , e.id_departamento, l.cidade
FROM tb_empregado e
INNER JOIN tb_departamento d ON(e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON(d.id_localizacao = l.id_localizacao)
WHERE id_empregado IN (SELECT id_empregado
                      FROM tb_empregado e 
                      INNER JOIN tb_departamento d USING(id_departamento)
                      INNER JOIN tb_localizacao l USING(id_localizacao)
                      WHERE l.cidade LIKE 'T%'
                      );


--


SELECT id_empregado
FROM tb_empregado
WHERE salario > (SELECT salario
                 FROM tb_empregado
                 WHERE id_funcao = 'SA_MAN')
ORDER BY salario DEC;



-- Desafio oracle

-- 1

SELECT e.nome || ' trabalha para ' || d.nm_departamento || ' localizado na cidade ' || l.cidade || ' estado ' || l.estado || ' país ' || p.nm_pais AS "Informação dos Empregados"
FROM tb_empregado e 
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON (d.id_localizacao = l.id_localizacao)
INNER JOIN tb_pais p ON (l.id_pais = l.id_pais)
ORDER BY nome ASC;


-- 2

SELECT nome || ' ' || sobrenome 
FROM tb_empregado
WHERE LOWER(nome) LIKE 'e_____e'
AND id_departamento = 80
OR id_gerente = 148;

-- 3

SELECT NVL(g.nome, 'Os Acionistas') || ' gerencia ' || e.nome
FROM tb_empregado e 
LEFT OUTER JOIN tb_empregado g ON (e.id_gerente = g.id_empregado)
ORDER BY g.nome DESC;


-- 4

SELECT sobrenome, SYSDATE - data_admissao
FROM tb_empregado
WHERE  id_departamento = 80
AND (SYSDATE - data_admissao) > 5000

-- 5
SELECT e.id_empregado ,e.nome || ' ' || e.sobrenome as "Nome Completo", f.ds_funcao, e.data_admissao
FROM tb_empregado e
INNER JOIN tb_funcao f ON(e.id_funcao = f.id_funcao);

-- 6


SELECT  id_empregado || ', '|| nome || ', ' || sobrenome || ', ' || email || ', ' || telefone || ', ' || data_admissao || ', ' || id_funcao || ', ' || salario || ', '|| percentual_comissao || ', ' || id_gerente || ', ' || id_departamento AS "Saída"
FROM tb_empregado;

-- 7

SELECT nome || ' ' || sobrenome, RPAD(' ',salario/1000 +1, '*') AS "Empregados e Seus Salários"
FROM tb_empregado
ORDER BY RPAD(' ',salario/1000 +1, '*') DESC;