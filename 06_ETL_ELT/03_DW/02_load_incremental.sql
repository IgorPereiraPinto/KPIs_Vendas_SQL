/*
  Projeto: KPIs_Vendas_SQL
  Script: 02_load_incremental.sql (DW)
  Objetivo:
    Carregar DW com SCD2 em dim_produto e dim_vendedor e fato incremental.
  Entradas:
    Tabelas dbo.stg_* e dbo.etl_controle_carga.
  Saídas:
    Tabelas dbo.dim_* e dbo.fact_vendas.
*/

DECLARE @Entidade NVARCHAR(100) = 'fact_vendas';
DECLARE @UltimaCarga DATETIME2 = (
    SELECT Dt_Ultima_Carga FROM dbo.etl_controle_carga WHERE Entidade = @Entidade
);

-- SCD Tipo 2 para dim_produto
UPDATE dp
SET dt_fim_vigencia = SYSUTCDATETIME(), flag_ativo = 0
FROM dbo.dim_produto AS dp
JOIN dbo.stg_dProdutos AS sp
  ON dp.Id_Produto = sp.Id_Produto
WHERE dp.flag_ativo = 1
  AND (
      ISNULL(dp.Produto, '') <> ISNULL(sp.Produto, '')
      OR ISNULL(dp.Categoria, '') <> ISNULL(sp.Categoria, '')
      OR ISNULL(dp.Marca, '') <> ISNULL(sp.Marca, '')
  );

INSERT INTO dbo.dim_produto (Id_Produto, Produto, Categoria, Marca, dt_inicio_vigencia, dt_fim_vigencia, flag_ativo)
SELECT
    sp.Id_Produto,
    sp.Produto,
    sp.Categoria,
    sp.Marca,
    SYSUTCDATETIME(),
    NULL,
    1
FROM dbo.stg_dProdutos AS sp
LEFT JOIN dbo.dim_produto AS dp
  ON sp.Id_Produto = dp.Id_Produto AND dp.flag_ativo = 1
WHERE dp.Produto_SK IS NULL
   OR (
      ISNULL(dp.Produto, '') <> ISNULL(sp.Produto, '')
      OR ISNULL(dp.Categoria, '') <> ISNULL(sp.Categoria, '')
      OR ISNULL(dp.Marca, '') <> ISNULL(sp.Marca, '')
   );

-- SCD Tipo 2 para dim_vendedor
UPDATE dv
SET dt_fim_vigencia = SYSUTCDATETIME(), flag_ativo = 0
FROM dbo.dim_vendedor AS dv
JOIN dbo.stg_dVendedores AS sv
  ON dv.Id_Vendedor = sv.Id_Vendedor
WHERE dv.flag_ativo = 1
  AND (
      ISNULL(dv.Vendedor, '') <> ISNULL(sv.Vendedor, '')
      OR ISNULL(dv.Gerente, '') <> ISNULL(sv.Gerente, '')
      OR ISNULL(dv.URL_Foto, '') <> ISNULL(sv.URL_Foto, '')
      OR ISNULL(dv.URL_Foto_Inteira, '') <> ISNULL(sv.URL_Foto_Inteira, '')
  );

INSERT INTO dbo.dim_vendedor (Id_Vendedor, Vendedor, Gerente, URL_Foto, URL_Foto_Inteira, dt_inicio_vigencia, dt_fim_vigencia, flag_ativo)
SELECT
    sv.Id_Vendedor,
    sv.Vendedor,
    sv.Gerente,
    sv.URL_Foto,
    sv.URL_Foto_Inteira,
    SYSUTCDATETIME(),
    NULL,
    1
FROM dbo.stg_dVendedores AS sv
LEFT JOIN dbo.dim_vendedor AS dv
  ON sv.Id_Vendedor = dv.Id_Vendedor AND dv.flag_ativo = 1
WHERE dv.Vendedor_SK IS NULL
   OR (
      ISNULL(dv.Vendedor, '') <> ISNULL(sv.Vendedor, '')
      OR ISNULL(dv.Gerente, '') <> ISNULL(sv.Gerente, '')
      OR ISNULL(dv.URL_Foto, '') <> ISNULL(sv.URL_Foto, '')
      OR ISNULL(dv.URL_Foto_Inteira, '') <> ISNULL(sv.URL_Foto_Inteira, '')
   );

-- Dimensões Tipo 1 (upsert simples)
MERGE dbo.dim_cliente AS target
USING dbo.stg_dClientes AS source
ON target.Id_Cliente = source.Id_Cliente
WHEN MATCHED THEN
    UPDATE SET target.Cliente = source.Cliente, target.Cidade = source.Cidade, target.Estado = source.Estado
WHEN NOT MATCHED THEN
    INSERT (Id_Cliente, Cliente, Cidade, Estado)
    VALUES (source.Id_Cliente, source.Cliente, source.Cidade, source.Estado);

MERGE dbo.dim_pagamento AS target
USING dbo.stg_dPagamento AS source
ON target.Id_Pagamento = source.Id_Pagamento
WHEN MATCHED THEN
    UPDATE SET target.Forma_de_Pagamento = source.Forma_de_Pagamento
WHEN NOT MATCHED THEN
    INSERT (Id_Pagamento, Forma_de_Pagamento)
    VALUES (source.Id_Pagamento, source.Forma_de_Pagamento);

MERGE dbo.dim_status AS target
USING dbo.stg_dStatus AS source
ON target.Id_Status = source.Id_Status
WHEN MATCHED THEN
    UPDATE SET target.Status = source.Status
WHEN NOT MATCHED THEN
    INSERT (Id_Status, Status)
    VALUES (source.Id_Status, source.Status);

MERGE dbo.dim_unidade AS target
USING dbo.stg_dUnidades AS source
ON target.Id_Unidade = source.Id_Unidade
WHEN MATCHED THEN
    UPDATE SET target.Unidade = source.Unidade
WHEN NOT MATCHED THEN
    INSERT (Id_Unidade, Unidade)
    VALUES (source.Id_Unidade, source.Unidade);

-- Carrega calendário com datas da staging
INSERT INTO dbo.dim_calendario (Data, Dia, Mes, Ano)
SELECT DISTINCT
    sf.Data_Pedido,
    DAY(sf.Data_Pedido),
    MONTH(sf.Data_Pedido),
    YEAR(sf.Data_Pedido)
FROM dbo.stg_fVendas AS sf
LEFT JOIN dbo.dim_calendario AS dc ON sf.Data_Pedido = dc.Data
WHERE dc.Data_SK IS NULL;

-- Fato incremental (watermark por Data_Pedido)
INSERT INTO dbo.fact_vendas
(
    Num_Venda, Produto_SK, Cliente_SK, Vendedor_SK, Pagamento_SK, Status_SK, Unidade_SK,
    Data_SK, Data_Envio, Qtde, Valor_Unit, Custo_Unit, Despesa_Unit, Impostos_Unit, Comissao_Unit
)
SELECT
    sf.Num_Venda,
    dp.Produto_SK,
    dc.Cliente_SK,
    dv.Vendedor_SK,
    dpg.Pagamento_SK,
    ds.Status_SK,
    du.Unidade_SK,
    cal.Data_SK,
    sf.Data_Envio,
    sf.Qtde,
    sf.Valor_Unit,
    sf.Custo_Unit,
    sf.Despesa_Unit,
    sf.Impostos_Unit,
    sf.Comissao_Unit
FROM dbo.stg_fVendas AS sf
JOIN dbo.dim_produto AS dp ON sf.Id_Produto = dp.Id_Produto AND dp.flag_ativo = 1
LEFT JOIN dbo.dim_cliente AS dc ON sf.Id_Cliente = dc.Id_Cliente
LEFT JOIN dbo.dim_vendedor AS dv ON sf.Id_Vendedor = dv.Id_Vendedor AND dv.flag_ativo = 1
LEFT JOIN dbo.dim_pagamento AS dpg ON sf.Id_Pgto = dpg.Id_Pagamento
LEFT JOIN dbo.dim_status AS ds ON sf.Id_Status = ds.Id_Status
LEFT JOIN dbo.dim_unidade AS du ON sf.Id_Unidade = du.Id_Unidade
JOIN dbo.dim_calendario AS cal ON sf.Data_Pedido = cal.Data
WHERE (@UltimaCarga IS NULL OR sf.Data_Pedido > @UltimaCarga);

MERGE dbo.etl_controle_carga AS target
USING (SELECT @Entidade AS Entidade) AS source
ON target.Entidade = source.Entidade
WHEN MATCHED THEN
    UPDATE SET Dt_Ultima_Carga = SYSUTCDATETIME(), Atualizado_Em = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (Entidade, Dt_Ultima_Carga)
    VALUES (@Entidade, SYSUTCDATETIME());
