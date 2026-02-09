/*
  Projeto: KPIs_Vendas_SQL
  Análise: Duplicidades e Anomalias
  Objetivo:
    Detectar duplicidades de itens e regras básicas inválidas.
  Perguntas respondidas:
    - Há itens duplicados por venda?
    - Existem quantidades ou preços inválidos?
  Definições de KPIs:
    Duplicados = COUNT(*) com Num_Venda + Id_Produto repetidos
  Premissas / Limitações:
    - Considera duplicidade no grão Num_Venda + Id_Produto.
  Como usar (filtros de data/categoria/produto):
    Filtre por Data_Pedido para períodos específicos.
*/
WITH cte_base AS (
    SELECT
        Num_Venda,
        Id_Produto,
        Data_Pedido,
        Qtde,
        Valor_Unit
    FROM fVendas
),
cte_kpis AS (
    SELECT
        'Duplicidade_Item' AS Tipo,
        COUNT(*) AS Total
    FROM (
        SELECT Num_Venda, Id_Produto, COUNT(*) AS Qtde_Registros
        FROM cte_base
        GROUP BY Num_Venda, Id_Produto
        HAVING COUNT(*) > 1
    ) AS dup

    UNION ALL
    SELECT 'Qtde_Invalida', COUNT(*) FROM cte_base WHERE Qtde <= 0
    UNION ALL
    SELECT 'Valor_Unit_Invalido', COUNT(*) FROM cte_base WHERE Valor_Unit < 0
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
ORDER BY Total DESC;
