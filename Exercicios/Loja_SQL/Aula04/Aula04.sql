-- JOIN

SELECT tb_produtos.nm_produto,
       tb_tipos_produtos.nm_tipo_produto
FROM tb_produtos, tb_tipos_produtos
WHERE tb_produtos.id_tipo_produto = tb_tipos_produtos.id_tipo_produto
AND tb_produtos.id_produto = 3;

SELECT tb_produtos.nm_produto,
       tb_tipos_produtos.nm_tipo_produto
FROM tb_produtos, tb_tipos_produtos
WHERE tb_produtos.id_tipo_produto = tb_tipos_produtos.id_tipo_produto
ORDER BY tb_produtos.nm_produto;

SELECT p.nm_produto, tp.nm_tipo_produto
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto = tp.id_tipo_produto
ORDER BY p.nm_produto;

SELECT p.id_tipo_produto, tp.id_tipo_produto
FROM tb_produtos p, tb_tipos_produtos tp;

SELECT c.nome,c.sobrenome, p.nm_produto AS produto,
       tp.nm_tipo_produto AS tipo
FROM tb_cliente c, tb_compras co, tb_produtos p, tb_tipos_produtos tp
WHERE c.id_cliente = co.id_cliente AND
      p.id_produto = co.id_produto AND
      p.id_tipo_produto = tp.id_tipo_produto
ORDER BY p.nm_produto;

SELECT *
FROM tb_grades_salarios;

SELECT f.nome, f.sobrenome, f.cargo, f.salario, gs.id_salario
FROM tb_funcionarios f, tb_grades_salarios gs
WHERE f.salario BETWEEN gs.base_salario AND gs.teto_salario
ORDER BY gs.id_salario;

-- JOINS-EXTERNAS
-- AS JOINS EXTERNAS QUE VOCE DESEJA SABER VOCE TEM Q COLOCAR O OPERADOR DE JUNÇÃO EXTERNA NO LADO OPOSTO

SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto = tp.id_tipo_produto (+)
ORDER BY 1;

SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto(+) = tp.id_tipo_produto 
ORDER BY 1;

-- NÃO É POSSIVEL FAZER
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p, tb_tipos_produtos tp
WHERE p.id_tipo_produto(+) = tp.id_tipo_produto 
OR p.id_tipo_produto = 1;


-- Seleciona os Funcionarios e Indica pra quem eles trabalham
SELECT f.nome || ' ' || f.sobrenome || ' trabalha para ' || g.nome
FROM tb_funcionarios f, tb_funcionarios g
WHERE f.id_gerente = g.id_funcionario
ORDER BY f.nome;

-- O codigo acima mostra os funcionarios que trabalham para os gerentes, mas não mostra o valor nulo, assim
-- excluindo um nome, utilizando esse comando abaixo, é mostrado todos.
SELECT f.nome ||' trabalha para ' ||  NVL(g.sobrenome, 'os acionistas') 
FROM tb_funcionarios f, tb_funcionarios g
WHERE f.id_gerente = g.id_funcionario(+)
ORDER BY f.sobrenome DESC;

SELECT p.nm_produto AS PRODUTO, tp.nm_tipo_produto AS TIPO
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp ON (p.id_produto = tp.id_tipo_produto)
ORDER BY p.nm_produto;

SELECT f.nome, f.sobrenome, f.cargo, f.salario, gs.id_salario
FROM tb_funcionarios f
INNER JOIN tb_grades_salarios gs ON(f.salario BETWEEN gs.base_salario
                                    AND gs.teto_salario)
ORDER BY gs.id_salario;

SELECT p.nm_produto AS PRODUTO, tp.nm_tipo_produto AS TIPO
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp
USING (id_tipo_produto);

SELECT p.nm_produto AS PRODUTO,
       tp.nm_tipo_produto AS TIPO, id_tipo_produto
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp
USING (id_tipo_produto);

-- ERRO

SELECT p.nm_produto AS PRODUTO,
       tp.nm_tipo_produto AS TIPO, id_tipo_produto
FROM tb_produtos p
INNER JOIN tb_tipos_produtos tp
USING (p.id_tipo_produto);

SELECT c.nome, c.sobrenome, p.nm_produto AS produto,
       tp.nm_tipo_produto AS tipo
FROM tb_cliente c
INNER JOIN tb_compras co USING (id_cliente)
INNER JOIN tb_produtos p USING (id_produto)
INNER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

-- EXEMPLO DE JOIN LEFT OUTER JOIN utilizando o (SQL/92)
-- REALIZA UMA JOIN EXTERNA ESQUERDA
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p
LEFT OUTER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;

-- EXEMPLO DE JOIN RIGHT OUTER JOIN utilizando o (SQL/92)
-- REALIZA UMA JOIN EXTERNA DIREITA
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p
RIGHT OUTER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;


-- EXEMPLO DE JOIN FULL OUTER JOIN utilizando o (SQL/92)
-- REALIZA UMA JOIN EXTERNA INTEGRAL
SELECT p.nm_produto AS produto, tp.nm_tipo_produto AS tipo
FROM tb_produtos p
FULL OUTER JOIN tb_tipos_produtos tp USING (id_tipo_produto)
ORDER BY p.nm_produto;


-- INNER JOIN no SQL/92

SELECT f.nome || ' ' || f.sobrenome || ' trabalha para ' || g.nome
FROM tb_funcionarios f
INNER JOIN tb_funcionarios g ON(f.id_gerente = g.id_funcionario)
ORDER BY f.nome;

-- CRUZANDO TABELAS (PLANO CARTESIANO)
SELECT *
FROM tb_tipos_produtos
CROSS JOIN tb_produtos;

-- CRIANDO VARIÁVEIS
-- VARIAVEL TEMPORARIA

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto = &v_id_produto;

SELECT nm_produto, &v_coluna
FROM &v_tabela
WHERE &v_coluna = &v_id_produto;

SELECT nm_produto, &&v_coluna
FROM &v_tabela
WHERE &&v_coluna = &v_id_produto;

-- VARIAVEL DEFINIDAS

DEFINE v_id_produto = 7;

SELECT nm_produto, id_produto
FROM tb_produtos
WHERE id_produto = &v_id_produto;

-- VARIAVEL DEFINDA - USANDO ACCEPT

ACCEPT v_id NUMBER FORMAT 99 PROMPT 'Entre com o ID';

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto = &v_id;

-- VARIAVEL DEFINIDA - USANDO O UNDEFINE


DEFINE v_id_produto = 7;

SELECT nm_produto, id_produto
FROM tb_produtos
WHERE id_produto = &v_id_produto;

UNDEFINE v_id_produto;


-- CHAMANDO UM SCRIPT CRIADO

@ \home\oracle\teste_1.sql

@ \home\oracle\teste_2.sql

@ \home\oracle\teste_3.sql 2

@ \home\oracle\teste_3.sql 6 19.99


SELECT 'DROP TABLE ' || table_name || ';'
FROM user_tables;
