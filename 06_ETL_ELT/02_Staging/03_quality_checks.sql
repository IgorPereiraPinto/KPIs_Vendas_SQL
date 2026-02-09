/*
  Projeto: KPIs_Vendas_SQL
  Script: 03_quality_checks.sql (Staging)
  Objetivo:
    Validar nulos, duplicidades e regras de valores na camada staging.
  Entradas:
    Tabelas dbo.stg_*.
  Saídas:
    Registros em dbo.dq_resultado.
*/

INSERT INTO dbo.dq_resultado (Etapa, Regra, Valor_Encontrado)
SELECT 'STG', 'stg_fVendas: Num_Venda nulo', COUNT(*)
FROM dbo.stg_fVendas
WHERE Num_Venda IS NULL;

INSERT INTO dbo.dq_resultado (Etapa, Regra, Valor_Encontrado)
SELECT 'STG', 'stg_fVendas: duplicidade Num_Venda + Id_Produto', COUNT(*)
FROM (
    SELECT Num_Venda, Id_Produto
    FROM dbo.stg_fVendas
    GROUP BY Num_Venda, Id_Produto
    HAVING COUNT(*) > 1
) AS dup;

INSERT INTO dbo.dq_resultado (Etapa, Regra, Valor_Encontrado)
SELECT 'STG', 'stg_fVendas: Qtde <= 0', COUNT(*)
FROM dbo.stg_fVendas
WHERE Qtde <= 0;

INSERT INTO dbo.dq_resultado (Etapa, Regra, Valor_Encontrado)
SELECT 'STG', 'stg_fVendas: Valor_Unit < 0', COUNT(*)
FROM dbo.stg_fVendas
WHERE Valor_Unit < 0;
