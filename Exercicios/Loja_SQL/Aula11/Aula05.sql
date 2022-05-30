--
-- EXERCICIO 01
--

CREATE TABLE tb_teste(
ID            INTEGER,
valor         VARCHAR(100)
);

BEGIN

  FOR v_loop IN 1..100000 LOOP
    INSERT INTO tb_teste(ID,valor)
    VALUES (v_loop, 'DBA_' || v_loop);
  END LOOP;

END;


SELECT *
FROM tb_teste
ORDER BY 1;

TRUNCATE TABLE tb_teste;

--
-- EXERCICIO 02
--

CREATE TABLE tb_cliente_teste(
id_cliente            INTEGER,
ds_cliente            VARCHAR2(40),
nm_cliente            VARCHAR2(40),
valor                 NUMERIC,
fg_ativo              INTEGER,

PRIMARY KEY(id_cliente)
);

CREATE OR REPLACE PROCEDURE manipula_dados(
  p_id_cliente        IN tb_cliente_teste.id_cliente%TYPE,
  p_descricao         IN tb_cliente_teste.ds_cliente%TYPE,
  p_nome              IN tb_cliente_teste.nm_cliente%TYPE,
  p_valor             IN tb_cliente_teste.valor%TYPE,
  p_fg_ativo          IN tb_cliente_teste.fg_ativo%TYPE,
  p_opcao             IN CHAR)

AS

v_controle INTEGER;

BEGIN

--verifica a existência de tuplas na tb_cliente_teste
SELECT COUNT(*) INTO v_controle
FROM tb_cliente_teste
WHERE id_cliente = p_id_cliente
AND fg_ativo = 1;

-- opcao = I(INSERT)

IF(p_opcao = 'I') THEN
  IF(v_controle != 1) THEN
    INSERT INTO tb_cliente_teste(id_cliente, ds_cliente, nm_cliente, valor, fg_ativo)
    VALUES (p_id_cliente, p_descricao, p_nome, p_valor, p_fg_ativo);
    
    COMMIT;
    
    dbms_output.put_line('Cliente inserido com sucesso');
    
    ELSE
    
    dbms_output.put_line('ID do cliente já existe');
  END IF;
END IF;

-- opcao = U (UPDATE)
IF(p_opcao = 'U') THEN
  IF(v_controle = 1) THEN
    UPDATE tb_cliente_teste SET ds_cliente        = p_descricao,
                                nm_cliente        = p_nome,
                                valor             = p_valor,
                                fg_ativo          = p_fg_ativo
    WHERE id_cliente = p_id_cliente
    AND fg_ativo = 1;
    
    COMMIT;
    
    dbms_output.put_line('Cliente Alterado com sucesso');
    
    ELSE
      dbms_output.put_line('ID do cliente não existe');
  END IF;
END IF;

-- opcao = D(DELETE)
IF(p_opcao = 'D') THEN
  IF(v_controle = 1) THEN
    DELETE
    FROM tb_cliente_teste
    WHERE id_cliente = p_id_cliente
    AND fg_ativo = 1;
    
    COMMIT;
    
    dbms_output.put_line('Cliente excluido com sucesso');
    
    ELSE
      dbms_output.put_line('ID do cliente não existe');
    
  END IF;
END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END manipula_dados;

SET serveroutput ON
BEGIN
  -- Testando a Inserção de tuplas
  --manipula_dados(2, 'Cliente 2', 'Nome do Cliente 1', 99.99, 1, 'I');
  --manipula_dados(1, 'Cliente 1', 'Nome Cliente 1', 22.33,1,'I');
  
  -- Testando a alteração de tuplas
  --manipula_dados(2, 'Cliente - Alterado hoje', 'Alterado', 99.99,1,'U');
  
  -- Testando a Remoção de Tuplas
  --manipula_dados(2, NULL, NULL, NULL, NULL, 'D');

END;

SELECT *
FROM tb_cliente_teste;

-- opcao inserir (parâmetro opcao = I)
CALL manipula_dados(1, 'Cliente 1', 'Nome Cliente 1', 22.33,1,'I');

-- opcao inserir (parâmetro opcao = I)
CALL manipula_dados(2, 'Cliente 2', 'Nome Cliente 2', 99.99,1,'I');

-- opcao alterar (parâmetro opcao = U)
CALL manipula_dados(2, 'Cliente - Alterado hoje', 'Alterado', 99.99,1,'U');

-- opcao excluir (parâmetro opcao = D)
CALL manipula_dados(2, NULL, NULL, NULL, NULL, 'D');