------MANIPULANDO DATA E HORA

INSERT INTO tb_cliente(id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES (7, 'Steve', 'Purple', DATE'1972-10-25', '800-555-1215', 1);

SELECT *
FROM tb_cliente
ORDER BY id_cliente;

ROLLBACK;

-- Uso das funções TO_CHAR e TO_DATE para converter uma data/hora em um string e vice-versa
-- TO_CHAR(x, [string]): converte a data/hora em um string

-- EXEMPLO (01):

-- Converte a coluna DT_NASCIMENTO da TB_CLIENTES em um string com o formato MONTH DD, YYYY
SELECT id_cliente, TO_CHAR(dt_nascimento, 'MONTH DD, YYYY')
FROM tb_cliente;

-- EXEMPLO (02):

-- Obtém a data e hora atual do BD usando a função SYSDATE, posteriormente, converte a data e hora em um string
-- usando TO_CHAR com formato de 24 horas

SELECT TO_CHAR(SYSDATE, 'MONTH DD, YYYY, HH24:MI:SS')
FROM dual;

-- Parâmetros de formatação de data/hora
-- EXEMPLO :

-- Converte 5 de fevereiro de 1968 em um string com o formato MONTH DD, YYYY

SELECT TO_CHAR(TO_DATE('05-FEB-1968'), 'MONTH DD, YYYY')
FROM dual;


-- TO_DATE(x,[formato])

-- Converte o string "x" em uma data/hora
-- Permite fornecer o string opcional para indicar o formato de "x"
-- Se for omitido o formato, a data será formatada no padrão do BD
-- Parâmetro NLS_DATE_FORMAT especifica o formato de data padrão do SGBD (DD-MON-YY)

-- EXEMPLO:

-- Converte os strings 04-JUL-2013 E 04-JUL-13 na data de 04-JUL-13

SELECT TO_DATE('04-JUL-2013'), TO_DATE('04-JUL-13')
FROM dual;

-- Possibilidade de utilização do formato opcional para uma data/hora (TO_DATE)

-- EXEMPLO (01):

-- Converte o string "Jul 4, 2013" em uma data, passando o string de formato MONTH DD, YYYY para TO_DATE

SELECT TO_DATE('Jul 04, 2013', 'MONTH DD, YYYY')
FROM dual;

SELECT * 
FROM nls_session_parameters;

ALTER SESSION SET NLS_DATE_FORMAT = 'Mon/dd/yyyy';

-- EXEMPLO (02):

-- Converte o string 7.4.13 na data Jul 4, 2013
-- A data final é exibida no formato determinado pelo parâmetro NLS_DATE_FORMAT

SELECT TO_DATE('7.4.13', 'MM.DD.YY')
FROM dual;

-- Possibilidade de especificar uma hora em uma data/hora
-- Se não for especificado um formato para hora, por padrão será utilizado 12:00:00 A.M.

-- EXEMPLO (01):

-- Adicionar um novo registro na TB_CLIENTES, utilizando a função TO_DATE na coluna DT_NASCIMENTO

INSERT INTO  tb_cliente(id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES (10, 'Nome', 'Sobrenome', TO_DATE('Jul 04, 2013 19:32:36', 'MONTH DD, YYYY HH24:MI:SS'), '800-555-1215', 1);

-- EXEMPLO (02):

-- Recupera as linhas da TB_CLIENTES utilizando TO_CHAR para converter os valores da coluna DT_NASCIMENTO
-- Observe que o ID_CLIENTE de nº 10 tem a hora configurada pela instrução INSERT

SELECT id_cliente, 
        TO_CHAR(dt_nascimento, 'DD-MON-YYYY HH24:MI:SS')
FROM tb_cliente
ORDER BY id_cliente;

ROLLBACK;


-- Mesclando TO_CHAR e TO_DATE

-- Permiete mesclar chamadas de TO_CHAR e TO_DATE
-- Desta forma, torna-se possivle utilizar data/hora em diferentes formatos

-- EXEMPLO:

-- Combinação de TO_CHAR e TO_DATE para exibir apenas o segmento referente à hora de uma data/hora.
-- A saída de TO_DATE é passada como parâmetro para TO_CHAR

SELECT TO_CHAR(TO_DATE('Jul 04, 2013 19:32:36', 'MONTH DD, YYYY, HH24:MI:SS'), 'HH24:MI:SS')
FROM dual;


-- Usando o Formato YY

-- EXEMPLO:

-- Observe as datas de entrada 15 e 75 as quais são passadas para TO_DATE, cuja saída é passada para TO_CHAR
-- que converte as daras em um string com o formato DD-MON-YYYY

SELECT
  TO_CHAR(TO_DATE('Jul 04, 15', 'MONTH DD, YY'), 'MONTH DD, YYYY'),
  TO_CHAR(TO_DATE('Jul 04, 75', 'MONTH DD, YY'), 'MONTH DD, YYYY')
FROM dual;

-- Alterando para RR voce arruma esse problema

SELECT
  TO_CHAR(TO_DATE('Jul 04, 15', 'MONTH DD, RR'), 'MONTH DD, YYYY'),
  TO_CHAR(TO_DATE('Jul 04, 75', 'MONTH DD, RR'), 'MONTH DD, YYYY')
FROM dual;


-- Funções de DATA/HORA

-- As funções de data/hora são usadas para obter ou processar data/hora e timestamp
-- A tabela abaixo apresenta algumas das funções de data/hora

-- ADD_MONTHS(x,y)
-- Retorna o resultado da adição de "y" meses a "x"
-- Se "y" for negativo, "y" meses são subtraidos de "x"

-- EXEMPLO (01):

-- Soma 13 meses à 1º de julho de 2013

SELECT ADD_MONTHS('Jul 01, 2013', 13)
FROM dual;

-- EXEMPLO (02):

-- Subtrair 13 meses à 1º de julho de 2013

SELECT ADD_MONTHS('Jul 01, 2013', -13)
FROM dual;

-- LAST_DAY(x)
-- Retorna a data do ultimo dia da parte de "x" refernete ao mês

-- EXEMPLO:

-- Exibir a ultima data em julho de 2013

SELECT LAST_DAY('Jul 01, 2013')
FROM dual;

-- MONTHS_BETWEEN(x,y)
-- Retorna o número de meses entre "x" e "y"
-- Se "x" ocorre antes de "y" no calendário, o numero retornado pela função é negativo

-- EXEMPLO:

-- Exibir o número de meses entre 1º de maio de 2011 e 03 de julho de 2013

SELECT MONTHS_BETWEEN('Jul 03,2013', 'May 01, 2011')
FROM dual;

-- NEXT_DAY(x,dia)
-- Retorna a data do proximo dia depois de "x"
-- O dia é determinado como um string literal (exemplo: Saturday)

-- Exemplo:

-- Exibir a data do próximo domingo, após 03 de julho de 2013

-- Sunday = 1; Monday = 2 ....
SELECT NEXT_DAY('Jul 03, 2013', 1)
FROM dual;

--ROUND(x,[unidade])
-- Arredonda "x", por padrão, para o inicio do dia mais proximo.
-- Permiete fornecer o string opcional, "x" será arredondado para essa unidade
-- String opcional: YYYY arredonda "x" para o primeiro dia do ano mais proximo

-- EXEMPLO (01):

-- Arredondar 03 de julho de 2013 para o 1º dia do ano mais próximo (1º de janeiro de 2014)

SELECT ROUND(TO_DATE('Jul 03, 2013'), 'YYYY')
FROM dual;

-- EXEMPLO (02):

-- Arredondar 25 de maio de 2013 para o 1º dia do mes mais próximo (1º de junho de 2013)

SELECT ROUND(TO_DATE('May 25, 2013'), 'MM')
FROM dual;
SELECT TO_CHAR
      (ROUND
      (TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS'),
      'HH24'),
      'MONTH DD, YYYY HH24:MI:SS')
FROM dual;

-- EXEMPLO (03):

-- Arredondar 19:46:26 horas de 03 de julho de 2013 para a hora mais proxima (20:00h)

SELECT TO_CHAR
      (ROUND
      (TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS'),
      'HH24'),
      'MONTH DD, YYYY HH24:MI:SS')
FROM dual;

--SYSDATE
-- Retorna data/hora atual configurada no SO do servidor do BD

-- EXEMPLO

SELECT SYSDATE
FROM dual;

-- EXTRACT
-- Extrai e retorna o ano, mês, dia, hora, minuto, segundo ou fuso horário de "x"
-- "x" pode ser um TIMESTAMP ou tipo DATE

-- EXEMPLO (01):

-- Obter o ano, mês e dia de um tipo DATE retornando por TO_DATE

SELECT
  EXTRACT(YEAR FROM TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS YEAR,
  EXTRACT(MONTH FROM TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS MONTH,
  EXTRACT(DAY FROM TO_DATE('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS DAY
FROM dual;

-- EXEMPLO (02):

-- Obter a hora, minuto e segundo de um valor TIMESTAMP retornado por TIMESTAMP

SELECT
  EXTRACT(HOUR FROM TO_TIMESTAMP('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS HORA,
  EXTRACT(MINUTE FROM TO_TIMESTAMP('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS MINUTO,
  EXTRACT(SECOND FROM TO_TIMESTAMP('Jul 03, 2013 19:45:26', 'MONTH DD, YYYY HH24:MI:SS')) AS SEGUNDO
FROM dual;


-- Intervalo de Tempo
 

SELECT *
FROM tb_promocao;

-- EXEMPLO (01):

-- Converte varios numeros em intervalos de tempo usando NUMTODSINTERVAL

SELECT
  NUMTODSINTERVAL(1.5,'DAY'),
  NUMTODSINTERVAL(3.25,'HOUR'),
  NUMTODSINTERVAL(5,'MINUTE'),
  NUMTODSINTERVAL(10.123456789,'SECOND')
FROM dual;


-- EXEMPLO (01)

-- Converter dois numeros em intervalos de tempo usando NUMTOYMINTERVAL

SELECT
  NUMTOYMINTERVAL(1.5, 'YEAR'),
  NUMTOYMINTERVAL(3.25, 'MONTH')
FROM dual;


