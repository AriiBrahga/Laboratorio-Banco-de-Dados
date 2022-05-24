-- LAB DE BANCO DE DADOS
-- NOME: ARIELSON DA SILVA BRAGA

-------------------------------------- EXERCICIO 7 -------------------------------------
-- 1)

SELECT e.nome, f.ds_funcao, e.data_admissao
FROM tb_empregado e, tb_funcao f
WHERE e.id_funcao = f.id_funcao
AND e.data_admissao BETWEEN '20-Feb-1987' AND '01-Mar-1989'
ORDER BY e.data_admissao;

SELECT data_admissao
FROM tb_empregado ORDER BY data_admissao ASC;


------------------------------------------------------------------------------------------
-- 2)

SELECT UPPER(e.nome), LENGTH(e.sobrenome), dp.nm_departamento, p.nm_pais
FROM tb_empregado e 
INNER JOIN tb_departamento dp ON (e.id_departamento = dp.id_departamento)
INNER JOIN tb_localizacao l ON (dp.id_localizacao = l.id_localizacao)
INNER JOIN tb_pais p ON (l.id_pais = p.id_pais)
WHERE UPPER(e.nome) LIKE 'B%' 
OR UPPER(e.nome) LIKE 'L%' 
OR UPPER(e.nome) LIKE 'A%'
ORDER BY e.nome ASC;


------------------------------------------------------------------------------------------
-- 3)

SELECT e.nome, dp.nm_departamento, l.cidade, l.estado
FROM tb_empregado e 
INNER JOIN tb_departamento dp ON (e.id_departamento = dp.id_departamento)
INNER JOIN tb_localizacao l ON (dp.id_localizacao = l.id_localizacao)
WHERE percentual_comissao > 0;


------------------------------------------------------------------------------------------
-- 4)

SELECT   e.nome || ' trabalha para o ' || NVL(g.nome, 'Os acionistas')
FROM tb_empregado e
LEFT JOIN tb_empregado g ON (e.id_gerente = g.id_gerente)
ORDER BY g.nome DESC;


------------------------------------------------------------------------------------------
-- 5)

CREATE OR REPLACE PROCEDURE sp_get_emp(p_id INTEGER)

AS
v_number   NUMBER;
v_saida    VARCHAR2(400);

BEGIN
  SELECT COUNT(id_empregado) 
  INTO v_number
  FROM tb_empregado
  WHERE id_empregado = p_id;
  IF(v_number > 0) THEN
    SELECT 'Nome: ' || e.nome || ' ' || e.sobrenome || ' Função: ' || f.ds_funcao INTO v_saida
    FROM tb_empregado e, tb_funcao f
    WHERE e.id_funcao = f.id_funcao
    AND e.id_empregado = p_id;

    DBMS_OUTPUT.PUT_LINE(v_saida);
    
  ELSE
    DBMS_OUTPUT.PUT_LINE('Empregado com ID: ' || p_id || ' não localizado!');
  END IF;

END sp_get_emp;

BEGIN
  sp_get_emp(1000);
END;


