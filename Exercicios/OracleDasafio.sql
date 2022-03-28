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
