/*
  Projeto: KPIs_Vendas_SQL
  Script: 01_create_tables.sql (DW)
  Objetivo:
    Criar dimensões e fato no DW com chaves substitutas.
  Entradas:
    Tabelas dbo.stg_*.
  Saídas:
    Tabelas dbo.dim_* e dbo.fact_vendas.
*/

CREATE TABLE dbo.dim_produto (
    Produto_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Produto NVARCHAR(50) NOT NULL,
    Produto NVARCHAR(200) NULL,
    Categoria NVARCHAR(100) NULL,
    Marca NVARCHAR(100) NULL,
    dt_inicio_vigencia DATETIME2 NOT NULL,
    dt_fim_vigencia DATETIME2 NULL,
    flag_ativo BIT NOT NULL DEFAULT 1
);

CREATE TABLE dbo.dim_vendedor (
    Vendedor_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Vendedor NVARCHAR(50) NOT NULL,
    Vendedor NVARCHAR(200) NULL,
    Gerente NVARCHAR(200) NULL,
    URL_Foto NVARCHAR(500) NULL,
    URL_Foto_Inteira NVARCHAR(500) NULL,
    dt_inicio_vigencia DATETIME2 NOT NULL,
    dt_fim_vigencia DATETIME2 NULL,
    flag_ativo BIT NOT NULL DEFAULT 1
);

CREATE TABLE dbo.dim_cliente (
    Cliente_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Cliente NVARCHAR(50) NOT NULL,
    Cliente NVARCHAR(200) NULL,
    Cidade NVARCHAR(100) NULL,
    Estado NVARCHAR(50) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dim_pagamento (
    Pagamento_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Pagamento NVARCHAR(50) NOT NULL,
    Forma_de_Pagamento NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dim_status (
    Status_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Status NVARCHAR(50) NOT NULL,
    Status NVARCHAR(100) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dim_unidade (
    Unidade_SK INT IDENTITY(1,1) PRIMARY KEY,
    Id_Unidade NVARCHAR(50) NOT NULL,
    Unidade NVARCHAR(200) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.dim_calendario (
    Data_SK INT IDENTITY(1,1) PRIMARY KEY,
    Data DATE NOT NULL,
    Dia INT NULL,
    Mes INT NULL,
    Ano INT NULL
);

CREATE TABLE dbo.fact_vendas (
    Venda_SK INT IDENTITY(1,1) PRIMARY KEY,
    Num_Venda NVARCHAR(50) NOT NULL,
    Produto_SK INT NOT NULL,
    Cliente_SK INT NULL,
    Vendedor_SK INT NULL,
    Pagamento_SK INT NULL,
    Status_SK INT NULL,
    Unidade_SK INT NULL,
    Data_SK INT NOT NULL,
    Data_Envio DATE NULL,
    Qtde DECIMAL(18, 2) NOT NULL,
    Valor_Unit DECIMAL(18, 2) NOT NULL,
    Custo_Unit DECIMAL(18, 2) NULL,
    Despesa_Unit DECIMAL(18, 2) NULL,
    Impostos_Unit DECIMAL(18, 2) NULL,
    Comissao_Unit DECIMAL(18, 2) NULL,
    Updated_At DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT FK_fact_produto FOREIGN KEY (Produto_SK) REFERENCES dbo.dim_produto(Produto_SK),
    CONSTRAINT FK_fact_cliente FOREIGN KEY (Cliente_SK) REFERENCES dbo.dim_cliente(Cliente_SK),
    CONSTRAINT FK_fact_vendedor FOREIGN KEY (Vendedor_SK) REFERENCES dbo.dim_vendedor(Vendedor_SK),
    CONSTRAINT FK_fact_pagamento FOREIGN KEY (Pagamento_SK) REFERENCES dbo.dim_pagamento(Pagamento_SK),
    CONSTRAINT FK_fact_status FOREIGN KEY (Status_SK) REFERENCES dbo.dim_status(Status_SK),
    CONSTRAINT FK_fact_unidade FOREIGN KEY (Unidade_SK) REFERENCES dbo.dim_unidade(Unidade_SK),
    CONSTRAINT FK_fact_calendario FOREIGN KEY (Data_SK) REFERENCES dbo.dim_calendario(Data_SK)
);
