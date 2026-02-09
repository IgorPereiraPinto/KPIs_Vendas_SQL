# 01 - Dicionário de KPIs

## Financeiros
- **Receita (Faturamento/Valor Bruto)** = Σ (Qtde * Valor Unit)
- **Custo Total** = Σ (Qtde * Custo Unit)
- **Despesa Total** = Σ (Qtde * Despesa Unit)
- **Impostos Total** = Σ (Qtde * Impostos Unit)
- **Comissão Total** = Σ (Qtde * Comissão Unit)
- **Resultado (Lucro)** = Receita - Custo Total - Despesa Total - Impostos Total - Comissão Total
- **Margem %** = Resultado / Receita (se Receita = 0, retorna NULL)

## Volume e eficiência
- **Qtde Itens** = Σ Qtde
- **Qtde Vendas** = COUNT DISTINCT (Num Venda)
- **Preço Médio** = Receita / Qtde Itens
- **Ticket Médio** = Receita / Qtde Vendas

## Crescimento
- **MoM (Month over Month)** = (Valor do mês atual / Valor do mês anterior) - 1
- **YoY (Year over Year)** = (Valor do mês atual / Valor do mesmo mês do ano anterior) - 1

## Metas
- **Meta** = valor definido em fMetas (se disponível)
- **Atingimento %** = Receita / Meta
- **Gap** = Receita - Meta

> Observação: as fórmulas são aplicadas sempre a partir da base “Vendas Enriquecidas”.
