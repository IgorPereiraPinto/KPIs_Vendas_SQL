/*
  Projeto: KPIs_Vendas_SQL
  Script: Log e Stored Procedures ETL
  Objetivo:
    Criar tabela de log e exemplos de stored procedures para ETL.
  Inputs:
    Tabelas raw/stg/dw.
  Outputs:
    dbo.etl_run_log e procedures usp_etl_*.
*/

CREATE TABLE dbo.etl_run_log (
    Run_Id INT IDENTITY(1,1) PRIMARY KEY,
    Processo NVARCHAR(100) NOT NULL,
    Status NVARCHAR(20) NOT NULL,
    Inicio_Em DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    Fim_Em DATETIME2 NULL,
    Linhas_Entrada INT NULL,
    Linhas_Saida INT NULL,
    Observacao NVARCHAR(500) NULL
);
GO

CREATE OR ALTER PROCEDURE dbo.usp_etl_load_raw
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.etl_run_log (Processo, Status, Observacao)
    VALUES ('load_raw', 'STARTED', 'Inicio da carga raw');

    -- Exemplo: cargas raw ocorrem via integração externa.

    UPDATE dbo.etl_run_log
    SET Status = 'FINISHED', Fim_Em = SYSUTCDATETIME()
    WHERE Run_Id = SCOPE_IDENTITY();
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_etl_transform_stg
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.etl_run_log (Processo, Status, Observacao)
    VALUES ('transform_stg', 'STARTED', 'Transformação staging');

    -- Exemplo: chamar scripts de staging.

    UPDATE dbo.etl_run_log
    SET Status = 'FINISHED', Fim_Em = SYSUTCDATETIME()
    WHERE Run_Id = SCOPE_IDENTITY();
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_etl_merge_dw
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.etl_run_log (Processo, Status, Observacao)
    VALUES ('merge_dw', 'STARTED', 'Merge para DW');

    -- Exemplo: executar MERGE nas dimensões e fato.

    UPDATE dbo.etl_run_log
    SET Status = 'FINISHED', Fim_Em = SYSUTCDATETIME()
    WHERE Run_Id = SCOPE_IDENTITY();
END;
GO
