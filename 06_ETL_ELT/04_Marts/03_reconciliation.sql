/*
  Projeto: KPIs_Vendas_SQL
  Script: 03_reconciliation.sql (Marts)
  Objetivo:
    Reconciliar DW vs MART em contagens e receita.
  Entradas:
    Tabelas dbo.fact_vendas e view dbo.vw_vendas_enriquecidas.
  Saídas:
    Resultados de reconciliação.
*/

SELECT
    'DW' AS Camada,
    COUNT(*) AS Qtde_Linhas,
    SUM(Qtde * Valor_Unit) AS Receita
FROM dbo.fact_vendas

UNION ALL

SELECT
    'MART' AS Camada,
    COUNT(*) AS Qtde_Linhas,
    SUM(Receita) AS Receita
FROM dbo.vw_vendas_enriquecidas;
