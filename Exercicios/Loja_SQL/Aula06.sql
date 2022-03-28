
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

-- REPLACE procua string_busca em "x" e substitui por string_substituta

SELECT  REPLACE(nm_produto, 'Science', 'Physics')
FROM tb_produtos
WHERE id_produto = 1;

-- SOUNDEX
-- obtem uma string conteudo a representação fonetica de "x"
SELECT sobrenome
FROM tb_cliente
WHERE SOUNDEX(sobrenome) = SOUNDEX('whyte');

-- SUBSTR (x, inicio, [comprimento]);
-- Retorna uma substring de 'x' que inicia na posição determinada por inicio
-- EX: obter o substring de 7 caracteres a partir da 2 posicao da coluna nm_produto da tb_produtos
SELECT nm_produto, SUBSTR(nm_produto, 2, 7)
FROM tb_produtos
WHERE id_produto < 4;

-- Uso da função SUBSTR para obter o substring "DBA" do string "Administrador de Banco de Dados - DBA"

SELECT SUBSTR('Administrador de Banco de Dados - DBA', 34, 4)
FROM dual;

-- COMBINANDO FUNÇÕES

-- Combinar as funções UPPER e SUBSTR

SELECT nm_produto, UPPER(SUBSTR(nm_produto,2, 8))
FROM tb_produtos
WHERE id_produto < 4;

-- FUNÇÕES NUMERICAS

-- ABS
-- O valor absoluto de um numero é esse numero sem nenhum sinal(positivo/negativo)
-- Exemplo: Obter o valor absoluto da subtração de 30.00 da coluna PRECO da TB_PRODUTOS para os tres primeiros produtos

SELECT id_produto, preco, preco - 30.00, ABS(preco - 30.00)
FROM tb_produtos
WHERE id_produto < 4;

-- CEIL
-- Obtém o menor inteiro maior ou igual a "x"

SELECT CEIL(5.8), CEIL(-5.2)
FROM dual;

-- FLOOR
-- Obtem o maior intiero menor ou igual a "x"

SELECT FLOOR(5.8), FLOOR(-5.2)
FROM dual;

-- MOD(x,y)
-- Obtem o RESTO da divisão de "x" por "y"

SELECT MOD(8,3), MOD(8,4)
FROM dual;

-- POWER(x,y)
-- Obtem o resultado de "x" elevado à potencia "y"
SELECT POWER(2,1), POWER(2,3)
FROM dual;

-- ROUND
-- Obtem o resultado do arredondamento de "x" com "y" casas decimais(opcional)

SELECT ROUND(5.75), ROUND(5.75, 1), ROUND(5.75, -1)
FROM dual;

-- SIGN
-- Obtem o sinal de "x"
-- -1 de "x" se for negativo, 1 se "x" for positivo, retorna 0 se "x" for zero

SELECT SIGN(-5), SIGN(5), SIGN(0)
FROM dual;

-- SQRT(x)
-- Obtem a raiz quadrada de 'x'

SELECT SQRT(25), SQRT(5)
FROM dual;

-- TRUNC(x,[y])
-- DIFERENTE DO ROUND, O ROUND ARREDONDA, O TRUNC DESCARTA O NUMERO
-- utilizado para obter o resultado do truncamento de "x" com "y" casas decimais(opcional)
-- se "y" for omitido, "x" será truncado com zero casa decimal
-- se "y" for negativo, "x" será truncado a esquerda do ponto decimal

SELECT TRUNC(5.75), TRUNC(5.75, 1), TRUNC(5.75, -1)
FROM dual;

-- FUNÇÃO DE CONVERSÃO

-- TO_CHAR(x,[format])
-- Converte "x" em um string

SELECT TO_CHAR(12345.67)
FROM dual;
-- Utilizando uma masca/modelo que a string deve seguir ao ser exibida
SELECT TO_CHAR(12345.67, '99,999.99')
FROM dual;

-- Utilizando o cifrão($)
SELECT TO_CHAR(12345.67, '$99,999.99')
FROM dual;

-- Parametro B: se a parte inteira de um número de ponto fixo for zero, retorna espaços para os zeros

SELECT TO_CHAR(00.67, 'B9.99')
FROM dual;

-- Parametro C: retorna o simbolo de moeda em uma posição especifica

SELECT TO_CHAR(12345.67, 'C99,999.99')
FROM dual;

-- Parametro EEEE: retorna o numero usando a notação cientifica

SELECT TO_CHAR(12345.67, '99999.99EEEE')
FROM dual;

-- Parametro FM: remove os espaços a esquerda e a direita do numero
SELECT TO_CHAR(0012345.6700, 'FM99999.99')
FROM dual;

-- Parametro L: retorna o simbolo de moeda local em uma posicao especifica

SELECT TO_CHAR(12345.67, 'L99,999.99')
FROM dual;

-- Parametro MI: retorna um numero negativo com uma sinal de menos a dierita
-- retorna um numeor positivo com um espaço a direita
SELECT TO_CHAR(-12345.67, '99,999.99MI')
FROM dual;

-- Parametro PR: retorna um numero negativo entre os sinais de menor e maior (<>)
--               retorna um numeor positivo com um espaço à esquerda e a direita

SELECT TO_CHAR(-12345.67, '99,999.99PR')
FROM dual;

-- Parametro RN: retorna o numeor como algarismos romanos

SELECT TO_CHAR(2022, 'RN')
FROM dual;

-- Parametro TM: retorna o numero usando a quantidade minima de caracteres

SELECT TO_CHAR(12345.67, 'TM')
FROM dual;

-- Parametro S: Retorna um numero negativo com um sinal de negativo á esquerda; retorna um numeor positvo com um sinal de positivo a esquerda
-- Parametro 999S: retorna um numero negativo com um sinal de negativo á direita; retorna um numero positivo com um sinal a direita

SELECT TO_CHAR(12345.67, 'S99,999.99')
FROM dual;

-- Parametro U: retorna o simbolo de moeda (euro)

SELECT TO_CHAR(12345.67, 'U99,999.99')
FROM dual;

-- Parametro V: retorna o numero multiplicado por 10x

SELECT TO_CHAR(12345.67, '99999V99')
FROM dual;

-- uso do to_char para converter colunas contendo numeros em strings

SELECT id_produto, 'O preço do produto é: ' || TO_CHAR(preco, 'L99.99')
FROM tb_produtos
WHERE id_produto < 5;

-- TO_NUMBER
-- Converte x em um numero

SELECT TO_NUMBER('970.13')
FROM dual;

SELECT TO_NUMBER('970.13') + 25.50
FROM dual;

-- Converte o string, passando o string de formato/mascara
SELECT TO_NUMBER('-$12,345.67', '$99,999.99')
FROM dual;

-- CAST(x AS tipo)
-- Converte "x" em um tipo dado compativel, especificado por "tipo"

SELECT
  CAST(12345.67 AS VARCHAR2(10)),
  CAST('9A4F' AS RAW(2)),
  CAST('01-DEC-2007' AS DATE),
  CAST(12345.678 AS NUMBER(10,2))
FROM dual;


SELECT
  CAST(preco AS VARCHAR2(10)),
  CAST(preco + 2 AS NUMBER(7,2)),
  CAST(preco AS BINARY_DOUBLE)
FROM tb_produtos
WHERE id_produto = 1;


-- FUNÇÕES DE EXPRESSAO REGULAR

-- Permitem procurar um padrão de caracteres em um string

-- REGEXP_LIKE(x, padrao, [opção_correspondencia])
-- procura "x" a expressão regular definida no parametro padrao

SELECT id_cliente, nome, sobrenome, dt_nascimento
FROM tb_cliente
WHERE REGEXP_LIKE(TO_CHAR(dt_nascimento, 'YYYY'), '196[5-8]$');

SELECT id_cliente, nome, sobrenome, dt_nascimento
FROM tb_cliente
WHERE REGEXP_LIKE(nome, 'j','i');

