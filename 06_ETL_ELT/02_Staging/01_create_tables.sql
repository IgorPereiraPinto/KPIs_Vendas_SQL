/*
  Projeto: KPIs_Vendas_SQL
  Script: 01_create_tables.sql (Staging)
  Objetivo:
    Criar tabelas de staging com tipos padronizados.
  Entradas:
    Tabelas dbo.raw_*.
  Saídas:
    Tabelas dbo.stg_*.
*/

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

CREATE TABLE dbo.stg_dProdutos (
    Id_Produto NVARCHAR(50) NOT NULL,
    Produto NVARCHAR(200) NULL,
    Categoria NVARCHAR(100) NULL,
    Marca NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.stg_dClientes (
    Id_Cliente NVARCHAR(50) NOT NULL,
    Cliente NVARCHAR(200) NULL,
    Cidade NVARCHAR(100) NULL,
    Estado NVARCHAR(50) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.stg_dVendedores (
    Id_Vendedor NVARCHAR(50) NOT NULL,
    Vendedor NVARCHAR(200) NULL,
    Gerente NVARCHAR(200) NULL,
    URL_Foto NVARCHAR(500) NULL,
    URL_Foto_Inteira NVARCHAR(500) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.stg_dPagamento (
    Id_Pagamento NVARCHAR(50) NOT NULL,
    Forma_de_Pagamento NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.stg_dStatus (
    Id_Status NVARCHAR(50) NOT NULL,
    Status NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.stg_dUnidades (
    Id_Unidade NVARCHAR(50) NOT NULL,
    Unidade NVARCHAR(200) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.stg_fMetas (
    Data DATE NOT NULL,
    Id_Vendedor NVARCHAR(50) NOT NULL,
    Meta DECIMAL(18, 2) NOT NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
