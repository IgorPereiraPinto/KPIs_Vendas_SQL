/*
  Projeto: KPIs_Vendas_SQL
  Análise: Ticket Médio e Preço Médio
  Objetivo:
    Calcular ticket médio e preço médio por mês, categoria e produto.
  Perguntas respondidas:
    - Qual o ticket médio por mês?
    - O preço médio está subindo ou caindo?
  Definições de KPIs:
    Ticket_Medio = Receita / Qtde_Vendas
    Preco_Medio = Receita / Qtde_Itens
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
        SUM(Qtde * Valor_Unit) AS Receita,
        SUM(Qtde) AS Qtde_Itens,
        COUNT(DISTINCT Num_Venda) AS Qtde_Vendas,
        CASE
            WHEN COUNT(DISTINCT Num_Venda) = 0 THEN NULL
            ELSE SUM(Qtde * Valor_Unit) / NULLIF(COUNT(DISTINCT Num_Venda), 0)
        END AS Ticket_Medio,
        CASE
            WHEN SUM(Qtde) = 0 THEN NULL
            ELSE SUM(Qtde * Valor_Unit) / NULLIF(SUM(Qtde), 0)
        END AS Preco_Medio
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
