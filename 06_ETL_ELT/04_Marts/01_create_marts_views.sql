/*
  Projeto: KPIs_Vendas_SQL
  Script: Views de Marts
  Objetivo:
    Criar views finais para consumo analítico.
  Inputs:
    Tabelas dbo.dw_*.
  Outputs:
    Views dbo.vw_*.
*/

CREATE VIEW dbo.vw_vendas_enriquecidas AS
SELECT
    fv.Num_Venda,
    dp.Id_Produto,
    dp.Produto,
    dp.Categoria,
    dp.Marca,
    dv.Id_Vendedor,
    dv.Vendedor,
    dv.Gerente,
    dc.Id_Cliente,
    dc.Cliente,
    dc.Cidade,
    dc.Estado,
    dpg.Id_Pagamento,
    dpg.Forma_de_Pagamento,
    ds.Id_Status,
    ds.Status,
    du.Id_Unidade,
    du.Unidade,
    fv.Data_Pedido,
    fv.Data_Envio,
    fv.Qtde,
    fv.Valor_Unit,
    fv.Custo_Unit,
    fv.Despesa_Unit,
    fv.Impostos_Unit,
    fv.Comissao_Unit,
    (fv.Qtde * fv.Valor_Unit) AS Receita,
    (fv.Qtde * fv.Custo_Unit) AS Custo_Total,
    (fv.Qtde * fv.Despesa_Unit) AS Despesa_Total,
    (fv.Qtde * fv.Impostos_Unit) AS Impostos_Total,
    (fv.Qtde * fv.Comissao_Unit) AS Comissao_Total,
    (fv.Qtde * fv.Valor_Unit)
    - (fv.Qtde * fv.Custo_Unit)
    - (fv.Qtde * fv.Despesa_Unit)
    - (fv.Qtde * fv.Impostos_Unit)
    - (fv.Qtde * fv.Comissao_Unit) AS Resultado,
    CASE
        WHEN (fv.Qtde * fv.Valor_Unit) = 0 THEN NULL
        ELSE (
            (fv.Qtde * fv.Valor_Unit)
            - (fv.Qtde * fv.Custo_Unit)
            - (fv.Qtde * fv.Despesa_Unit)
            - (fv.Qtde * fv.Impostos_Unit)
            - (fv.Qtde * fv.Comissao_Unit)
        ) / NULLIF((fv.Qtde * fv.Valor_Unit), 0)
    END AS Margem_Pct
FROM dbo.dw_fVendas AS fv
LEFT JOIN dbo.dw_dProdutos AS dp ON fv.Produto_SK = dp.Produto_SK
LEFT JOIN dbo.dw_dVendedores AS dv ON fv.Vendedor_SK = dv.Vendedor_SK
LEFT JOIN dbo.dw_dClientes AS dc ON fv.Cliente_SK = dc.Cliente_SK
LEFT JOIN dbo.dw_dPagamento AS dpg ON fv.Pagamento_SK = dpg.Pagamento_SK
LEFT JOIN dbo.dw_dStatus AS ds ON fv.Status_SK = ds.Status_SK
LEFT JOIN dbo.dw_dUnidades AS du ON fv.Unidade_SK = du.Unidade_SK;
