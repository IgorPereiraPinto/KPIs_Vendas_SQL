/*
  Projeto: KPIs_Vendas_SQL
  Script: 03_quality_checks.sql (DW)
  Objetivo:
    Validar integridade das chaves e regras básicas no DW.
  Entradas:
    Tabelas dbo.dim_* e dbo.fact_vendas.
  Saídas:
    Registros em dbo.dq_resultado.
*/

INSERT INTO dbo.dq_resultado (Etapa, Regra, Valor_Encontrado)
SELECT 'DW', 'fact_vendas: Produto_SK nulo', COUNT(*)
FROM dbo.fact_vendas
WHERE Produto_SK IS NULL;

INSERT INTO dbo.dq_resultado (Etapa, Regra, Valor_Encontrado)
SELECT 'DW', 'fact_vendas: Qtde <= 0', COUNT(*)
FROM dbo.fact_vendas
WHERE Qtde <= 0;
