/*
  Projeto: KPIs_Vendas_SQL
  Script: Validações Staging
  Objetivo:
    Validar schema, nulos, duplicidades e ranges na camada staging.
  Entradas:
    Tabelas dbo.stg_*.
  Saídas:
    Resultados de auditoria (consultas de verificação).
*/

-- Nulos em chaves críticas
SELECT 'stg_fVendas' AS Tabela, 'Num_Venda' AS Campo, COUNT(*) AS Total_Nulos
FROM dbo.stg_fVendas WHERE Num_Venda IS NULL
UNION ALL
SELECT 'stg_fVendas', 'Id_Produto', COUNT(*) FROM dbo.stg_fVendas WHERE Id_Produto IS NULL
UNION ALL
SELECT 'stg_dProdutos', 'Id_Produto', COUNT(*) FROM dbo.stg_dProdutos WHERE Id_Produto IS NULL;

-- Duplicidade por Num_Venda + Id_Produto
SELECT Num_Venda, Id_Produto, COUNT(*) AS Qtde
FROM dbo.stg_fVendas
GROUP BY Num_Venda, Id_Produto
HAVING COUNT(*) > 1;

-- Ranges básicos
SELECT COUNT(*) AS Qtde_Invalidos
FROM dbo.stg_fVendas
WHERE Qtde <= 0 OR Valor_Unit < 0;
