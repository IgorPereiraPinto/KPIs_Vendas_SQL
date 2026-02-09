/*
  Projeto: KPIs_Vendas_SQL
  Análise: Impacto e Perfil de Pagamento
  Objetivo:
    Avaliar receita, margem e ticket por forma de pagamento.
  Perguntas respondidas:
    - Qual forma de pagamento traz melhor margem?
    - Há impacto em cancelamentos?
  Definições de KPIs:
    Ticket_Medio = Receita / Qtde_Vendas
  Premissas / Limitações:
    - Data padrão: Data Pedido
  Como usar (filtros de data/categoria/produto):
    Filtre por Ano/Mes e Categoria/Produto.
*/
WITH cte_base AS (
    SELECT
        cal.Ano,
        cal.Mes,
        dp.Categoria,
        dp.Produto,
        dpg.Forma_de_Pagamento,
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
    LEFT JOIN dPagamento AS dpg
        ON fv.Id_Pgto = dpg.Id_Pagamento
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
        Forma_de_Pagamento,
        Status,
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
    GROUP BY Ano, Mes, Categoria, Produto, Forma_de_Pagamento, Status
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
