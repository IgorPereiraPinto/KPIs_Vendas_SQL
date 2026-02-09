# KPIs por Vendedor

1) **Em uma frase:** mostra o desempenho de cada vendedor em receita, resultado, margem e ticket. 

2) **Por que isso importa:** permite reconhecer bons vendedores e apoiar quem precisa melhorar. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dVendedores, dCalendario.  
- **Saídas:** KPIs por vendedor com ranking.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas com produto e vendedor.  
- **Passo 2: cálculos** → receita, resultado, margem e ticket.  
- **Passo 3: agregações** → por mês, produto, vendedor.  
- **Passo 4: ranking/variações** → ranking por receita.  

5) **Como interpretar o resultado**
Ranking e margem ajudam a separar alta performance de alto volume sem lucro. 

6) **Perguntas que consigo responder**
- Quem vende mais?  
- Quem tem maior margem?  
- Quem tem ticket médio alto?  
- Qual vendedor precisa de coaching?  
- Qual gerente tem time mais rentável?  

7) **Exemplos de insights e ações**
- Vendedor com alta receita e baixa margem → revisar descontos.  
- Vendedor com ticket alto → compartilhar práticas.  
- Queda de receita → planejar treinamento.  
- Margem alta em produtos específicos → estimular foco.  
- Ranking instável → analisar sazonalidade.  

8) **Limitações e cuidados**
- Depende do correto cadastro de Id_Vendedor.  

9) **Como usar (exemplos de filtros)**
- `WHERE Vendedor = 'Ronaldo' AND Ano = 2019`  

10) **Glossário rápido**
- **Ticket Médio:** receita por venda.  

**Melhorias futuras**
- Incluir metas individuais na mesma consulta.
