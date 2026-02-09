/*
  Projeto: KPIs_Vendas_SQL
  Script: Controle de Carga (Watermark)
  Objetivo:
    Criar tabela de controle para cargas incrementais por entidade.
  Entradas:
    Processos ETL/ELT.
  Saídas:
    Tabela dbo.etl_controle_carga.
*/

IF OBJECT_ID('dbo.etl_controle_carga', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.etl_controle_carga (
        Entidade NVARCHAR(100) NOT NULL PRIMARY KEY,
        Dt_Ultima_Carga DATETIME2 NULL,
        Dt_Ultima_Carga_Envio DATETIME2 NULL,
        Observacao NVARCHAR(500) NULL,
        Atualizado_Em DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END;
GO

IF OBJECT_ID('dbo.dq_resultado', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.dq_resultado (
        Dq_Id INT IDENTITY(1,1) PRIMARY KEY,
        Etapa NVARCHAR(50) NOT NULL,
        Regra NVARCHAR(200) NOT NULL,
        Valor_Encontrado INT NOT NULL,
        Gravado_Em DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END;
GO
