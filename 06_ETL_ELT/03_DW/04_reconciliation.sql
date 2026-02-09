/*
  Projeto: KPIs_Vendas_SQL
  Script: 04_reconciliation.sql (DW)
  Objetivo:
    Reconciliar STG vs DW em contagens e receita.
  Entradas:
    Tabelas dbo.stg_fVendas e dbo.fact_vendas.
  Saídas:
    Resultados de reconciliação.
*/

SELECT
    'STG' AS Camada,
    COUNT(*) AS Qtde_Linhas,
    SUM(Qtde * Valor_Unit) AS Receita
FROM dbo.stg_fVendas

UNION ALL

SELECT
    'DW' AS Camada,
    COUNT(*) AS Qtde_Linhas,
    SUM(Qtde * Valor_Unit) AS Receita
FROM dbo.fact_vendas;
