/*
  Projeto: KPIs_Vendas_SQL
  Script: Transformações de Staging
  Objetivo:
    Limpar e padronizar dados das tabelas raw.
  Entradas:
    Tabelas dbo.raw_*.
  Saídas:
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

-- Staging de clientes
CREATE TABLE dbo.stg_dClientes (
    Id_Cliente NVARCHAR(50) NOT NULL,
    Cliente NVARCHAR(200) NULL,
    Cidade NVARCHAR(100) NULL,
    Estado NVARCHAR(50) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

INSERT INTO dbo.stg_dClientes (Id_Cliente, Cliente, Cidade, Estado)
SELECT
    LTRIM(RTRIM(Id_Cliente)) AS Id_Cliente,
    NULLIF(LTRIM(RTRIM(Cliente)), '') AS Cliente,
    NULLIF(LTRIM(RTRIM(Cidade)), '') AS Cidade,
    NULLIF(LTRIM(RTRIM(Estado)), '') AS Estado
FROM dbo.raw_dClientes
WHERE Id_Cliente IS NOT NULL;

-- Staging de vendedores
CREATE TABLE dbo.stg_dVendedores (
    Id_Vendedor NVARCHAR(50) NOT NULL,
    Vendedor NVARCHAR(200) NULL,
    Gerente NVARCHAR(200) NULL,
    URL_Foto NVARCHAR(500) NULL,
    URL_Foto_Inteira NVARCHAR(500) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

INSERT INTO dbo.stg_dVendedores (Id_Vendedor, Vendedor, Gerente, URL_Foto, URL_Foto_Inteira)
SELECT
    LTRIM(RTRIM(Id_Vendedor)) AS Id_Vendedor,
    NULLIF(LTRIM(RTRIM(Vendedor)), '') AS Vendedor,
    NULLIF(LTRIM(RTRIM(Gerente)), '') AS Gerente,
    NULLIF(LTRIM(RTRIM(URL_Foto)), '') AS URL_Foto,
    NULLIF(LTRIM(RTRIM(URL_Foto_Inteira)), '') AS URL_Foto_Inteira
FROM dbo.raw_dVendedores
WHERE Id_Vendedor IS NOT NULL;

-- Staging de pagamento
CREATE TABLE dbo.stg_dPagamento (
    Id_Pagamento NVARCHAR(50) NOT NULL,
    Forma_de_Pagamento NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

INSERT INTO dbo.stg_dPagamento (Id_Pagamento, Forma_de_Pagamento)
SELECT
    LTRIM(RTRIM(Id_Pagamento)) AS Id_Pagamento,
    NULLIF(LTRIM(RTRIM(Forma_de_Pagamento)), '') AS Forma_de_Pagamento
FROM dbo.raw_dPagamento
WHERE Id_Pagamento IS NOT NULL;

-- Staging de status
CREATE TABLE dbo.stg_dStatus (
    Id_Status NVARCHAR(50) NOT NULL,
    Status NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

INSERT INTO dbo.stg_dStatus (Id_Status, Status)
SELECT
    LTRIM(RTRIM(Id_Status)) AS Id_Status,
    NULLIF(LTRIM(RTRIM(Status)), '') AS Status
FROM dbo.raw_dStatus
WHERE Id_Status IS NOT NULL;

-- Staging de unidades
CREATE TABLE dbo.stg_dUnidades (
    Id_Unidade NVARCHAR(50) NOT NULL,
    Unidade NVARCHAR(200) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

INSERT INTO dbo.stg_dUnidades (Id_Unidade, Unidade)
SELECT
    LTRIM(RTRIM(Id_Unidade)) AS Id_Unidade,
    NULLIF(LTRIM(RTRIM(Unidade)), '') AS Unidade
FROM dbo.raw_dUnidades
WHERE Id_Unidade IS NOT NULL;

-- Staging de metas
CREATE TABLE dbo.stg_fMetas (
    Data DATE NOT NULL,
    Id_Vendedor NVARCHAR(50) NOT NULL,
    Meta DECIMAL(18, 2) NOT NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

INSERT INTO dbo.stg_fMetas (Data, Id_Vendedor, Meta)
SELECT
    CAST(Data AS DATE) AS Data,
    LTRIM(RTRIM(Id_Vendedor)) AS Id_Vendedor,
    CAST(Meta AS DECIMAL(18, 2)) AS Meta
FROM dbo.raw_fMetas
WHERE Data IS NOT NULL
  AND Id_Vendedor IS NOT NULL
  AND Meta IS NOT NULL;
