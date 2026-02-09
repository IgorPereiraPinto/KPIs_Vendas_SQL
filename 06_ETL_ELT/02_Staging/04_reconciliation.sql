/*
  Projeto: KPIs_Vendas_SQL
  Script: 04_reconciliation.sql (Staging)
  Objetivo:
    Reconciliar RAW vs STG em contagens e somas principais.
  Entradas:
    Tabelas dbo.raw_fVendas e dbo.stg_fVendas.
  Saídas:
    Resultados de reconciliação.
*/

SELECT
    'RAW' AS Camada,
    COUNT(*) AS Qtde_Linhas,
    SUM(Qtde * Valor_Unit) AS Receita
FROM dbo.raw_fVendas

UNION ALL

SELECT
    'STG' AS Camada,
    COUNT(*) AS Qtde_Linhas,
    SUM(Qtde * Valor_Unit) AS Receita
FROM dbo.stg_fVendas;
