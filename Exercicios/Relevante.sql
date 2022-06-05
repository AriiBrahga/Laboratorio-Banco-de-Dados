--- EXERCICIOS QUE CONSIDERO RELEVANTE PARA ESTUDO SQL


--- EXERCICIOS DAS LISTAS
--
-- --- Lista 7
--
-- Ex 1
SELECT e.nome, f.ds_funcao, e.data_admissao
FROM tb_empregado e
INNER JOIN tb_funcao f ON (e.id_funcao = f.id_funcao)
WHERE e.data_admissao BETWEEN '20/02/1987' AND '01/05/1989'
ORDER BY 3 ASC;


-- Ex 4

SELECT e.nome || ' trabalha para ' || NVL(g.nome, 'os acionistas')
FROM tb_empregado e 
LEFT OUTER JOIN tb_empregado g ON(e.id_gerente = g.id_empregado)
ORDER BY g.nome DESC;

--
-- Lista 8
--

-- Ex 2

SELECT nome, sobrenome, SUBSTR(nome, 1, 1) || ' ' || SUBSTR(sobrenome, 1, 10) Nome_Formal 
FROM tb_funcionarios 
WHERE LENGTH(nome) + LENGTH(sobrenome) > 10;

-- Ex 3

SELECT TO_CHAR(data_termino, 'YYYY') "Ano que Parou", 
       id_funcao,
       COUNT(*) "Números de Empregados"
FROM tb_historico_funcao
GROUP BY TO_CHAR(data_termino, 'YYYY'), id_funcao
ORDER BY COUNT(*) ASC;

-- Ex 4

SELECT TO_CHAR(data_admissao, 'DAY') "Data Contratação", COUNT(*)
FROM tb_empregado
GROUP BY TO_CHAR(data_admissao, 'DAY')
HAVING COUNT(*) >= 20;

 

--- DESAFIOS ORACLE

-- Ex 7

SELECT RPAD(nome ||' '|| sobrenome,18)||' '||
       RPAD(' ',salario/1000 +1,'*') Empregados_e_Seus_Salarios
FROM tb_empregado
ORDER BY salario DESC;


--- MEUS PRÓPRIOS ENUNCIADOS

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


