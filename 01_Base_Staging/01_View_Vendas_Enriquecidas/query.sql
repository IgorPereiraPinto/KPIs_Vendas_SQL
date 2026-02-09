/*
  Projeto: KPIs_Vendas_SQL
  Análise: View Vendas Enriquecidas
  Objetivo:
    Consolidar a venda item a item com dimensões e cálculos financeiros básicos.
  Perguntas respondidas:
    - Qual a receita, custo, resultado e margem por item de venda?
    - Quais dimensões (produto, cliente, vendedor etc.) estão associadas ao item?
  Definições de KPIs:
    Receita = Qtde * Valor Unit
    Resultado = Receita - Custo_Total - Despesa_Total - Impostos_Total - Comissao_Total
    Margem_% = Resultado / Receita (evitando divisão por zero)
  Premissas / Limitações:
    - Data padrão: Data Pedido (alternativa: Data Envio)
    - Custos são unitários e multiplicados por Qtde
  Como usar (filtros de data/categoria/produto):
    Filtre por DataPedido ou DataEnvio, Categoria e Produto conforme necessidade.
*/
WITH cte_base AS (
    SELECT
        fv.Num_Venda,
        fv.Id_Produto,
        fv.Id_Cliente,
        fv.Id_Vendedor,
        fv.Id_Pgto,
        fv.Id_Status,
        fv.Id_Unidade,
        fv.Data_Pedido,
        fv.Data_Envio,
        fv.Qtde,
        fv.Valor_Unit,
        fv.Custo_Unit,
        fv.Despesa_Unit,
        fv.Impostos_Unit,
        fv.Comissao_Unit,
        dp.Produto,
        dp.Categoria,
        dp.Marca,
        dv.Vendedor,
        dv.Gerente,
        dc.Cliente,
        dc.Cidade,
        dc.Estado,
        dpg.Forma_de_Pagamento,
        ds.Status,
        du.Unidade,
        cal.Data AS Data_Pedido_Calendario,
        cal.Ano,
        cal.Mes,
        cal.Dia
    FROM fVendas AS fv
    LEFT JOIN dProdutos AS dp
        ON fv.Id_Produto = dp.Id_Produto
    LEFT JOIN dVendedores AS dv
        ON fv.Id_Vendedor = dv.Id_Vendedor
    LEFT JOIN dClientes AS dc
        ON fv.Id_Cliente = dc.Id_Cliente
    LEFT JOIN dPagamento AS dpg
        ON fv.Id_Pgto = dpg.Id_Pagamento
    LEFT JOIN dStatus AS ds
        ON fv.Id_Status = ds.Id_Status
    LEFT JOIN dUnidades AS du
        ON fv.Id_Unidade = du.Id_Unidade
    LEFT JOIN dCalendario AS cal
        ON fv.Data_Pedido = cal.Data
),
cte_kpis AS (
    SELECT
        *,
        (Qtde * Valor_Unit) AS Receita,
        (Qtde * Custo_Unit) AS Custo_Total,
        (Qtde * Despesa_Unit) AS Despesa_Total,
        (Qtde * Impostos_Unit) AS Impostos_Total,
        (Qtde * Comissao_Unit) AS Comissao_Total,
        (Qtde * Valor_Unit)
        - (Qtde * Custo_Unit)
        - (Qtde * Despesa_Unit)
        - (Qtde * Impostos_Unit)
        - (Qtde * Comissao_Unit) AS Resultado,
        CASE
            WHEN (Qtde * Valor_Unit) = 0 THEN NULL
            ELSE (
                (Qtde * Valor_Unit)
                - (Qtde * Custo_Unit)
                - (Qtde * Despesa_Unit)
                - (Qtde * Impostos_Unit)
                - (Qtde * Comissao_Unit)
            ) / NULLIF((Qtde * Valor_Unit), 0)
        END AS Margem_Pct
    FROM cte_base
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
