# Impacto e Perfil de Pagamento

1) **Em uma frase:** compara receita, margem e ticket por forma de pagamento e status da venda. 

2) **Por que isso importa:** certos meios de pagamento podem gerar maior custo ou maior cancelamento. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dPagamento, dStatus, dCalendario.  
- **Saídas:** Receita, Resultado, Margem_Pct, Ticket_Medio por forma de pagamento.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas com produto, pagamento e status.  
- **Passo 2: cálculos** → receita, resultado e ticket.  
- **Passo 3: agregações** → por mês, categoria, produto, pagamento e status.  
- **Passo 4: ranking/variações** → não aplicável.  

5) **Como interpretar o resultado**
Formas de pagamento com margem baixa podem indicar custos operacionais altos. 

6) **Perguntas que consigo responder**
- Qual pagamento traz maior margem?  
- Qual pagamento tem ticket médio maior?  
- Há mais cancelamentos em alguma forma?  
- O mix de pagamento mudou?  
- Qual categoria depende de um meio específico?  

7) **Exemplos de insights e ações**
- Boleto com alta taxa de cancelamento → reduzir prazos.  
- Cartão com margem baixa → negociar taxas.  
- Pagamento instantâneo com ticket alto → incentivar uso.  
- Forma nova crescendo → oferecer benefícios.  
- Pagamento com baixa adesão → revisar comunicação.  

8) **Limitações e cuidados**
- Depende da qualidade do status.  

9) **Como usar (exemplos de filtros)**
- `WHERE Forma_de_Pagamento = 'Cartão' AND Ano = 2020`  

10) **Glossário rápido**
- **Status:** situação atual da venda (ex.: entregue, cancelado).  

**Melhorias futuras**
- Incluir custo financeiro por meio de pagamento.
