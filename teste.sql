-- Lista 5
-- Ex1
SELECT 'O identificador da ' || ds_funcao || ' é o ID: ' || id_funcao AS "Descrição da Função"
FROM tb_funcao;

-- Ex2

SELECT (22/7) * 6000 * 6000 AS "Área"
FROM dual;

-- Ex3

SELECT nm_departamento 
FROM tb_departamento
WHERE nm_departamento LIKE('%ing');

-- Ex4

SELECT ds_funcao, base_salario, teto_salario - base_salario AS "Diferença"
FROM tb_funcao
WHERE ds_funcao LIKE('Presidente%') 
OR ds_funcao  LIKE('%Gerente%')
ORDER BY teto_salario - base_salario DESC, ds_funcao ASC; 

-- Ex5

DEFINE &v_alquota = 5

SELECT id_empregado, nome, salario, salario * 12 "Salario Anual", &v_alquota, (salario * 12) * &v_alquota
FROM tb_empregado;

SELECT id_empregado, nome, salario, salario * 12 "Salario Anual", 5, (salario * 12) * 5
FROM tb_empregado;


-- Lista 6

CREATE TABLE tb_mulher(
id_mulher           NUMBER CONSTRAINT m_id_mulher NOT NULL,
nome_mulher         VARCHAR2(40),

CONSTRAINT pk_id_mulher PRIMARY KEY(id_mulher)
);

CREATE TABLE tb_homem(
id_homem             NUMBER CONSTRAINT h_id_homem NOT NULL,
nome_homem           VARCHAR2(40),
id_mulher            NUMBER,

CONSTRAINT pk_id_homem PRIMARY KEY(id_homem),
CONSTRAINT fk_id_mulher FOREIGN KEY(id_mulher)
            REFERENCES tb_mulher(id_mulher)
);

-- Ex1 E Ex2


INSERT INTO tb_mulher
VALUES (1, 'Edna');


INSERT INTO tb_mulher
VALUES (2, 'Stefanny');

INSERT INTO tb_mulher
VALUES (3, 'Cássia');

SELECT *
FROM tb_mulher
ORDER BY 1;

INSERT INTO tb_homem
VALUES (10, 'Anderson', NULL);

INSERT INTO tb_homem
VALUES (20, 'Jander', 1);

INSERT INTO tb_homem
VALUES (30, 'Rogério', 2);

SELECT *
FROM tb_homem
ORDER BY 1;

-- Ex3

--a
SELECT h.nome_homem || ' casado com ' || h.nome_mulher AS Casamento
FROM tb_homem h
INNER JOIN tb_mulher m  ON (h.id_mulher = m.id_mulher);

--b

SELECT *
FROM tb_homem
NATURAL JOIN tb_mulher;

-- c

SELECT h.nome_homem || ' casado com ' || h.nome_mulher AS Casamento
FROM tb_homem h
INNER JOIN tb_mulher m  USING (h.id_mulher = m.id_mulher);

-- d

SELECT id_homem, h.nome_homem || ' casado com ' || m.nome_mulher AS Casamento
FROM tb_homem h
INNER JOIN tb_mulher m ON (h.id_mulher = m.id_mulher)
ORDER BY h.nome_homem;

-- e

SELECT nome_homem, nome_mulher
FROM tb_homem
CROSS JOIN tb_mulher
ORDER BY nome_homem;

-- 4

-- a 

SELECT h.nome_homem || ' casado ' || NVL(m.nome_mulher, ' com ninguem')
FROM tb_homem h
LEFT OUTER JOIN tb_mulher m ON (h.id_mulher = m.id_mulher)
ORDER BY h.nome_homem;

-- b 

SELECT m.nome_mulher || ' casada ' || NVL(h.nome_homem,  ' com ninguem')
FROM tb_homem h
RIGHT OUTER JOIN tb_mulher m ON (h.id_mulher = m.id_mulher)
ORDER BY h.nome_homem;

-- c 
SELECT h.nome_homem || ' casado ' || NVL(m.nome_mulher, ' com ninguem')
FROM tb_homem h
LEFT OUTER JOIN tb_mulher m ON (h.id_mulher = m.id_mulher)
ORDER BY h.nome_homem;

-- d

SELECT m.nome_mulher || ' casada ' || NVL(h.nome_homem,  ' com ninguem')
FROM tb_homem h
RIGHT OUTER JOIN tb_mulher m ON (h.id_mulher = m.id_mulher)
ORDER BY h.nome_homem;

-- e - 
SELECT m.nome_mulher || ' casada ' || NVL(h.nome_homem,  ' com ninguem')
FROM tb_homem h
RIGHT OUTER JOIN tb_mulher m USING (id_mulher)
ORDER BY h.nome_homem;

SELECT h.nome_homem || ' casado ' || NVL(m.nome_mulher, ' com ninguem')
FROM tb_homem h
LEFT OUTER JOIN tb_mulher m ON (h.id_mulher = m.id_mulher)
ORDER BY h.nome_homem;

-- f - 
SELECT NVL(h.nome_homem,  ' Ninguem') || ' casado ' || NVL(m.nome_mulher, ' com ninguem')
FROM tb_homem h
FULL OUTER JOIN tb_mulher m ON (h.id_mulher = m.id_mulher)
ORDER BY h.nome_homem;

-- g - 
SELECT NVL(h.nome_homem,  ' Ninguem') || ' casado ' || NVL(m.nome_mulher, ' com ninguem')
FROM tb_homem h
FULL OUTER JOIN tb_mulher m USING (id_mulher)
ORDER BY h.nome_homem;




-- 7

-- 1

SELECT e.nome, f.ds_funcao, e.data_admissao
FROM tb_empregado e
INNER JOIN tb_funcao f ON (e.id_funcao = f.id_funcao)
WHERE e.data_admissao BETWEEN '20-Feb-1987' AND '01-May-1989'
ORDER BY e.data_admissao ASC;

SELECT data_admissao
FROM tb_empregado 
ORDER BY data_admissao ASC;

-- 2 

SELECT UPPER(e.nome), LENGTH(e.sobrenome), d.nm_departamento, p.nm_pais
FROM tb_empregado e
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON (d.id_localizacao = l.id_localizacao)
INNER JOIN tb_pais p ON (l.id_pais = p.id_pais)
WHERE SUBSTR(UPPER(e.nome),1,1) IN ('B', 'L', 'A')
ORDER BY UPPER(e.nome) ASC;


-- 3 

SELECT e.nome, d.nm_departamento, l.cidade, l.estado
FROM tb_empregado e
INNER JOIN tb_departamento d ON (e.id_departamento = d.id_departamento)
INNER JOIN tb_localizacao l ON (d.id_localizacao = l.id_localizacao)
WHERE e.percentual_comissao IS NOT NULL
ORDER BY e.nome;


-- 4

SELECT e.nome || ' trabalha para ' || NVL(g.nome, ' Os acionistas')
FROM tb_empregado e
LEFT OUTER JOIN tb_empregado g ON (e.id_gerente= g.id_empregado)
ORDER BY g.nome DESC;


-- 5 


CREATE OR REPLACE PROCEDURE sp_get_emp( p_id INTEGER)

AS

v_saida VARCHAR2(255);
v_controle NUMBER;

BEGIN
    SELECT COUNT(id_empregado) INTO v_controle FROM tb_empregado WHERE id_empregado = p_id;
    IF(v_controle > 0 ) THEN

        SELECT 'Nome: ' || e.nome || ' ' || e.sobrenome || ' Função: ' || f.ds_funcao INTO v_saida
        FROM tb_empregado e
        INNER JOIN tb_funcao f ON (e.id_funcao = f.id_funcao) 
        WHERE e.id_empregado = p_id;

        DBMS_OUTPUT.PUT_LINE(v_saida);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Empregado ' || p_id || ' não localiazado!!!' );
    END IF;
END sp_get_emp;

BEGIN
    sp_get_emp(999);
END;


--------------------

-- 8

-- 1 

SELECT nome, sobrenome 
FROM tb_empregado
WHERE nome LIKE '%li%';


-- 2. A impressão de envelope restringe o campo destinatário para 15 caracteres. Preferencialmente, o campo destinatário contém valores de NOME e SOBRENOME do funcionário separado por um espaço simples. Quando o tamanho combinado de NOME e SOBRENOME do funcionário excede 10 caracteres, o campo destinatário deve conter somente o nome formal. O nome formal de um funcionário é feito da primeira letra do NOME e os  10 primeiros caracteres de SOBRENOME. Você deve recuperar uma lista de valores de NOME e SOBRENOME e de nomes formais de funcionários em que o tamanho de NOME e SOBRENOME exceda --- 10 caracteres.

SELECT nome, sobrenome, SUBSTR(nome, 1, 1) || ' ' || SUBSTR(sobrenome, 1, 10) Nome_Formal 
FROM tb_funcionarios 
WHERE LENGTH(nome) + LENGTH(sobrenome) > 10;


SELECT
CASE
   WHEN LENGTH(nome||sobrenome) > 10 
   THEN SUBSTR(nome, 1, 1) || ' ' || SUBSTR(sobrenome, 1, 10)
   ELSE
      nome || ' ' || sobrenome
   END
   AS "Nome Formal"
FROM tb_empregado;



-- 3 A análise de rotação da equipe de funcionários é um requisito de relatório comum. Você foi incumbido de criar um relatório contendo o 
-- número de funcionários que deixaram seus trabalhos, agrupado pelo ano no qual saíram. Os trabalhos desempenhados também são exigidos. Os 
-- resultados devem ser classificados em ordem ascendente com base no número de funcionários em cada grupo. O relatório deve listar o ano, o 
-- ID_FUNCAO e o número de funcionários que deixaram um trabalho em particular naquele ano.


SELECT COUNT(id_empregado), id_funcao, TO_CHAR(data_termino, 'YYYY')
FROM tb_historico_funcao 
GROUP BY TO_CHAR(data_termino, 'YYYY'), id_funcao
ORDER BY COUNT(id_empregado) ASC;


SELECT TO_CHAR(data_termino, 'YYYY') "Ano que Parou", 
       id_funcao,
       COUNT(*) "Números de Empregados"
FROM tb_historico_funcao
GROUP BY TO_CHAR(data_termino, 'YYYY'), id_funcao
ORDER BY COUNT(*) ASC;