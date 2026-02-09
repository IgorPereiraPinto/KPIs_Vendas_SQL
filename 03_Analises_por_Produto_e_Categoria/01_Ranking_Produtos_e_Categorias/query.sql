/*
  Projeto: KPIs_Vendas_SQL
  Análise: Ranking de Produtos e Categorias
  Objetivo:
    Criar ranking Top/Bottom por receita e margem.
  Perguntas respondidas:
    - Quais produtos e categorias mais faturam?
    - Quais têm maior ou menor margem?
  Definições de KPIs:
    Receita = Qtde * Valor Unit
    Margem_% = Resultado / Receita
  Premissas / Limitações:
    - Data padrão: Data Pedido
  Como usar (filtros de data/categoria/produto):
    Filtre por Ano/Mes e ajuste o TOP conforme necessidade.
*/
WITH cte_base AS (
    SELECT
        cal.Ano,
        cal.Mes,
        dp.Categoria,
        dp.Produto,
        fv.Qtde,
        fv.Valor_Unit,
        fv.Custo_Unit,
        fv.Despesa_Unit,
        fv.Impostos_Unit,
        fv.Comissao_Unit
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
        SUM(Qtde * Valor_Unit) AS Receita,
        SUM(Qtde * Valor_Unit)
        - SUM(Qtde * Custo_Unit)
        - SUM(Qtde * Despesa_Unit)
        - SUM(Qtde * Impostos_Unit)
        - SUM(Qtde * Comissao_Unit) AS Resultado,
        CASE
            WHEN SUM(Qtde * Valor_Unit) = 0 THEN NULL
            ELSE (
                SUM(Qtde * Valor_Unit)
                - SUM(Qtde * Custo_Unit)
                - SUM(Qtde * Despesa_Unit)
                - SUM(Qtde * Impostos_Unit)
                - SUM(Qtde * Comissao_Unit)
            ) / NULLIF(SUM(Qtde * Valor_Unit), 0)
        END AS Margem_Pct
    FROM cte_base
    GROUP BY Ano, Mes, Categoria, Produto
),
cte_rank AS (
    SELECT
        *,
        DENSE_RANK() OVER (PARTITION BY Ano, Mes ORDER BY Receita DESC) AS Rank_Receita,
        DENSE_RANK() OVER (PARTITION BY Ano, Mes ORDER BY Margem_Pct DESC) AS Rank_Margem
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
WHERE Rank_Receita <= 10 OR Rank_Margem <= 10;
