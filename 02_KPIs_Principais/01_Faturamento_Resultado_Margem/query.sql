/*
  Projeto: KPIs_Vendas_SQL
  Análise: KPIs de Faturamento, Resultado e Margem
  Objetivo:
    Calcular receita, resultado e margem por mês, categoria e produto.
  Perguntas respondidas:
    - Quanto faturamos por mês, categoria e produto?
    - Qual o resultado e a margem?
  Definições de KPIs:
    Receita = Qtde * Valor Unit
    Resultado = Receita - custos totais
    Margem_% = Resultado / Receita
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
        SUM(Qtde * Custo_Unit) AS Custo_Total,
        SUM(Qtde * Despesa_Unit) AS Despesa_Total,
        SUM(Qtde * Impostos_Unit) AS Impostos_Total,
        SUM(Qtde * Comissao_Unit) AS Comissao_Total,
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
