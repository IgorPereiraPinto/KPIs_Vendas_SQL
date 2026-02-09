/*
  Projeto: KPIs_Vendas_SQL
  Script: CREATE TABLE - Camada DW
  Objetivo:
    Criar tabelas dimensionais e fato no Data Warehouse.
  Entradas:
    Tabelas dbo.stg_*.
  Saídas:
    Tabelas dbo.dw_*.
*/

CREATE TABLE dbo.dw_dProdutos (
    Produto_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Produto NVARCHAR(50) NOT NULL,
    Produto NVARCHAR(200) NULL,
    Categoria NVARCHAR(100) NULL,
    Marca NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dw_dClientes (
    Cliente_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Cliente NVARCHAR(50) NOT NULL,
    Cliente NVARCHAR(200) NULL,
    Cidade NVARCHAR(100) NULL,
    Estado NVARCHAR(50) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dw_dVendedores (
    Vendedor_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Vendedor NVARCHAR(50) NOT NULL,
    Vendedor NVARCHAR(200) NULL,
    Gerente NVARCHAR(200) NULL,
    URL_Foto NVARCHAR(500) NULL,
    URL_Foto_Inteira NVARCHAR(500) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dw_dPagamento (
    Pagamento_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Pagamento NVARCHAR(50) NOT NULL,
    Forma_de_Pagamento NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dw_dStatus (
    Status_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Status NVARCHAR(50) NOT NULL,
    Status NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dw_dUnidades (
    Unidade_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Unidade NVARCHAR(50) NOT NULL,
    Unidade NVARCHAR(200) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dw_fVendas (
    Venda_SK INT IDENTITY(1,1) PRIMARY KEY,
    Num_Venda NVARCHAR(50) NOT NULL,
    Produto_SK INT NOT NULL,
    Cliente_SK INT NULL,
    Vendedor_SK INT NULL,
    Pagamento_SK INT NULL,
    Status_SK INT NULL,
    Unidade_SK INT NULL,
    Data_Pedido DATE NOT NULL,
    Data_Envio DATE NULL,
    Qtde DECIMAL(18, 2) NOT NULL,
    Valor_Unit DECIMAL(18, 2) NOT NULL,
    Custo_Unit DECIMAL(18, 2) NULL,
    Despesa_Unit DECIMAL(18, 2) NULL,
    Impostos_Unit DECIMAL(18, 2) NULL,
    Comissao_Unit DECIMAL(18, 2) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_dw_fVendas_Produto FOREIGN KEY (Produto_SK) REFERENCES dbo.dw_dProdutos(Produto_SK),
    CONSTRAINT FK_dw_fVendas_Cliente FOREIGN KEY (Cliente_SK) REFERENCES dbo.dw_dClientes(Cliente_SK),
    CONSTRAINT FK_dw_fVendas_Vendedor FOREIGN KEY (Vendedor_SK) REFERENCES dbo.dw_dVendedores(Vendedor_SK),
    CONSTRAINT FK_dw_fVendas_Pagamento FOREIGN KEY (Pagamento_SK) REFERENCES dbo.dw_dPagamento(Pagamento_SK),
    CONSTRAINT FK_dw_fVendas_Status FOREIGN KEY (Status_SK) REFERENCES dbo.dw_dStatus(Status_SK),
    CONSTRAINT FK_dw_fVendas_Unidade FOREIGN KEY (Unidade_SK) REFERENCES dbo.dw_dUnidades(Unidade_SK)
);

CREATE TABLE dbo.dw_fMetas (
    Meta_SK INT IDENTITY(1,1) PRIMARY KEY,
    Data DATE NOT NULL,
    Vendedor_SK INT NOT NULL,
    Meta DECIMAL(18, 2) NOT NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_dw_fMetas_Vendedor FOREIGN KEY (Vendedor_SK) REFERENCES dbo.dw_dVendedores(Vendedor_SK)
);
