# Efeito Preço vs Volume

1) **Em uma frase:** mostra se a variação de receita veio de preço ou de volume vendido. 

2) **Por que isso importa:** ajuda a entender se o crescimento é sustentável (volume) ou depende apenas de aumento de preço. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** Efeito_Preco, Efeito_Volume e Variacao_Receita por mês.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas por produto/categoria.  
- **Passo 2: cálculos** → receita, quantidade e preço médio.  
- **Passo 3: agregações** → por mês, categoria e produto.  
- **Passo 4: ranking/variações** → compara com mês anterior via LAG.  

5) **Como interpretar o resultado**
Efeito_Preco > 0 indica aumento de receita por preço; Efeito_Volume > 0 indica aumento por quantidade. 

6) **Perguntas que consigo responder**
- O crescimento veio de preço ou volume?  
- A queda de receita foi por perda de volume?  
- Qual produto depende mais de aumento de preço?  
- A categoria está vendendo mais ou apenas mais caro?  
- Houve mudança na estratégia de descontos?  

7) **Exemplos de insights e ações**
- Receita cresce por preço, volume cai → revisar elasticidade.  
- Receita cresce por volume → reforçar estoque.  
- Preço médio cai e volume sobe → promoções efetivas?  
- Ambos negativos → alerta de demanda.  
- Volume alto e preço estável → manutenção da estratégia.  

8) **Limitações e cuidados**
- Precisa de pelo menos dois meses para comparar.  

9) **Como usar (exemplos de filtros)**
- `WHERE Categoria = 'Áudios' AND Ano = 2020`  

10) **Glossário rápido**
- **Efeito Preço:** impacto de mudança de preço.  
- **Efeito Volume:** impacto de mudança de quantidade.  

**Melhorias futuras**
- Incluir decomposição por canal/unidade.
