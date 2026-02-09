/*
  Projeto: KPIs_Vendas_SQL
  Script: Transformações Staging
  Objetivo:
    Limpar e padronizar dados das tabelas raw.
  Inputs:
    Tabelas dbo.raw_*.
  Outputs:
    Tabelas dbo.stg_* padronizadas.
*/

-- Exemplo: staging de vendas
CREATE TABLE dbo.stg_fVendas (
    Num_Venda NVARCHAR(50) NOT NULL,
    Id_Produto NVARCHAR(50) NOT NULL,
    Id_Cliente NVARCHAR(50) NULL,
    Id_Pgto NVARCHAR(50) NULL,
    Id_Status NVARCHAR(50) NULL,
    Id_Unidade NVARCHAR(50) NULL,
    Id_Vendedor NVARCHAR(50) NULL,
    Data_Pedido DATE NOT NULL,
    Data_Envio DATE NULL,
    Qtde DECIMAL(18, 2) NOT NULL,
    Valor_Unit DECIMAL(18, 2) NOT NULL,
    Custo_Unit DECIMAL(18, 2) NULL,
    Despesa_Unit DECIMAL(18, 2) NULL,
    Impostos_Unit DECIMAL(18, 2) NULL,
    Comissao_Unit DECIMAL(18, 2) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
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
  AND Valor_Unit >= 0;

-- Exemplo: staging de produtos
CREATE TABLE dbo.stg_dProdutos (
    Id_Produto NVARCHAR(50) NOT NULL,
    Produto NVARCHAR(200) NULL,
    Categoria NVARCHAR(100) NULL,
    Marca NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

INSERT INTO dbo.stg_dProdutos (Id_Produto, Produto, Categoria, Marca)
SELECT
    LTRIM(RTRIM(Id_Produto)) AS Id_Produto,
    NULLIF(LTRIM(RTRIM(Produto)), '') AS Produto,
    NULLIF(LTRIM(RTRIM(Categoria)), '') AS Categoria,
    NULLIF(LTRIM(RTRIM(Marca)), '') AS Marca
FROM dbo.raw_dProdutos
WHERE Id_Produto IS NOT NULL;

-- Replicar padrão para stg_dClientes, stg_dVendedores, stg_dPagamento, stg_dStatus, stg_dUnidades, stg_fMetas.
