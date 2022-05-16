-- Consultas Avançadas

-- Usando os operadores de conjunto:
-- Os operadores de conjunto permitem combinar as linhas retornadas por duas ou masi consultas

SELECT *
FROM tb_mais_produtos;

-- Usando o operador UNION ALL
-- Retorna todas as linhas recuperadas pelas consultas incluindo as linhas duplicadas

-- EXEMPLO:
-- Uso do UNION ALL recuperando todas as linhas de TB_PRODUTOS e TB_MAIS_PRODUTOS, incluindo as duplicadas

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION ALL
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

-- Usando o operador UNION
-- Retorna somente as linhas NÃO duplicadas recuperadas pelas consultas

--EXEMPLO:
-- Uso do UNION, observe que as linhas duplicadas "Modern Science" e "Chemistry" não são recuperas
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

-- Usando o operador INTERSECT
-- Retorna somente as linhas recuperadas pelas consultas

-- EXEMPLO:
-- Uso do INTERSECT, observe que são retornadas as linhas "Modern Science" e "Chemistry"

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
INTERSECT
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;

-- Usando o operador MINUS
-- Retorna as linhas restantes, quando as linhas recuperadas pela SEGUNDA consulta são SUBTRAÍDAS das linhas recuperadas pela PRIMEIRA

-- EXEMPLO:
-- Uso do MINUS, observe que as linhas da TB_MAIS_PRODUTOS são subtraídas da TB_PRODUTOS e as linhas restantes são retornadas

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
MINUS
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos;


-- Combinando operadores de conjunto
-- Permite combinar mais de duas consultas com vários operadores de conjunto, com os resultados retornados de um operador alimentando o operador seguinte
-- Por padrão, os operadores de conjunto são avaliados de cima para baixo, todavia você poderá utilizar parênteses para alterar a precedência

-- EXEMPLO 01:
(SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos)
INTERSECT
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_alteracoes_produtos;

-- EXEMPLO 02:
-- Uso do parenteses para a execução do INTERSECT primeiro

SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_produtos
UNION
(SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_mais_produtos
INTERSECT
SELECT id_produto, id_tipo_produto, nm_produto
FROM tb_alteracoes_produtos);


-- TRANSLATE(x,da_string, para_string)

-- Converte as ocorrências dos caracteres em "da_string" encontrados em "x" nos caracteres correspondentes em "para_string"

-- EXEMPLO (01):
-- Usa TRANSLATE para deslocar quatro casas para a direita de cada caractere no string "MENSAGEM SECRETA". "A" torna-se "E"

SELECT TRANSLATE('MENSAGEM SECRETA',
            'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
            'EFGHIJKLMNOPQRSTUVWXYZABCD')
FROM dual;

-- EXEMPLO (02):
-- Passando a coluna NM_PRODUTO para TRANSLATE, a qual desloca as letras da coluna NM_PRODUTO 4 casas para a direita

SELECT id_produto,
    TRANSLATE(nm_produto,
            'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
            'EFGHIJKLMNOPQRSTUVWXYZABCDefghijklmnopqrstuvwxyzabcd')
FROM tb_produtos;

-- Usa TRANLATE para converter números
-- EXEMPLO (03):
-- Pega os números 12345 e converte 5 em , 4 em 7, 3 em 8, 2 em 9 e 1 em 0

SELECT TRANSLATE(12345,
                 54321,
                 67890)
FROM dual;


-- DECODE(valor, valor_pesquisa, resultado, valor_padrão)
-- Compara "valor" com "valor_pesquisa". Se os valores forem IGUAIS, DECODE retorna "resultado"; caso contrário "valor_padrão" é retornado
-- DECODE permite executar lógica IF-THEN-ELSE em SQL, sem a necessidade de usar PL/SQL
-- Cada um dos parâmetros de DECODE pode ser uma coluna, um valor literal, uma função ou uma subconsulta

-- EXEMPLO (01):
-- Uso de DECODE com valores literais; DECODE retorna 2 (1 é comparado com 1 e, como eles são IGUAIS, 2 é retornado):
SELECT DECODE(1,1,2,3)
FROM dual;

-- EXEMPLO (02):
-- Uso de DECODE para comparar 1 com 2 e, como eles NÃO são IGUAIS, 3 é retornado
SELECT DECODE(1,2,1,3)
FROM dual;

-- EXEMPLO (03):
-- Compara a coluna DISPONIVEL, da tabela TB_MAIS_PRODUTOS; se DISPONIVEL for igual a "Y", o string "Produto está disponivel" é retornado; caso contrário, "Produto não está disponível" é retornado

SELECT id_produto, disponivel,
                DECODE(disponivel, 'Y', 'Produto está disponível',
                                        'Produto não está disponível')
FROM tb_mais_produtos;

-- EXEMPLO (04):
-- Retorna a coluna ID_TIPO_PRODUTO como o nome do tipo de produto

SELECT id_produto, id_tipo_produto,
      DECODE(id_tipo_produto,
             1, 'Book',
             2, 'Video',
             3, 'DVD',
             4, 'CD',
                'Magazine')
FROM tb_produtos;

-- Usando a expressão CASE
-- CASE executa a lógica IF-THEN-ELSE em SQL
-- Semelhante ao DECODE, entretanto, você deverá utilizar CASE porque ela é compativel com o padrão ANSI(SQL/92)
-- Existem basicamente dois tipos de CASE:
-- CASE SIMPLES
-- CASE PESQUISADAS

-- Usando expressão CASE simples
-- EXEMPLO:
-- Apresenta uma expressão CASE simples que retorna os tipos de produto com suas respectivas descrição

SELECT id_produto, id_tipo_produto,
                   CASE id_tipo_produto
                      WHEN 1 THEN 'Book'
                      WHEN 2 THEN 'Video'
                      WHEN 3 THEN 'DVD'
                      WHEN 4 THEN 'CD'
                      ELSE 'Magazine'
                   END
FROM tb_produtos;

-- Usando expressão CASE pesquisadas
-- As expressões CASE pesquisadas utilizam condições para determinar o valor de retorno

-- EXEMPLO (01):
-- Usar operadores em uma expressão CASE pesquisada

SELECT id_produto, id_tipo_produto,
        CASE 
          WHEN id_tipo_produto = 1 THEN 'Book'
          WHEN id_tipo_produto = 2 THEN 'Video'
          WHEN id_tipo_produto = 3 THEN 'DVD'
          WHEN id_tipo_produto = 4 THEN 'CD'
          ELSE 'Magazine'
        END
FROM tb_produtos;

-- EXEMPLO (02):
-- Usar operadores em uma expressão CASE pesquisada
SELECT id_produto, preco,
  CASE
    WHEN preco > 15.00 THEN 'Caro'
    ELSE 'Barato'
  END
FROM tb_produtos;

-- Consultas Hierárquicas
-- Possibilita organizar dados de forma hierárquica
-- Pessoas que trabalham em uma empresa (árvore genealógica e as peças que compõem um motor)

SELECT *
FROM tb_mais_funcionarios;

-- EXEMPLO:
-- Observe que a primeira linha contém os detalhes de James Smith (funcionário nº1), a segunda linha contpem os detalhes de Ron Johnson, cujo valor de id_gerente é 1, e assim por diante

SELECT id_funcionario, id_gerente, nome, sobrenome
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente
ORDER BY 1;

-- Usando a pseudocoluna LEVEL
-- EXEMPLO:
-- Uso da pseudocluna LEVEL para exibir o nível na árvore

SELECT LEVEL ,id_funcionario, id_gerente, nome, sobrenome
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente
ORDER BY LEVEL;

-- Formatando os resultados de uma consulta hierárquica usando LEVEL e a função LPAD
-- LPAD preenche os valores com caracteres a esquerda

-- EXEMPLO:

SELECT LEVEL,
  LPAD('', 2 * LEVEL -1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente;


--
-- Consultas Avançadas Cláusula GROUP BY estendida
--


-- ROLLUP
-- Retorna uma linha contendo um subtotal para cada grupo de linhas, além de uma linha contendo um total geral para todos os grupos

-- EXEMPLO:
-- Utilizando GROUP BY para agrupar as linhas da tabela TB_FUNCIONARIOS_2 por ID_DIVISAO, juntamente com a função SUM para obter a soma dos salarios para cada ID_DIVISAO

SELECT id_divisao, SUM(salario)
FROM tb_funcionarios_2
GROUP BY id_divisao
ORDER BY id_divisao;

-- Passando uma única coluna para ROLLUP

-- EXEMPLO:
-- Reescreve o exemplo anterior para usar ROLLUP
-- Observe a linha final, a qual contém os totais de salários de todos os grupos

SELECT id_divisao, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao)
ORDER BY id_divisao;

-- Passando várias colunas para ROLLUP
-- EXEMPLO:

SELECT id_divisao,id_cargo, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao, id_cargo)
ORDER BY id_divisao, id_cargo;


-- CUBE
-- Retorna linhas contendo um subtotal para todas as combinações de colunas, além de uma linha contendo o total geral
-- EXEMPLO:
-- Passa ID_DIVISAO e ID_CARGO para CUBE, o qual agrupa as linhas por essas colunas

SELECT id_divisao,id_cargo, SUM(salario)
FROM tb_funcionarios_2
GROUP BY CUBE(id_divisao, id_cargo)
ORDER BY id_divisao, id_cargo;

-- Função GROUPING
-- A função GROUPING aceita uma coluna 0 ou 1
-- Retorna 1 quando o valor da coluna é NULO
-- Retorna 0 quando o valor da coluna é NÃO É NULO
-- GROUPING somente é utilizada em consultas que utilizam ROLLUP

-- Usando GROUPING com uma única coluna em ROLLUP
-- EXEMPLO:
-- Observe que GROUPING retorna 0 para as linhas que tem valores de ID_DIVISAO não nulos e retorna 1 para a ultima linha, que possui um valor de ID_DIVISAO nulo

SELECT GROUPING(id_divisao), id_divisao, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao)
ORDER BY id_divisao;

-- Usando CASE Para converter o vlaor retornado de GROUPING
-- EXEMPLO:
-- CASE converter 1 no string "Todas as Divisões"

SELECT 
  CASE GROUPING(id_divisao)
    WHEN 1 THEN 'Todas as Divisões'
    ELSE id_divisao
  END AS DIV, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao)
ORDER BY id_divisao;


--
-- DML Alterando o conteúdo das Tabelas
--

-- EXEMPLO:
-- A instrução INSERT adiciona uma linha na TB_CLIENTES
-- Observe que a ordem dos valores na cláusula VALUES corresponde à ordem na qual as colunas são especificadas na lista de colunas

INSERT INTO tb_cliente (id_cliente,
                        nome,
                        sobrenome,
                        dt_nascimento,
                        telefone,
                        fg_ativo)
                        
VALUES
(7,'Joaquim', 'Silva', '26-FEB-1977', '800-666-2522', 1);

SELECT *
FROM tb_cliente;

-- Omitindo o nome das colunas, a ordem dos valores fornecidos deve corresponder à ordem das colunas conforme listadas na saida do comando DESCRIBE
-- EXEMPLO:

INSERT INTO tb_cliente
VALUES (8, 'Jane', 'Green', '01-JAN-1970', '800-5559999', 1);

-- É possivel especificar um valor NULO para uma coluna usando a palavra-chave NULL
-- EXEMPLO:
-- A instrução INSERT especifica um valor NULO para as colunas DT_NASCIMENTO e TELEFONE

INSERT INTO tb_cliente
VALUES (9, 'Sophie', 'White', NULL, NULL, 1);

-- Incluindo apóstrofos e aspas em um valor de colunas
-- EXEMPLO:
-- A instrução INSERT especifica o SOBRENOME O'Malley para o novo cliente

INSERT INTO tb_cliente
VALUES(10,'Kyle', 'O''Malley', NULL, NULL, 1);

-- EXEMPLO:

-- A instrução INSERT especifica o NOME The "Great" Gatsby para o novo produto
INSERT INTO tb_produtos (id_produto,
                        id_tipo_produto,
                        nm_produto,
                        ds_produto,
                        preco,
                        fg_ativo)
                        
VALUES
(14,1, 'The "Great" Gatsby', NULL, 12.99, 1);

select *
from tb_produtos;


-- Copiando linhas de uma tabela para outra usando uma consulta no lugar dos valores
-- O número de coluans e os tipos de coluna origem e destino devem corresponder

-- EXEMPLO:
-- Recuperar as colunas NOME e SOBRENOME do cliente nº1 e fornecer essas colunas para a instrução INSERT

INSERT INTO tb_cliente(id_cliente,
                        nome,
                        sobrenome)
SELECT 11,nome, sobrenome
FROM tb_cliente
WHERE id_cliente = 1;

-- Utilizada para modificar linhas em uma tabela
-- Especificação:
-- O nome da tabela 
-- Uma cláusula WHERE determinando as linhas a serem alteradas
-- Uma lista de nomes de colunas, juntamente com seus novos valores, especificados na cláusula SET
-- Podemos alterar uma ou mais linhas por meio da instrução UPDATE

-- EXEMPLO(A):
-- Configurar a coluna SOBRENOME como "Orange" para a linha cujo valor do ID_CLIENTE seja equivalente ao nº2

UPDATE tb_cliente
  SET sobrenome = 'Orange'
WHERE id_cliente = 2;

-- Alterando várias linhas e várias colunas na mesma instrução
-- EXEMPLO (B):
-- Elevar em 20% o preco de todos os produtos cujo preço atual seja superior a R$20,00
-- Alterar os nomes desses produtos para minúsculas

UPDATE tb_produtos
SET
  preco = preco * 1.20,
  nm_produto = LOWER(nm_produto)
WHERE preco > 20.00;


-- Clausula RETURNING
-- EXEMPLO:
SET serveroutput ON
DECLARE media_preco_produto NUMBER;

BEGIN
  UPDATE tb_produtos
    SET preco = preco * 0.75
    RETURNING AVG(preco) INTO media_preco_produto;
DBMS_OUTPUT.PUT_LINE('Valor da variável: ' || ROUND(media_preco_produto, 2));
END;

-- Instrução DELET
-- Usada para remover linhas de uma tabela

-- EXEMPLO:
-- Remove as linhas da TB_CLIENTES cujo valor da coluna ID_CLIENTE corresponda ao nº10

DELETE
FROM tb_cliente
WHERE id_cliente = 10;


ROLLBACK;

--
-- Integridade do BD
-- 

-- EXEMPLO (A):

INSERT INTO tb_cliente (id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES (1, 'Jason', 'Price', '01-JAN-60', '800-555-1211', 1);

-- EXEMPLO (B):
-- Tentar atualizar um valor de PK com um valor já existente na tabela, o BD retornará o mesmo ERRO
UPDATE tb_cliente
  SET id_cliente = 1
WHERE id_cliente = 2;


-- Um relacionamneto de FK é aquele no qual uma coluna de uma tabela é referenciada em outra
-- EXEMPLO (A):

INSERT INTO tb_produtos(id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES (15,6,'Teste', 'Teste', null, 1);

-- Erro:
--Error report:
--SQL Error: ORA-02291: integrity constraint (LOJA.FK_TB_PRODUTOS_ID_TIPO_PRODUTO) violated - parent key not found
--02291. 00000 - "integrity constraint (%s.%s) violated - parent key not found"
--*Cause:    A foreign key value has no matching primary key value.
--*Action:   Delete the foreign key or add a matching primary key.



-- EXEMPLO (B):

UPDATE tb_produtos
  SET id_tipo_produto = 6
WHERE id_produto = 1;

--Error report:
--SQL Error: ORA-02291: integrity constraint (LOJA.FK_TB_PRODUTOS_ID_TIPO_PRODUTO) violated - parent key not found
--02291. 00000 - "integrity constraint (%s.%s) violated - parent key not found"
--*Cause:    A foreign key value has no matching primary key value.
--*Action:   Delete the foreign key or add a matching primary key.

-- EXEMPLO (C):

DELETE
FROM tb_tipos_produtos
WHERE id_tipo_produto = 1;

--SQL Error: ORA-02292: integrity constraint (LOJA.SYS_C0029083) violated - child record found
--02292. 00000 - "integrity constraint (%s.%s) violated - child record found"
--*Cause:    attempted to delete a parent key value that had a foreign
--           dependency.
--*Action:   delete dependencies first then parent or disable constraint.


--
-- Valor Padrão
--
CREATE TABLE tb_status_encomenda(
id_status_encomenda           INTEGER,
status                        VARCHAR2(40)DEFAULT 'Encomenda disponibilizada' NOT NULL,
ultima_modificacao            DATE DEFAULT SYSDATE,
PRIMARY KEY (id_status_encomenda)
);

INSERT INTO tb_status_encomenda(id_status_encomenda)
VALUES(1);

SELECT *
FROM tb_status_encomenda;

INSERT INTO tb_status_encomenda(id_status_encomenda,
                                status,
                                ultima_modificacao)
VALUES (2, 'Encomenda enviada', '01-MAY-2013');

-- EXEMPLO:
-- Permite redefinir uma coluna com o valor padrão usando a palavra-chave DEFAULT em uma instrução UPDATE

UPDATE tb_status_encomenda
  SET status = DEFAULT
WHERE id_status_encomenda = 2;


commit;


--
-- Usando Merge
--

-- O Oracle 9i introduziu a instrução MERGE, a qual permite mesclar linhas de uma tabela em outra

-- EXEMPLO:

-- Realizando a mesclagem

SELECT *
FROM tb_produtos_alterados;


MERGE INTO tb_produtos p
USING tb_produtos_alterados pa ON (p.id_produto = pa.id_produto)
WHEN MATCHED THEN
  UPDATE
  SET
    p.id_tipo_produto = pa.id_tipo_produto,
    p.nm_produto = pa.nm_produto,
    p.ds_produto = pa.ds_produto,
    p.preco = pa.preco,
    p.fg_ativo = pa.fg_ativo
WHEN NOT MATCHED THEN
  INSERT(
    p.id_produto, p.id_tipo_produto, p.nm_produto,
    p.ds_produto, p.preco, p.fg_ativo)
  VALUES(
  pa.id_produto, pa.id_tipo_produto, pa.nm_produto,
  pa.ds_produto, pa.preco, pa.fg_ativo);
  
SELECT *
FROM tb_produtos;

-- Observe os seguintes aspectos sobre a intrução MERGE
-- A cláusula MERGE INTO especifica o nome da tabela a qual as linhas serão mescladas. No exemplo, essa tabela é TB_PRODUTOS, que recebeu o apelido de p
-- A clausula USING... ON especifica uma junção das tabelas. No exemplo, a junção é feita através das colunas ID_PRODUTO das tabelas TB_PRODUTOS e TB_PRODUTOS_ALTERADOS
-- A TB_PRODUTOS_ALTERADOS também recebeu um apelido, pa
-- A cláusula WHEN NOT MATCHED THEN especifica a ação a ser executada quando a cláusula USING... ON não é satisfeita para uma linha. No exemplo, essa ação é uma intrução de INSERT a qual adiciona uma linha na TB_PRODUTOS, pegando os valores da coluna da linha na TB_PRODUTOS_ALTERADOS


--
-- TRANSAÇÕES
--

-- ACID = ACID é um conjunto de propriedades de transação em banco de dados. Atomicidade, Consistência, Isolamento e Durabilidade.
-- Transações são tudo ou nada.
-- Uma transação de BD é um grupo de instruções SQL que executam uma unidade lógica de trabalho
-- Podemos considerar uma transação como um conjunto inseparavel de intruções SQL cujos resultados devem se tornar permanentes no BD como um todo (ou serem desfeitas como um todo)

-- EXEMPLO (A):

-- Adicionar uma linha na TB_CLIENTES e depois tornar a alteração permanente executando o COMMIT

INSERT INTO tb_cliente
VALUES
(12, 'Geraldo', 'Henrique', '31-JUL-1977', '800-1112233', 1);

COMMIT;

-- EXEMPLO (B):

-- Atualizar o cliente de nº1 e na sequencia desfazer a alteração executando uma instrução de ROLLBACK

UPDATE tb_cliente
  SET nome = 'José'
WHERE id_cliente = 1;

SELECT * 
FROM tb_cliente
ORDER BY 1;

ROLLBACK;

-- Iniciando e terminando uma transação
-- Uma transação é uma unidade lógica de trabalho que permite segmentar suas intruções SQL
-- Uma transação tem um inicio e fim

-- A transação começa quando um dos seguintes eventos ocorre:
-- Quando conectamos no BD e executamos uma instrução DML
-- Uma transação anterior termina e inserimos outra instrução DML
-- Executamos uma intrução de COMMIT ou ROLLBACK
-- Executamos uma intrução DDL (COMMIT é executado automaticamente)
-- Executamos uma intrução DCL (COMMIT é executado automaticamente)
-- Quando executamos uma intrução DML que falha (ROLLBACK é executado automaticamente)

-- Observações:
-- Não confirmar ou reverter explicitamente suas transações é uma má pratica
-- Execute uma intrução de COMMIT ou ROLLBACK no final de suas transações

-- Savepoints

-- EXEMPLO:
-- Examinal qual o preço atual dos produtos de nº4 e nº6

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4,6);

-- 4 - 13.95
-- 6 - 49.99

-- Aumentar em 20% o preço de produto de nº4

UPDATE tb_produtos
  SET preco = preco * 1.20
WHERE id_produto = 4;

COMMIT;

SAVEPOINT save1;

-- Aumentar em 30% o preço do produto de nº6

UPDATE tb_produtos
  SET preco = preco * 1.30
WHERE id_produto = 6;

-- A consulta a seguir obtém os preços dos dois produtos

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4,6);

-- 4 - 16.74
-- 6 - 64.99

-- A instrução a seguir reverte à transação para o savepoint estabelecido anteriormente

ROLLBACK TO SAVEPOINT save1;

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4,6);

-- 4 - 16.74
-- 6 - 49.99

-- Propriedades de Transação (ACID)

-- Definição de uma transação (convencional):
-- Unidade lógica de trabalho
-- Grupo de instruções SQL relacionadas que sofrem um COMMIT ou ROLLBACK

-- Definição adequada, diz que uma transação possui 4 propriedades fundamentais (ACID)

-- Atômica: significa que as intruções SQL contidas em uma transação constituem uma única unidade de trabalho (tudo ou nada)
-- Consistência: significa que o BD está em um estado consistente quando uma transação inicia, e, ao seu termino, em outro estado consistente
-- Isolada: transações separadas não devem interferir uma com a outra
-- Durável: uma vez que a transação sofreu COMMIT, as alterações feitas no BD são preservadas, mesmo que a máquina em que o SGBD apresente falha posteriormente

-- Nivel de isolamento de transação:
-- É o grau com que as alterações feitas por uma transação são separadas das outras transações em execução concomitante
-- Antes de evidenciar os níveis de isolamento, é necessário entender os tipos de problemas que podem ocorrer quando transações concorrentes tentam acessar as mesmas linhas em uma tabela

-- Três tipos d eproblemas pertinentes ao processamento de transação:
-- T1 e T2 (concorrentes)
  --1. Leituras Fantasmas
  -- T1 lê um conjunto de linhas retornadas por uma cláusula WHERE especifica
  -- T2 insere uma nova linha, a qual também satisfaz a cláusula WHERE da consulta usada anteriormente por T1
  -- T1 lê as linhas novamente, usando a mesma consulta, mas agora vê a linha adicional que T2 acabou de inserir
  -- Essa nova linha é conhecida como "fantasma" porque, para T1, essa linha apareceu como mágica
  
  --2. Leituras que não podem ser repetidas
  -- T1 lê uma linha e T2 atualiza a mesma linha que T1 acabou de ler
  -- T1 lê novamente a mesma linha e descobre que a linha que leu anteriormente agora está diferente
  -- Isso é conhecido como leitura "que não pode ser repetida", pois a linha lida originalmente por T1 foi alterada
  
  --3. Leituras Sujas
  -- T1 atualiza uma linha, mas não efetua COMMIT na atualização
  -- T2 lê a linha atualizada
  -- T1 realiza um ROLLBACK, desfazendo a atualização anterior
  -- Agora a linha que T2 acabou de ler não é mais válida (ela está "suja"), pois a atualização feita por T1 não estava confirmada quando a linha foi lida por T2
  
-- Níveis de Isolamento
-- Utilizadas para evitar que transações concorrentes interfiram uma com a outra
-- READ UNCOMMITED: leituras fantasmas, leituras que não podem ser repetidas e leituras sujas são permitidas
-- READ COMMITED: leituras fantasmas e leituras que não podem ser repetidas são permitidas, mas leituras sujas não
-- REPETABLE READ: Leituras fantasmas são permitidas, mas leituras que não podem ser repetidas e leituras sujas não
-- SERIALIZABE: leituras fantasmas, leituras que não podem ser repetidas e leituras sujas não são permitidas

-- Oracle suporta apenas os niveis de isolamento de transações READ COMMITED e SERIALIZABLE
-- SERIALIZABLE
-- Nivel de isolamento de transação normal definido pelo padrão SQL


-- EXEMPLO:

SERIALIZABLE SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;


--
-- FLASHBACK
--

-- EXEMPLO:
-- Recupere as colunas ID_PRODUTO, NM_PRODUTO e PRECO das primeiras 5 linhas da TB_PRODUTOS

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

-- 1 - 40
-- 2 - 35
-- 3 - 25,99
-- 4 - 16,74

-- Reduzir o preço dessas linhas, confirmando as alterações

UPDATE tb_produtos
  SET preco = preco * 0.75
WHERE id_produto <= 5;

COMMIT;


SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

-- 1 - 30
-- 2 - 26,25
-- 3 - 19,49
-- 4 - 12,56

-- Executando o procedure DBMS_FLASHBACK.ENABLE_AT_TIME(), que permite retornar para uma data/hora especifica
-- 24h * 60 min = 1440 min
-- SYSDATE - 10/1440 é uma data/hora dez minutos no passado

EXECUTE DBMS_FLASHBACK.ENABLE_AT_TIME(SYSDATE - 10/1440);

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

-- Desativando o flashback

EXECUTE DBMS_FLASHBACK.DISABLE();

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

-- Consulta flashback com número de alteração de sistema
-- Flashback baseado em números de alteração de sistemas (SCNs) podem ser mais precisos comparado com os baseados no tempo
-- SCNs são utilizados pelo BD para monitorar as alterações feitas nos dados

-- EXEMPLO:
-- Usando flashback baseado no número do sistema (SCN)

VARIABLE scn_atual NUMBER;

EXECUTE :scn_atual := DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER();

PRINT scn_atual;

-- Adicionando um registro na TB_PRODUTOS, efetivando a inclusão e recuperando o novo registro

INSERT INTO tb_produtos(id_produto,
                        id_tipo_produto,
                        nm_produto,
                        ds_produto,
                        preco,
                        fg_ativo)
VALUES
(16,1,'Física', 'Livro sobre Física', 39.95,1);

COMMIT;

-- Executando o procedure o qual permite retornar a um SCN (variavel scn_atual)
-- As consultas agora irão exibir as linhas como eram no SCN armazenado em scn_atual, antes da execulçao da intrução INSERT (necessidade de desativer o flashback)

EXECUTE DBMS_FLASHBACK.ENABLE_AT_SYSTEM_CHANGE_NUMBER(:scn_atual);

SELECT *
FROM tb_produtos
WHERE id_produto = 16;

-- EXEMPLO (PARTE 1):
-- Criando, excluindo e revertendo o mesmo objeto através do uso de flashback

EXECUTE DBMS_FLASHBACK.DISABLE();


CREATE TABLE tb_teste(
ID            INTEGER,
valor         VARCHAR2(100)
);

BEGIN

  FOR v_loop IN 1..100 LOOP
    INSERT INTO tb_teste(id,valor)
    VALUES (v_loop, 'DBA_' || v_loop);
  END LOOP;
END;

SELECT *
FROM tb_teste;

DROP TABLE tb_teste; -- equivoco

FLASHBACK TABLE tb_teste TO BEFORE DROP;

