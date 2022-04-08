/*

EXERCICIO 05 - LAB DE BANCO DE DADOS
NOME: Arielson da Silva Braga

*/
----------------------------------------
-- EX01

SELECT 'O identificador da ' || ds_funcao || ' é o ID: ' || id_funcao AS "Descrição Função" 
FROM tb_funcao;

-----------------------------------------
-- EX02

SELECT ((22/2) * 6000 * 6000) AS "Área"
FROM dual;

-----------------------------------------
-- EX03

SELECT nm_departamento
FROM tb_departamento
WHERE nm_departamento LIKE '_%ing';

-----------------------------------------
-- EX04

SELECT teto_salario
FROM tb_funcao;

SELECT ds_funcao, base_salario, teto_salario ,(teto_salario - base_salario) AS Diferença
FROM tb_funcao
WHERE ds_funcao LIKE ('Presidente%') 
OR ds_funcao LIKE ('Gerente_%')
ORDER BY Diferença DESC, ds_funcao ASC;

-----------------------------------------
-- EX05


DEFINE &v_aliquota = 5;
SELECT id_empregado, nome ,salario, salario * 12 AS "Anual", &v_aliquota, &v_aliquota * (salario * 12)
FROM tb_empregado;


DEFINE &v_aliquota = 5;
SELECT id_empregado, nome ,salario, salario * 12 AS "Anual", 5 AS "ALIQUOTA", (salario * 12) * 5
FROM tb_empregado;
