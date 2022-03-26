
-- ASCII

SELECT ASCII('a'), ASCII('A'), ASCII('Z'), ASCII('0'), ASCII('9')
FROM dual;

-- CHR

SELECT CHR(97), CHR(65), CHR(122), CHR(90), CHR(48), CHR(57)
FROM dual;

-- CONCAT

SELECT CONCAT(nome,sobrenome)
FROM tb_funcionarios;

-- INITCAP

SELECT id_produto, INITCAP(ds_produto)
FROM tb_produtos;

-- INSTR (x, localizar_string)

SELECT nm_produto, INSTR(nm_produto, 'Science')
FROM tb_produtos
WHERE id_produto = 1;

SELECT nm_produto, INSTR(nm_produto, 'e', 1,2)
FROM tb_produtos
WHERE id_produto = 1;

-- Contagem de Nº Letras
SELECT nm_produto, LENGTH(nm_produto)
FROM tb_produtos;

-- Converter para maiusculo e minusculo
SELECT UPPER(nome), LOWER(sobrenome)
FROM tb_funcionarios;

-- Preenchimento até o comprimento total da string
SELECT RPAD(nm_produto, 30, '.'), LPAD(preco, 8, '*+')
FROM tb_produtos
WHERE id_produto < 4;

-- Corta espaços 
SELECT
LTRIM('   Olá pessoal tudo joia?'),
RTRIM('Oi tudo bem!abcabc', 'abc'),
TRIM('0' FROM '000Treinamento em Oracle!00000')
FROM dual;

-- NVL retorna um valor que não seja nulo
SELECT id_cliente, NVL(telefone, 'Telefone inexistente')
FROM tb_cliente
ORDER BY id_cliente DESC;

SELECT id_cliente, NVL2(telefone, 'Telefone Existente', 'Telefone Inexistente')
FROM tb_cliente
ORDER BY id_cliente DESC;