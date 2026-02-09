/*
  Projeto: KPIs_Vendas_SQL
  Análise: Componentes de Custo e Percentuais
  Objetivo:
    Medir comissão, custos, impostos e despesas como valor e % da receita.
  Perguntas respondidas:
    - Quais componentes pesam mais na receita?
    - A comissão está acima do esperado?
  Definições de KPIs:
    %_Comissao = Comissao_Total / Receita
    %_Custo = Custo_Total / Receita
    %_Impostos = Impostos_Total / Receita
    %_Despesa = Despesa_Total / Receita
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
        CASE
            WHEN SUM(Qtde * Valor_Unit) = 0 THEN NULL
            ELSE SUM(Qtde * Custo_Unit) / NULLIF(SUM(Qtde * Valor_Unit), 0)
        END AS Custo_Pct,
        CASE
            WHEN SUM(Qtde * Valor_Unit) = 0 THEN NULL
            ELSE SUM(Qtde * Despesa_Unit) / NULLIF(SUM(Qtde * Valor_Unit), 0)
        END AS Despesa_Pct,
        CASE
            WHEN SUM(Qtde * Valor_Unit) = 0 THEN NULL
            ELSE SUM(Qtde * Impostos_Unit) / NULLIF(SUM(Qtde * Valor_Unit), 0)
        END AS Impostos_Pct,
        CASE
            WHEN SUM(Qtde * Valor_Unit) = 0 THEN NULL
            ELSE SUM(Qtde * Comissao_Unit) / NULLIF(SUM(Qtde * Valor_Unit), 0)
        END AS Comissao_Pct
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
