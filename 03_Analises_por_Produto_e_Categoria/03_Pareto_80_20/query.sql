/*
  Projeto: KPIs_Vendas_SQL
  Análise: Pareto 80/20 por Produto e Categoria
  Objetivo:
    Identificar quais produtos/categorias representam ~80% da receita.
  Perguntas respondidas:
    - Quais itens geram a maior parte do faturamento?
  Definições de KPIs:
    Pareto_Flag = 1 quando % acumulado <= 80%
  Premissas / Limitações:
    - Data padrão: Data Pedido
  Como usar (filtros de data/categoria/produto):
    Filtre por Ano/Mes para períodos específicos.
*/
WITH cte_base AS (
    SELECT
        cal.Ano,
        cal.Mes,
        dp.Categoria,
        dp.Produto,
        fv.Qtde,
        fv.Valor_Unit
    FROM fVendas AS fv
    LEFT JOIN dProdutos AS dp
        ON fv.Id_Produto = dp.Id_Produto
    LEFT JOIN dCalendario AS cal
        ON fv.Data_Pedido = cal.Data
),
cte_kpis AS (
    SELECT
        Ano,
        Mes,
        Categoria,
        Produto,
        SUM(Qtde * Valor_Unit) AS Receita
    FROM cte_base
    GROUP BY Ano, Mes, Categoria, Produto
),
cte_rank AS (
    SELECT
        *,
        SUM(Receita) OVER (PARTITION BY Ano, Mes) AS Receita_Total,
        SUM(Receita) OVER (
            PARTITION BY Ano, Mes
            ORDER BY Receita DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS Receita_Acumulada
    FROM cte_kpis
),
cte_final AS (
    SELECT
        *,
        CASE
            WHEN Receita_Total = 0 THEN NULL
            ELSE Receita_Acumulada / NULLIF(Receita_Total, 0)
        END AS Percentual_Acumulado,
        CASE
            WHEN Receita_Total = 0 THEN NULL
            WHEN Receita_Acumulada / NULLIF(Receita_Total, 0) <= 0.8 THEN 1
            ELSE 0
        END AS Pareto_Flag
    FROM cte_rank
)
SELECT
    *
FROM cte_final;
