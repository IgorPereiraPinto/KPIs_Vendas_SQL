# Ticket Médio e Preço Médio

1) **Em uma frase:** calcula quanto cada venda rende em média e o preço médio por item. 

2) **Por que isso importa:** ticket e preço mostram capacidade de vender mais por pedido e ajudam a avaliar estratégias de desconto. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** Ticket_Medio e Preco_Medio por mês, categoria e produto.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas + produto + calendário.  
- **Passo 2: cálculos** → receita, quantidade e vendas distintas.  
- **Passo 3: agregações** → por Ano/Mês/Categoria/Produto.  
- **Passo 4: ranking/variações** → não aplicável.  

5) **Como interpretar o resultado**
Ticket médio alto pode indicar upsell; preço médio baixo pode indicar promoções. 

6) **Perguntas que consigo responder**
- O ticket médio subiu no último trimestre?  
- Quais produtos têm preço médio mais alto?  
- Existe categoria com ticket baixo e alta quantidade?  
- Qual mês tem maior ticket médio?  
- O preço médio caiu após promoções?  

7) **Exemplos de insights e ações**
- Ticket baixo → criar combos.  
- Preço médio caindo → revisar política de descontos.  
- Produto premium com preço médio alto → reforçar marketing.  
- Categoria com ticket alto → ampliar mix.  
- Ticket alto e volume baixo → avaliar barreiras de preço.  

8) **Limitações e cuidados**
- Depende da qualidade de Num_Venda e Qtde.  
- Ticket pode ser distorcido por vendas muito grandes.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2019 AND Mes IN (10, 11, 12)`  
- `AND Categoria = 'Smart TV'`  

10) **Glossário rápido**
- **Ticket Médio:** receita por venda.  
- **Preço Médio:** receita por item.  

**Melhorias futuras**
- Incluir percentis para reduzir efeito de outliers.
