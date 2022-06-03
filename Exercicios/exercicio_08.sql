-- LAB DE BANCO DE DADOS
-- NOME: ARIELSON DA SILVA BRAGA

------------------------------------------ EXERCICIO 08 ------------------------------------------
-- 1)
SELECT nome, sobrenome
FROM tb_empregado
WHERE LOWER(nome) LIKE '%li%';


---------------------------------------------------------------------------------------------------
-- 2)
SELECT
CASE
   WHEN LENGTH(nome||sobrenome) > 10 
   THEN SUBSTR(nome, 1, 1) || ' ' || SUBSTR(sobrenome, 1, 10)
   ELSE
      nome || ' ' || sobrenome
   END
   AS "Nome Formal"
FROM tb_empregado;
 


---------------------------------------------------------------------------------------------------
-- 3)
SELECT EXTRACT(year FROM data_termino), id_funcao, COUNT(id_empregado)
FROM tb_historico_funcao
GROUP BY id_funcao , EXTRACT(year FROM data_termino)
ORDER BY COUNT(id_empregado) ASC;


---------------------------------------------------------------------------------------------------
-- 4)
SELECT
CASE
  WHEN TO_CHAR(data_admissao, 'D') = 1 THEN 'domingo'
  WHEN TO_CHAR(data_admissao, 'D') = 2 THEN 'segunda'
  WHEN TO_CHAR(data_admissao, 'D') = 3 THEN 'terça'
  WHEN TO_CHAR(data_admissao, 'D') = 4 THEN 'quarta'
  WHEN TO_CHAR(data_admissao, 'D') = 5 THEN 'quinta'
  WHEN TO_CHAR(data_admissao, 'D') = 6 THEN 'sexta'
  WHEN TO_CHAR(data_admissao, 'D') = 7 THEN 'sábado'
END 
AS "Dias da Semana", 
COUNT(id_empregado) "Funcionários Contratados"
FROM tb_empregado
GROUP BY TO_CHAR(data_admissao, 'D')
HAVING COUNT(id_empregado) >= 20
ORDER BY COUNT(TO_CHAR(data_admissao, 'D')) DESC;

---------------------------------------------------------------------------------------------------
-- 5)
CREATE OR REPLACE PROCEDURE sp_questao_05(p_dpto IN tb_departamento.id_departamento%TYPE )

AS
v_id_dpto         NUMBER;
v_nome            VARCHAR2(255);
v_saida           VARCHAR2(255);
BEGIN
   SELECT COUNT(*) INTO v_id_dpto 
   FROM tb_departamento 
   WHERE id_departamento = p_dpto;
   
   SELECT nm_departamento 
   INTO v_nome 
   FROM tb_departamento 
   WHERE id_departamento = p_dpto;
   
   IF(v_id_dpto = 1) THEN
      IF(SUBSTR(LOWER(v_nome), 1 ,1) IN ('a', 'e', 'i', 'o', 'u')) THEN
         UPDATE tb_departamento 
         SET nm_departamento = UPPER(nm_departamento) 
         WHERE id_departamento = p_dpto;
         
         SELECT nm_departamento INTO v_saida
         FROM tb_departamento
         WHERE id_departamento = p_dpto;

         DBMS_OUTPUT.PUT_LINE('O nome do Depto ' || v_saida || ' foi convertida para maiúsculo'); 
      ELSE 
         UPDATE tb_departamento 
         SET nm_departamento = LOWER(nm_departamento)
         WHERE id_departamento = p_dpto;

         SELECT nm_departamento INTO v_saida
         FROM tb_departamento
         WHERE id_departamento = p_dpto;

         DBMS_OUTPUT.PUT_LINE('O nome do Depto ' || v_saida || ' foi convertida para minúsculo'); 
      END IF;
   ELSE
      DBMS_OUTPUT.PUT_LINE('Depto com ID: ' || p_dpto || ' não encontrado!!'); 
   END IF;
END sp_questao_05;

BEGIN
  sp_questao_05(10);
END;

