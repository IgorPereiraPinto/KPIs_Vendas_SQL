# Ranking de Produtos e Categorias

1) **Em uma frase:** lista os produtos e categorias com melhor desempenho em receita e margem. 

2) **Por que isso importa:** ajuda a focar o esforço comercial e de estoque no que traz mais resultado. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** ranking por receita e margem (top 10).  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → junta vendas, produtos e calendário.  
- **Passo 2: cálculos** → receita, resultado e margem.  
- **Passo 3: agregações** → por mês, categoria e produto.  
- **Passo 4: ranking/variações** → aplica ranking por receita e margem.  

5) **Como interpretar o resultado**
Rank_Receita e Rank_Margem indicam os líderes; números menores são melhores. 

6) **Perguntas que consigo responder**
- Quais são os top produtos do mês?  
- Quais categorias têm maior margem?  
- Há produtos com alta receita e baixa margem?  
- Quem são os “bottom 10” em margem?  
- Como o ranking muda por mês?  

7) **Exemplos de insights e ações**
- Produto top em receita e margem → manter estoque alto.  
- Produto top em receita e baixa margem → revisar preços.  
- Categoria com margem alta → investir em marketing.  
- Produtos fora do top → avaliar descontinuação.  
- Ranking instável → sinal de sazonalidade.  

8) **Limitações e cuidados**
- O ranking depende da janela mensal; ajuste se precisar de visão anual.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2019 AND Mes = 12`  
- Ajuste o top: `WHERE Rank_Receita <= 20`  

10) **Glossário rápido**
- **Rank:** posição relativa no grupo.  

**Melhorias futuras**
- Incluir ranking de crescimento (MoM/YoY).
