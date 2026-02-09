# Quantidade de Vendas e Itens

1) **Em uma frase:** mostra o volume de itens vendidos e a quantidade de vendas por mês, categoria e produto. 

2) **Por que isso importa:** volume explica demanda e ajuda a ajustar estoque, produção e campanhas. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** Qtde_Itens e Qtde_Vendas por mês/categoria/produto.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → junta vendas com produto e calendário.  
- **Passo 2: cálculos** → soma Qtde e conta vendas distintas.  
- **Passo 3: agregações** → por Ano, Mês, Categoria e Produto.  
- **Passo 4: ranking/variações** → não aplicável.  

5) **Como interpretar o resultado**
Qtde_Itens indica volume físico; Qtde_Vendas indica quantos pedidos ocorreram. 

6) **Perguntas que consigo responder**
- Quais produtos têm maior giro?  
- Qual categoria gera mais pedidos?  
- O volume está concentrado em poucos produtos?  
- Há meses de baixa demanda?  
- Quantas vendas por mês tivemos?  

7) **Exemplos de insights e ações**
- Produto com alto volume → reforçar estoque.  
- Categoria com queda de volume → revisar campanhas.  
- Muitos itens, poucas vendas → tickets grandes (bom para upsell).  
- Poucos itens, muitas vendas → tickets pequenos (oportunidade de cross-sell).  
- Sazonalidade clara → planejar compras.  

8) **Limitações e cuidados**
- Contagem de vendas depende da qualidade de Num_Venda.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2019 AND Mes = 12`  
- `AND Produto = 'Smart TV'`  

10) **Glossário rápido**
- **Qtde_Itens:** soma das quantidades.  
- **Qtde_Vendas:** número de vendas distintas.  

**Melhorias futuras**
- Adicionar comparação MoM/YoY do volume.
