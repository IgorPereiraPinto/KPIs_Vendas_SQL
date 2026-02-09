/*
  Projeto: KPIs_Vendas_SQL
  Script: MERGE DW (exemplos)
  Objetivo:
    Demonstrar MERGE para atualizar dimensões e fato no DW.
  Inputs:
    Tabelas dbo.stg_*.
  Outputs:
    Tabelas dbo.dw_* atualizadas.
*/

-- Dimensão Produtos (SCD Tipo 1)
MERGE dbo.dw_dProdutos AS target
USING (
    SELECT Id_Produto, Produto, Categoria, Marca
    FROM dbo.stg_dProdutos
) AS source
ON target.Id_Produto = source.Id_Produto
WHEN MATCHED THEN
    UPDATE SET
        target.Produto = source.Produto,
        target.Categoria = source.Categoria,
        target.Marca = source.Marca,
        target.Updated_At = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (Id_Produto, Produto, Categoria, Marca)
    VALUES (source.Id_Produto, source.Produto, source.Categoria, source.Marca);

-- Fato Vendas (upsert simplificado)
MERGE dbo.dw_fVendas AS target
USING (
    SELECT
        sv.Num_Venda,
        dp.Produto_SK,
        dc.Cliente_SK,
        dv.Vendedor_SK,
        dpg.Pagamento_SK,
        ds.Status_SK,
        du.Unidade_SK,
        sv.Data_Pedido,
        sv.Data_Envio,
        sv.Qtde,
        sv.Valor_Unit,
        sv.Custo_Unit,
        sv.Despesa_Unit,
        sv.Impostos_Unit,
        sv.Comissao_Unit
    FROM dbo.stg_fVendas AS sv
    LEFT JOIN dbo.dw_dProdutos AS dp ON sv.Id_Produto = dp.Id_Produto
    LEFT JOIN dbo.dw_dClientes AS dc ON sv.Id_Cliente = dc.Id_Cliente
    LEFT JOIN dbo.dw_dVendedores AS dv ON sv.Id_Vendedor = dv.Id_Vendedor
    LEFT JOIN dbo.dw_dPagamento AS dpg ON sv.Id_Pgto = dpg.Id_Pagamento
    LEFT JOIN dbo.dw_dStatus AS ds ON sv.Id_Status = ds.Id_Status
    LEFT JOIN dbo.dw_dUnidades AS du ON sv.Id_Unidade = du.Id_Unidade
) AS source
ON target.Num_Venda = source.Num_Venda
   AND target.Produto_SK = source.Produto_SK
WHEN MATCHED THEN
    UPDATE SET
        target.Cliente_SK = source.Cliente_SK,
        target.Vendedor_SK = source.Vendedor_SK,
        target.Pagamento_SK = source.Pagamento_SK,
        target.Status_SK = source.Status_SK,
        target.Unidade_SK = source.Unidade_SK,
        target.Data_Pedido = source.Data_Pedido,
        target.Data_Envio = source.Data_Envio,
        target.Qtde = source.Qtde,
        target.Valor_Unit = source.Valor_Unit,
        target.Custo_Unit = source.Custo_Unit,
        target.Despesa_Unit = source.Despesa_Unit,
        target.Impostos_Unit = source.Impostos_Unit,
        target.Comissao_Unit = source.Comissao_Unit,
        target.Updated_At = SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (
        Num_Venda, Produto_SK, Cliente_SK, Vendedor_SK, Pagamento_SK, Status_SK, Unidade_SK,
        Data_Pedido, Data_Envio, Qtde, Valor_Unit, Custo_Unit, Despesa_Unit, Impostos_Unit, Comissao_Unit
    )
    VALUES (
        source.Num_Venda, source.Produto_SK, source.Cliente_SK, source.Vendedor_SK, source.Pagamento_SK,
        source.Status_SK, source.Unidade_SK, source.Data_Pedido, source.Data_Envio, source.Qtde, source.Valor_Unit,
        source.Custo_Unit, source.Despesa_Unit, source.Impostos_Unit, source.Comissao_Unit
    );
