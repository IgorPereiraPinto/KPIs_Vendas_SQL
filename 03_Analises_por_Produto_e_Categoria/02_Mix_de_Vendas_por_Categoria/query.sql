/*
  Projeto: KPIs_Vendas_SQL
  Análise: Mix de Vendas por Categoria
  Objetivo:
    Medir participação (%) das categorias em receita e volume.
  Perguntas respondidas:
    - Qual categoria representa maior parte da receita?
    - O mix está concentrado ou diversificado?
  Definições de KPIs:
    Mix_Receita_% = Receita_Categoria / Receita_Total
    Mix_Volume_% = Qtde_Categoria / Qtde_Total
  Premissas / Limitações:
    - Data padrão: Data Pedido
  Como usar (filtros de data/categoria/produto):
    Filtre por Ano/Mes para analisar períodos específicos.
*/
WITH cte_base AS (
    SELECT
        cal.Ano,
        cal.Mes,
        dp.Categoria,
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
        SUM(Qtde * Valor_Unit) AS Receita_Categoria,
        SUM(Qtde) AS Qtde_Categoria
    FROM cte_base
    GROUP BY Ano, Mes, Categoria
),
cte_rank AS (
    SELECT
        k.*, 
        SUM(Receita_Categoria) OVER (PARTITION BY Ano, Mes) AS Receita_Total,
        SUM(Qtde_Categoria) OVER (PARTITION BY Ano, Mes) AS Qtde_Total
    FROM cte_kpis AS k
),
cte_final AS (
    SELECT
        *,
        CASE
            WHEN Receita_Total = 0 THEN NULL
            ELSE Receita_Categoria / NULLIF(Receita_Total, 0)
        END AS Mix_Receita_Pct,
        CASE
            WHEN Qtde_Total = 0 THEN NULL
            ELSE Qtde_Categoria / NULLIF(Qtde_Total, 0)
        END AS Mix_Volume_Pct
    FROM cte_rank
)
SELECT
    *
FROM cte_final;
