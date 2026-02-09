/*
  Projeto: KPIs_Vendas_SQL
  Análise: Crescimento MoM e YoY
  Objetivo:
    Calcular variação mês contra mês e ano contra ano por produto e categoria.
  Perguntas respondidas:
    - Qual o crescimento de receita mês a mês?
    - Como está a performance vs ano anterior?
  Definições de KPIs:
    MoM = Receita_Mes / Receita_Mes_Anterior - 1
    YoY = Receita_Mes / Receita_Ano_Anterior - 1
  Premissas / Limitações:
    - Data padrão: Data Pedido
  Como usar (filtros de data/categoria/produto):
    Filtre por Categoria/Produto para análises específicas.
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
        LAG(Receita) OVER (PARTITION BY Categoria, Produto ORDER BY Ano, Mes) AS Receita_Mes_Anterior,
        LAG(Receita, 12) OVER (PARTITION BY Categoria, Produto ORDER BY Ano, Mes) AS Receita_Ano_Anterior
    FROM cte_kpis
),
cte_final AS (
    SELECT
        *,
        CASE
            WHEN Receita_Mes_Anterior = 0 THEN NULL
            ELSE (Receita / NULLIF(Receita_Mes_Anterior, 0)) - 1
        END AS MoM_Pct,
        CASE
            WHEN Receita_Ano_Anterior = 0 THEN NULL
            ELSE (Receita / NULLIF(Receita_Ano_Anterior, 0)) - 1
        END AS YoY_Pct
    FROM cte_rank
)
SELECT
    *
FROM cte_final;
