/*
  Projeto: KPIs_Vendas_SQL
  Análise: Efeito Preço vs Volume
  Objetivo:
    Decompor a variação de receita em efeito preço e efeito volume.
  Perguntas respondidas:
    - A receita cresceu por aumento de preço ou de volume?
  Definições de KPIs:
    Efeito_Preco = (Preco_Medio - Preco_Medio_Anterior) * Qtde_Anterior
    Efeito_Volume = (Qtde - Qtde_Anterior) * Preco_Medio_Anterior
  Premissas / Limitações:
    - Data padrão: Data Pedido
  Como usar (filtros de data/categoria/produto):
    Filtre por Categoria/Produto e período.
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
        SUM(Qtde) AS Qtde_Itens,
        SUM(Qtde * Valor_Unit) AS Receita,
        CASE
            WHEN SUM(Qtde) = 0 THEN NULL
            ELSE SUM(Qtde * Valor_Unit) / NULLIF(SUM(Qtde), 0)
        END AS Preco_Medio
    FROM cte_base
    GROUP BY Ano, Mes, Categoria, Produto
),
cte_rank AS (
    SELECT
        *,
        LAG(Qtde_Itens) OVER (PARTITION BY Categoria, Produto ORDER BY Ano, Mes) AS Qtde_Anterior,
        LAG(Preco_Medio) OVER (PARTITION BY Categoria, Produto ORDER BY Ano, Mes) AS Preco_Medio_Anterior,
        LAG(Receita) OVER (PARTITION BY Categoria, Produto ORDER BY Ano, Mes) AS Receita_Anterior
    FROM cte_kpis
),
cte_final AS (
    SELECT
        *,
        CASE
            WHEN Qtde_Anterior IS NULL OR Preco_Medio_Anterior IS NULL THEN NULL
            ELSE (Preco_Medio - Preco_Medio_Anterior) * Qtde_Anterior
        END AS Efeito_Preco,
        CASE
            WHEN Qtde_Anterior IS NULL OR Preco_Medio_Anterior IS NULL THEN NULL
            ELSE (Qtde_Itens - Qtde_Anterior) * Preco_Medio_Anterior
        END AS Efeito_Volume,
        CASE
            WHEN Receita_Anterior IS NULL THEN NULL
            ELSE Receita - Receita_Anterior
        END AS Variacao_Receita
    FROM cte_rank
)
SELECT
    *
FROM cte_final;
