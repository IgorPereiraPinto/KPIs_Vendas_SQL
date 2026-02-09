# 00 - Modelo de Dados (baseado no Power BI)

## Visão geral
O modelo é do tipo **estrela**, com a tabela fato **fVendas** no centro e dimensões ao redor. A chave principal da venda é **Num Venda** e o grão é **linha por produto por venda** (Num Venda + Id Produto). 

## Tabela fato principal
**fVendas** (grão: item da venda)
- **Num Venda**: identificador da venda.
- **Id Produto**: chave do produto.
- **Id Cliente**: chave do cliente.
- **Id Vendedor**: chave do vendedor.
- **Id Pgto**: chave da forma de pagamento.
- **Id Status**: status da venda.
- **Id Unidade**: unidade/filial.
- **Data Pedido**: data base para análise (padrão do projeto).
- **Data Envio**: data alternativa (ver filtros).
- **Qtde**: quantidade de itens.
- **Valor Unit**: preço unitário.
- **Custo Unit, Despesa Unit, Impostos Unit, Comissão Unit**: custos unitários.

## Dimensões
- **dProdutos**: Id Produto, Produto, Categoria, Marca.
- **dVendedores**: Id Vendedor, Vendedor, Gerente, URL Foto, URL Foto Inteira.
- **dClientes**: Id Cliente, Cliente, Cidade, Estado.
- **dPagamento**: Id Pagamento, Forma de Pagamento.
- **dStatus**: Id Status, Status.
- **dUnidades**: Id Unidade, Unidade.
- **dCalendario**: Id Data, Data, Dia, Mês, Ano, Datas com Venda.
- **fMetas**: data, Id Vendedor e coluna de meta (se não existir, ver template em 04_Performance_Vendedor_e_Gerente/03_Atingimento_Meta).

## Relações (chaves)
- fVendas.Id Produto → dProdutos.Id Produto
- fVendas.Id Vendedor → dVendedores.Id Vendedor
- fVendas.Id Cliente → dClientes.Id Cliente
- fVendas.Id Pgto → dPagamento.Id Pagamento
- fVendas.Id Status → dStatus.Id Status
- fVendas.Id Unidade → dUnidades.Id Unidade
- fVendas.Data Pedido → dCalendario.Data (ou Id Data, se modelado)

## Divergências de nomenclatura (assumidas)
- **Id Pgto** em fVendas referencia **dPagamento.Id Pagamento**.
- As queries usam nomes em *snake_case* (ex.: `Num_Venda`, `Data_Pedido`). Se no seu banco as colunas tiverem espaço (ex.: `Num Venda`) ou outro padrão, ajuste as consultas e registre aqui.

## Premissas-chave
- **Receita** = Qtde * Valor Unit.  
- **Componentes de custo** são unitários e multiplicados por Qtde.  
- **Resultado** = Receita - Custo_Total - Despesa_Total - Impostos_Total - Comissao_Total.  
- **Margem %** = Resultado / Receita (evitar divisão por zero).  
- Data padrão = **Data Pedido** (Data Envio disponível como alternativa).
