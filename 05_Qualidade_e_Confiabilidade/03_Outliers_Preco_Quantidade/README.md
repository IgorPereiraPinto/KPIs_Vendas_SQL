# Outliers de Preço e Quantidade

1) **Em uma frase:** identifica preços e quantidades muito fora do padrão por produto e categoria. 

2) **Por que isso importa:** outliers podem ser erro de cadastro ou promoção atípica que distorce KPIs. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** contagem de outliers de preço e quantidade por mês/produto.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas por produto/categoria.  
- **Passo 2: cálculos** → quartis (Q1, Q3) e intervalo interquartil (IQR).  
- **Passo 3: agregações** → conta outliers por mês e produto.  
- **Passo 4: ranking/variações** → ordena por maior número de outliers.  

5) **Como interpretar o resultado**
Outliers_Preco ou Outliers_Qtde altos indicam revisão necessária. 

6) **Perguntas que consigo responder**
- Quais produtos têm preços fora do padrão?  
- Há quantidades exageradas em um mês?  
- Existe erro de cadastro recorrente?  
- Qual categoria sofre mais com outliers?  
- Houve promoção extrema?  

7) **Exemplos de insights e ações**
- Muitos outliers de preço → revisar tabela de preços.  
- Outliers de quantidade → validar pedidos no ERP.  
- Categoria com outliers frequentes → checar regras de desconto.  
- Outliers concentrados em um mês → investigar campanha.  
- Outliers poucos → controle está bom.  

8) **Limitações e cuidados**
- IQR é método estatístico; alguns outliers podem ser legítimos.  

9) **Como usar (exemplos de filtros)**
- `WHERE Categoria = 'Vídeos' AND Ano = 2019`  

10) **Glossário rápido**
- **Outlier:** valor atípico fora do padrão estatístico.  

**Melhorias futuras**
- Incluir limites por regra de negócio além do IQR.
