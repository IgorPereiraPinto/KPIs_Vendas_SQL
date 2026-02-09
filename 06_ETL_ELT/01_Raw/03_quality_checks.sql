/*
  Projeto: KPIs_Vendas_SQL
  Script: 03_quality_checks.sql (Raw)
  Objetivo:
    Validar qualidade básica na camada RAW e registrar resultados.
  Entradas:
    Tabelas dbo.raw_*.
  Saídas:
    Registros em dbo.dq_resultado.
*/

INSERT INTO dbo.dq_resultado (Etapa, Regra, Valor_Encontrado)
SELECT 'RAW', 'raw_fVendas: Num_Venda nulo', COUNT(*)
FROM dbo.raw_fVendas
WHERE Num_Venda IS NULL;

INSERT INTO dbo.dq_resultado (Etapa, Regra, Valor_Encontrado)
SELECT 'RAW', 'raw_fVendas: Qtde <= 0', COUNT(*)
FROM dbo.raw_fVendas
WHERE Qtde <= 0;
