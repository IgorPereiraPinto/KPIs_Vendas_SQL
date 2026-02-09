/*
  Projeto: KPIs_Vendas_SQL
  Análise: Quantidade de Vendas e Itens
  Objetivo:
    Medir volume de vendas e itens por mês, categoria e produto.
  Perguntas respondidas:
    - Quantas vendas e itens tivemos por mês?
    - Qual produto/categoria vende mais em volume?
  Definições de KPIs:
    Qtde_Itens = SUM(Qtde)
    Qtde_Vendas = COUNT DISTINCT (Num_Venda)
  Premissas / Limitações:
    - Data padrão: Data Pedido
  Como usar (filtros de data/categoria/produto):
    Filtre por Ano/Mes, Categoria ou Produto.
*/
WITH cte_base AS (
    SELECT
        cal.Ano,
        cal.Mes,
        dp.Categoria,
        dp.Produto,
        fv.Num_Venda,
        fv.Qtde
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
        COUNT(DISTINCT Num_Venda) AS Qtde_Vendas
    FROM cte_base
    GROUP BY Ano, Mes, Categoria, Produto
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
FROM cte_final;
