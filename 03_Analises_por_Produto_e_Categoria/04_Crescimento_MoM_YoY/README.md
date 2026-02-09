# Crescimento MoM e YoY

1) **Em uma frase:** mede a variação da receita mês a mês (MoM) e ano a ano (YoY) por produto e categoria. 

2) **Por que isso importa:** crescimento mostra tendência real e ajuda a identificar mudanças de mercado. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** Receita, MoM_Pct, YoY_Pct.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas por produto/categoria e calendário.  
- **Passo 2: cálculos** → receita mensal.  
- **Passo 3: agregações** → por mês, categoria, produto.  
- **Passo 4: ranking/variações** → LAG para mês anterior e ano anterior.  

5) **Como interpretar o resultado**
MoM_Pct > 0 indica crescimento no mês; YoY_Pct mostra comparação com mesmo mês do ano anterior. 

6) **Perguntas que consigo responder**
- Produto X está crescendo mês a mês?  
- Houve recuperação em relação ao ano passado?  
- Quais categorias desaceleraram?  
- Existe sazonalidade forte?  
- Quais produtos têm crescimento consistente?  

7) **Exemplos de insights e ações**
- MoM negativo recorrente → revisar estratégia.  
- YoY positivo → sinal de expansão.  
- Crescimento forte em categoria → investir marketing.  
- Produto com queda YoY → investigar concorrência.  
- Sazonalidade clara → planejar estoque.  

8) **Limitações e cuidados**
- Precisa de histórico de pelo menos 12 meses para YoY.  

9) **Como usar (exemplos de filtros)**
- `WHERE Categoria = 'Computadores' AND Ano = 2019`  

10) **Glossário rápido**
- **MoM:** variação vs mês anterior.  
- **YoY:** variação vs mesmo mês do ano anterior.  

**Melhorias futuras**
- Incluir crescimento acumulado YTD.
