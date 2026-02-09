/*
  Projeto: KPIs_Vendas_SQL
  Script: Validações DW
  Objetivo:
    Checar chaves, reconciliação e consistência na camada DW.
  Inputs:
    Tabelas dbo.dw_*.
  Outputs:
    Resultados de auditoria (consultas de verificação).
*/

-- Chaves nulas no fato
SELECT COUNT(*) AS Fatos_Com_Chave_Produto_Nula
FROM dbo.dw_fVendas
WHERE Produto_SK IS NULL;

-- Reconciliação de receita e resultado
SELECT
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
FROM dbo.dw_fVendas;
