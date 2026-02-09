# Pareto 80/20 por Produto e Categoria

1) **Em uma frase:** identifica quais produtos/categorias concentram cerca de 80% da receita. 

2) **Por que isso importa:** ajuda a focar estoque e estratégia nos itens que realmente movem o negócio. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** Receita, Percentual_Acumulado e flag Pareto_Flag.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas por produto/categoria.  
- **Passo 2: cálculos** → receita por item.  
- **Passo 3: agregações** → soma por mês/categoria/produto.  
- **Passo 4: ranking/variações** → acumula receita em ordem decrescente e marca 80%.  

5) **Como interpretar o resultado**
Quando Pareto_Flag = 1, o produto está dentro dos 80% que mais faturam. 

6) **Perguntas que consigo responder**
- Quais produtos sustentam a maior parte da receita?  
- Há excesso de itens de baixa contribuição?  
- O Pareto muda ao longo dos meses?  
- Qual categoria tem concentração maior?  
- É possível reduzir complexidade do catálogo?  

7) **Exemplos de insights e ações**
- Itens fora do Pareto → avaliar descontinuação.  
- Pareto muito concentrado → risco de dependência.  
- Produto estratégico no Pareto → garantir disponibilidade.  
- Itens no Pareto e baixa margem → revisar preço.  
- Mudanças rápidas no Pareto → monitorar tendências.  

8) **Limitações e cuidados**
- O 80% é referência; ajuste conforme estratégia.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2019 AND Mes = 11 AND Pareto_Flag = 1`  

10) **Glossário rápido**
- **Pareto 80/20:** 80% dos resultados vêm de ~20% das causas.  

**Melhorias futuras**
- Criar Pareto separado por categoria e por canal.
