/*
  Projeto: KPIs_Vendas_SQL
  Análise: Reconciliação de Receita e Componentes
  Objetivo:
    Validar se Receita - Componentes = Resultado em nível agregado.
  Perguntas respondidas:
    - Há diferença entre receita e resultado calculado?
  Definições de KPIs:
    Diferenca = Receita - (Custo + Despesa + Impostos + Comissao) - Resultado
  Premissas / Limitações:
    - Data padrão: Data Pedido
  Como usar (filtros de data/categoria/produto):
    Filtre por Ano/Mes e Produto/Categoria.
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
        SUM(Qtde * Valor_Unit)
        - SUM(Qtde * Custo_Unit)
        - SUM(Qtde * Despesa_Unit)
        - SUM(Qtde * Impostos_Unit)
        - SUM(Qtde * Comissao_Unit) AS Resultado
    FROM cte_base
    GROUP BY Ano, Mes, Categoria, Produto
),
cte_rank AS (
    SELECT
        *,
        Receita - (Custo_Total + Despesa_Total + Impostos_Total + Comissao_Total) - Resultado AS Diferenca
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
ORDER BY ABS(Diferenca) DESC;
