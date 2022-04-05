-- Criando tabelas

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

CREATE SEQUENCE home 
START WITH          10
INCREMENT BY        10
MAXVALUE            9900
NOCACHE
NOCYCLE;

1, 2 - Inserindo nas tabelas tb_homem e tb_mulher

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

-- 3 - Fazendo as Consultas utilizando INNER JOINs
-- a - Selecionar os casamentos
SELECT id_homem, h.nome_homem || ' casado com ' || m.nome_mulher AS Casamento
FROM tb_homem h, tb_mulher m 
WHERE h.id_mulher = m.id_mulher
ORDER BY h.nome_homem;


--b - Selecionar os casamentos NATURAL JOIN
SELECT *
FROM tb_homem
NATURAL JOIN tb_mulher;

-- ou

SELECT id_homem, h.nome_homem || ' casado com ' || m.nome_mulher AS Casamento
FROM tb_homem h
NATURAL JOIN tb_mulher m
ORDER BY h.nome_homem;

-- c - Selecionar os Casamentos usando JOIN...USING 

SELECT id_homem, h.nome_homem || ' casado com ' || m.nome_mulher AS Casamento
FROM tb_homem h
INNER JOIN tb_mulher m USING(id_mulher)
ORDER BY h.nome_homem;


-- d - Selecionar Casamentos utilizando JOIN... ON

SELECT id_homem, h.nome_homem || ' casado com ' || m.nome_mulher AS Casamento
FROM tb_homem h
INNER JOIN tb_mulher m ON (h.id_mulher = m.id_mulher)
ORDER BY h.nome_homem;

-- e - Por meio de um produto cartesiano, simule os casamentos possiveis
SELECT nome_homem, nome_mulher
FROM tb_homem
CROSS JOIN tb_mulher
ORDER BY nome_homem;

-- ou

SELECT h.nome_homem, m.nome_mulher
FROM tb_homem h, tb_mulher m
ORDER BY h.nome_homem;


