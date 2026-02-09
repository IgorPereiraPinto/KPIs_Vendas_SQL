/*
  Projeto: KPIs_Vendas_SQL
  Script: 02_load_incremental.sql (Raw)
  Objetivo:
    Exemplo de carga incremental para RAW com watermark e log.
  Entradas:
    Fonte externa (arquivos/ETL de extração).
  Saídas:
    Inserções em dbo.raw_* e atualização do controle de carga.
*/

DECLARE @Entidade NVARCHAR(100) = 'raw_fVendas';
DECLARE @UltimaCarga DATETIME2 = (
    SELECT Dt_Ultima_Carga FROM dbo.etl_controle_carga WHERE Entidade = @Entidade
);

-- Exemplo: carregar apenas registros novos (controlado pela extração).
-- Aqui você executaria o LOAD real (COPY, BULK INSERT, integração etc.).

-- Atualiza o controle de carga
MERGE dbo.etl_controle_carga AS target
USING (SELECT @Entidade AS Entidade) AS source
ON target.Entidade = source.Entidade
WHEN MATCHED THEN
    UPDATE SET Dt_Ultima_Carga = SYSUTCDATETIME(), Atualizado_Em = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (Entidade, Dt_Ultima_Carga)
    VALUES (@Entidade, SYSUTCDATETIME());
