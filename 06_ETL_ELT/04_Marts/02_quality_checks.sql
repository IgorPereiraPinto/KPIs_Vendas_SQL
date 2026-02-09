/*
  Projeto: KPIs_Vendas_SQL
  Script: 02_quality_checks.sql (Marts)
  Objetivo:
    Validar consistência básica na view de marts.
  Entradas:
    View dbo.vw_vendas_enriquecidas.
  Saídas:
    Registros em dbo.dq_resultado.
*/

INSERT INTO dbo.dq_resultado (Etapa, Regra, Valor_Encontrado)
SELECT 'MART', 'vw_vendas_enriquecidas: Num_Venda nulo', COUNT(*)
FROM dbo.vw_vendas_enriquecidas
WHERE Num_Venda IS NULL;
