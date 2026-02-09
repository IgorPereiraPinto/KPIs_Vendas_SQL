/*
  Projeto: KPIs_Vendas_SQL
  Análise: KPIs por Vendedor
  Objetivo:
    Medir receita, resultado, margem e ticket por vendedor.
  Perguntas respondidas:
    - Qual vendedor traz mais resultado?
    - Quem tem maior margem?
  Definições de KPIs:
    Ticket_Medio = Receita / Qtde_Vendas
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
        dv.Vendedor,
        dv.Gerente,
        fv.Num_Venda,
        fv.Qtde,
        fv.Valor_Unit,
        fv.Custo_Unit,
        fv.Despesa_Unit,
        fv.Impostos_Unit,
        fv.Comissao_Unit
    FROM fVendas AS fv
    LEFT JOIN dProdutos AS dp
        ON fv.Id_Produto = dp.Id_Produto
    LEFT JOIN dVendedores AS dv
        ON fv.Id_Vendedor = dv.Id_Vendedor
    LEFT JOIN dCalendario AS cal
        ON fv.Data_Pedido = cal.Data
),
cte_kpis AS (
    SELECT
        Ano,
        Mes,
        Categoria,
        Produto,
        Vendedor,
        Gerente,
        SUM(Qtde * Valor_Unit) AS Receita,
        SUM(Qtde * Valor_Unit)
        - SUM(Qtde * Custo_Unit)
        - SUM(Qtde * Despesa_Unit)
        - SUM(Qtde * Impostos_Unit)
        - SUM(Qtde * Comissao_Unit) AS Resultado,
        COUNT(DISTINCT Num_Venda) AS Qtde_Vendas,
        CASE
            WHEN SUM(Qtde * Valor_Unit) = 0 THEN NULL
            ELSE (
                SUM(Qtde * Valor_Unit)
                - SUM(Qtde * Custo_Unit)
                - SUM(Qtde * Despesa_Unit)
                - SUM(Qtde * Impostos_Unit)
                - SUM(Qtde * Comissao_Unit)
            ) / NULLIF(SUM(Qtde * Valor_Unit), 0)
        END AS Margem_Pct,
        CASE
            WHEN COUNT(DISTINCT Num_Venda) = 0 THEN NULL
            ELSE SUM(Qtde * Valor_Unit) / NULLIF(COUNT(DISTINCT Num_Venda), 0)
        END AS Ticket_Medio
    FROM cte_base
    GROUP BY Ano, Mes, Categoria, Produto, Vendedor, Gerente
),
cte_rank AS (
    SELECT
        *,
        DENSE_RANK() OVER (PARTITION BY Ano, Mes ORDER BY Receita DESC) AS Rank_Receita
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
