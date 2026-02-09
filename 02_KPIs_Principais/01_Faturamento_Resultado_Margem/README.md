# KPIs de Faturamento, Resultado e Margem

1) **Em uma frase:** mostra receita, resultado e margem por mês, categoria e produto. 

2) **Por que isso importa:** essas métricas dizem se estamos vendendo bem e com lucro, ajudando a priorizar o mix certo. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** tabela com Ano, Mês, Categoria, Produto e KPIs financeiros.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → junta vendas ao produto e calendário.  
- **Passo 2: cálculos** → Receita e custos totais.  
- **Passo 3: agregações** → soma por mês, categoria e produto.  
- **Passo 4: ranking/variações** → não aplicável.  

5) **Como interpretar o resultado**
Compare o Resultado e a Margem entre categorias para entender onde o lucro é maior. 

6) **Perguntas que consigo responder**
- Qual produto gera mais receita?  
- Quais categorias têm maior margem?  
- Qual mês foi o melhor em resultado?  
- Existe produto com receita alta e margem baixa?  
- Como a margem evolui mês a mês?  

7) **Exemplos de insights e ações**
- Categoria com margem baixa → revisar custos e impostos.  
- Produto com resultado negativo → reprecificar ou descontinuar.  
- Mês com queda de receita → investigar sazonalidade.  
- Mix com margem alta → aumentar estoque.  
- Receita alta com comissão elevada → revisar política de comissão.  

8) **Limitações e cuidados**
- Use Data Pedido como padrão.  
- A margem fica nula quando Receita = 0.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2019 AND Mes BETWEEN 1 AND 6`  
- `AND Categoria = 'Computadores'`  

10) **Glossário rápido**
- **Resultado:** lucro após custos.  
- **Margem %:** lucro dividido pela receita.  

**Melhorias futuras**
- Incluir comparação MoM/YoY diretamente nesta consulta.
