/*
  Projeto: KPIs_Vendas_SQL
  Script: CREATE TABLE - Camada Raw
  Objetivo:
    Criar tabelas raw para ingestão sem transformação.
  Entradas:
    Arquivos brutos/extrações dos sistemas fonte.
  Saídas:
    Tabelas raw_* criadas no schema dbo.
*/

CREATE TABLE dbo.raw_fVendas (
    Num_Venda NVARCHAR(50) NULL,
    Id_Produto NVARCHAR(50) NULL,
    Id_Cliente NVARCHAR(50) NULL,
    Id_Pgto NVARCHAR(50) NULL,
    Id_Status NVARCHAR(50) NULL,
    Id_Unidade NVARCHAR(50) NULL,
    Id_Vendedor NVARCHAR(50) NULL,
    Data_Pedido DATETIME2 NULL,
    Data_Envio DATETIME2 NULL,
    Qtde DECIMAL(18, 2) NULL,
    Valor_Unit DECIMAL(18, 2) NULL,
    Custo_Unit DECIMAL(18, 2) NULL,
    Despesa_Unit DECIMAL(18, 2) NULL,
    Impostos_Unit DECIMAL(18, 2) NULL,
    Comissao_Unit DECIMAL(18, 2) NULL,
    Ingested_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.raw_dProdutos (
    Id_Produto NVARCHAR(50) NULL,
    Produto NVARCHAR(200) NULL,
    Categoria NVARCHAR(100) NULL,
    Marca NVARCHAR(100) NULL,
    Ingested_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.raw_dClientes (
    Id_Cliente NVARCHAR(50) NULL,
    Cliente NVARCHAR(200) NULL,
    Cidade NVARCHAR(100) NULL,
    Estado NVARCHAR(50) NULL,
    Ingested_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.raw_dVendedores (
    Id_Vendedor NVARCHAR(50) NULL,
    Vendedor NVARCHAR(200) NULL,
    Gerente NVARCHAR(200) NULL,
    URL_Foto NVARCHAR(500) NULL,
    URL_Foto_Inteira NVARCHAR(500) NULL,
    Ingested_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.raw_dPagamento (
    Id_Pagamento NVARCHAR(50) NULL,
    Forma_de_Pagamento NVARCHAR(100) NULL,
    Ingested_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.raw_dStatus (
    Id_Status NVARCHAR(50) NULL,
    Status NVARCHAR(100) NULL,
    Ingested_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.raw_dUnidades (
    Id_Unidade NVARCHAR(50) NULL,
    Unidade NVARCHAR(200) NULL,
    Ingested_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.raw_fMetas (
    Data DATE NULL,
    Id_Vendedor NVARCHAR(50) NULL,
    Meta DECIMAL(18, 2) NULL,
    Ingested_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
