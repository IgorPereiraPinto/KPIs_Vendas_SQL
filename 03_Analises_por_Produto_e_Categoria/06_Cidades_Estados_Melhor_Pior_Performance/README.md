# Performance por Cidade e Estado

1) **Em uma frase:** compara cidades e estados em receita, margem e ticket médio. 

2) **Por que isso importa:** ajuda a direcionar campanhas e investimentos para regiões com melhor retorno. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dClientes, dCalendario.  
- **Saídas:** Receita, Resultado, Margem_Pct e Ticket_Medio por cidade/estado.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas com produto, cliente e calendário.  
- **Passo 2: cálculos** → receita, resultado, margem e ticket.  
- **Passo 3: agregações** → por mês, cidade, estado, produto/categoria.  
- **Passo 4: ranking/variações** → rank por receita.  

5) **Como interpretar o resultado**
Cidades com margem alta e ticket alto são prioritárias para expansão. 

6) **Perguntas que consigo responder**
- Quais estados têm melhor margem?  
- Quais cidades lideram receita?  
- Há regiões com ticket baixo?  
- Qual categoria funciona melhor em determinado estado?  
- Existe concentração geográfica de vendas?  

7) **Exemplos de insights e ações**
- Cidade com receita alta e margem baixa → revisar custos logísticos.  
- Estado com crescimento forte → expandir equipe.  
- Ticket baixo em região → oferecer combos.  
- Margem alta e volume baixo → ampliar marketing local.  
- Região com desempenho ruim → investigar concorrência.  

8) **Limitações e cuidados**
- Depende da qualidade de endereço do cliente.  

9) **Como usar (exemplos de filtros)**
- `WHERE Estado = 'SP' AND Ano = 2019`  

10) **Glossário rápido**
- **Ticket Médio:** receita por venda.  

**Melhorias futuras**
- Incluir segmentação por unidade/filial.
