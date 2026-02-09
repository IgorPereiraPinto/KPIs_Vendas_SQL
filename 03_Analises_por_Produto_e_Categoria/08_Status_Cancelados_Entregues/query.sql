/*
  Projeto: KPIs_Vendas_SQL
  Análise: Status de Vendas (Cancelados/Entregues)
  Objetivo:
    Medir impacto do status da venda em receita e margem.
  Perguntas respondidas:
    - Qual o impacto de cancelamentos na receita?
  Definições de KPIs:
    Taxa_Status = Qtde_Vendas_Status / Qtde_Vendas_Total
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
        ds.Status,
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
    LEFT JOIN dStatus AS ds
        ON fv.Id_Status = ds.Id_Status
    LEFT JOIN dCalendario AS cal
        ON fv.Data_Pedido = cal.Data
),
cte_kpis AS (
    SELECT
        Ano,
        Mes,
        Categoria,
        Produto,
        Status,
        SUM(Qtde * Valor_Unit) AS Receita,
        SUM(Qtde * Valor_Unit)
        - SUM(Qtde * Custo_Unit)
        - SUM(Qtde * Despesa_Unit)
        - SUM(Qtde * Impostos_Unit)
        - SUM(Qtde * Comissao_Unit) AS Resultado,
        COUNT(DISTINCT Num_Venda) AS Qtde_Vendas_Status
    FROM cte_base
    GROUP BY Ano, Mes, Categoria, Produto, Status
),
cte_rank AS (
    SELECT
        k.*, 
        SUM(Qtde_Vendas_Status) OVER (PARTITION BY Ano, Mes, Categoria, Produto) AS Qtde_Vendas_Total
    FROM cte_kpis AS k
),
cte_final AS (
    SELECT
        *,
        CASE
            WHEN Qtde_Vendas_Total = 0 THEN NULL
            ELSE Qtde_Vendas_Status / NULLIF(Qtde_Vendas_Total, 0)
        END AS Taxa_Status
    FROM cte_rank
)
SELECT
    *
FROM cte_final;
