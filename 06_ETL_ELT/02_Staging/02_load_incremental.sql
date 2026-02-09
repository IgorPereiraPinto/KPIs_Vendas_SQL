/*
  Projeto: KPIs_Vendas_SQL
  Script: 02_load_incremental.sql (Staging)
  Objetivo:
    Carregar staging com limpeza, padronização e filtro incremental.
  Entradas:
    Tabelas dbo.raw_* e dbo.etl_controle_carga.
  Saídas:
    Tabelas dbo.stg_* atualizadas.
*/

DECLARE @Entidade NVARCHAR(100) = 'stg_fVendas';
DECLARE @UltimaCarga DATETIME2 = (
    SELECT Dt_Ultima_Carga FROM dbo.etl_controle_carga WHERE Entidade = @Entidade
);

INSERT INTO dbo.stg_fVendas
(
    Num_Venda, Id_Produto, Id_Cliente, Id_Pgto, Id_Status, Id_Unidade, Id_Vendedor,
    Data_Pedido, Data_Envio, Qtde, Valor_Unit, Custo_Unit, Despesa_Unit, Impostos_Unit, Comissao_Unit
)
SELECT
    LTRIM(RTRIM(Num_Venda)) AS Num_Venda,
    LTRIM(RTRIM(Id_Produto)) AS Id_Produto,
    NULLIF(LTRIM(RTRIM(Id_Cliente)), '') AS Id_Cliente,
    NULLIF(LTRIM(RTRIM(Id_Pgto)), '') AS Id_Pgto,
    NULLIF(LTRIM(RTRIM(Id_Status)), '') AS Id_Status,
    NULLIF(LTRIM(RTRIM(Id_Unidade)), '') AS Id_Unidade,
    NULLIF(LTRIM(RTRIM(Id_Vendedor)), '') AS Id_Vendedor,
    CAST(Data_Pedido AS DATE) AS Data_Pedido,
    CAST(Data_Envio AS DATE) AS Data_Envio,
    CAST(Qtde AS DECIMAL(18, 2)) AS Qtde,
    CAST(Valor_Unit AS DECIMAL(18, 2)) AS Valor_Unit,
    CAST(Custo_Unit AS DECIMAL(18, 2)) AS Custo_Unit,
    CAST(Despesa_Unit AS DECIMAL(18, 2)) AS Despesa_Unit,
    CAST(Impostos_Unit AS DECIMAL(18, 2)) AS Impostos_Unit,
    CAST(Comissao_Unit AS DECIMAL(18, 2)) AS Comissao_Unit
FROM dbo.raw_fVendas
WHERE Data_Pedido IS NOT NULL
  AND Qtde > 0
  AND Valor_Unit >= 0
  AND (@UltimaCarga IS NULL OR Data_Pedido > @UltimaCarga);

MERGE dbo.etl_controle_carga AS target
USING (SELECT @Entidade AS Entidade) AS source
ON target.Entidade = source.Entidade
WHEN MATCHED THEN
    UPDATE SET Dt_Ultima_Carga = SYSUTCDATETIME(), Atualizado_Em = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (Entidade, Dt_Ultima_Carga)
    VALUES (@Entidade, SYSUTCDATETIME());

-- Dimensões (exemplo incremental por dt_carga)
INSERT INTO dbo.stg_dProdutos (Id_Produto, Produto, Categoria, Marca)
SELECT
    LTRIM(RTRIM(Id_Produto)),
    NULLIF(LTRIM(RTRIM(Produto)), ''),
    NULLIF(LTRIM(RTRIM(Categoria)), ''),
    NULLIF(LTRIM(RTRIM(Marca)), '')
FROM dbo.raw_dProdutos
WHERE Id_Produto IS NOT NULL
  AND (dt_carga > ISNULL((SELECT Dt_Ultima_Carga FROM dbo.etl_controle_carga WHERE Entidade = 'stg_dProdutos'), '1900-01-01'));
