/*
  Projeto: KPIs_Vendas_SQL
  Análise: Validador de Chaves e Nulos
  Objetivo:
    Checar rapidamente nulos em chaves e campos críticos de fVendas.
  Perguntas respondidas:
    - Existem chaves nulas (produto, cliente, vendedor)?
    - Há medidas faltantes (Qtde, Valor Unit)?
  Definições de KPIs:
    Total_Nulos = contagem de linhas com campo nulo.
  Premissas / Limitações:
    - Considera apenas fVendas (origem principal).
  Como usar (filtros de data/categoria/produto):
    Filtre por Data_Pedido para validar períodos específicos.
*/
WITH cte_base AS (
    SELECT
        Data_Pedido,
        Num_Venda,
        Id_Produto,
        Id_Cliente,
        Id_Vendedor,
        Id_Pgto,
        Id_Status,
        Id_Unidade,
        Qtde,
        Valor_Unit,
        Custo_Unit,
        Despesa_Unit,
        Impostos_Unit,
        Comissao_Unit
    FROM fVendas
),
cte_kpis AS (
    SELECT
        'Id_Produto' AS Campo,
        COUNT(*) AS Total_Nulos
    FROM cte_base
    WHERE Id_Produto IS NULL

    UNION ALL
    SELECT 'Id_Cliente', COUNT(*) FROM cte_base WHERE Id_Cliente IS NULL
    UNION ALL
    SELECT 'Id_Vendedor', COUNT(*) FROM cte_base WHERE Id_Vendedor IS NULL
    UNION ALL
    SELECT 'Id_Pgto', COUNT(*) FROM cte_base WHERE Id_Pgto IS NULL
    UNION ALL
    SELECT 'Id_Status', COUNT(*) FROM cte_base WHERE Id_Status IS NULL
    UNION ALL
    SELECT 'Id_Unidade', COUNT(*) FROM cte_base WHERE Id_Unidade IS NULL
    UNION ALL
    SELECT 'Qtde', COUNT(*) FROM cte_base WHERE Qtde IS NULL
    UNION ALL
    SELECT 'Valor_Unit', COUNT(*) FROM cte_base WHERE Valor_Unit IS NULL
    UNION ALL
    SELECT 'Custo_Unit', COUNT(*) FROM cte_base WHERE Custo_Unit IS NULL
    UNION ALL
    SELECT 'Despesa_Unit', COUNT(*) FROM cte_base WHERE Despesa_Unit IS NULL
    UNION ALL
    SELECT 'Impostos_Unit', COUNT(*) FROM cte_base WHERE Impostos_Unit IS NULL
    UNION ALL
    SELECT 'Comissao_Unit', COUNT(*) FROM cte_base WHERE Comissao_Unit IS NULL
),
cte_rank AS (
    SELECT
        *
    FROM cte_kpis
),
cte_final AS (
    SELECT
        *
    FROM cte_rank
)
SELECT
    *
FROM cte_final
ORDER BY Total_Nulos DESC, Campo;
