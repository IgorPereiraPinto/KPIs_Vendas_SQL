# Status de Vendas (Cancelados/Entregues)

1) **Em uma frase:** avalia como o status das vendas impacta receita e volume. 

2) **Por que isso importa:** cancelamentos e devoluções reduzem faturamento real e geram custos extras. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dStatus, dCalendario.  
- **Saídas:** Receita, Resultado e Taxa_Status por status.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas com produto e status.  
- **Passo 2: cálculos** → receita e resultado.  
- **Passo 3: agregações** → por mês, categoria, produto e status.  
- **Passo 4: ranking/variações** → taxa de status no total.  

5) **Como interpretar o resultado**
Taxa_Status mostra o peso de cada status (ex.: cancelado) no total de vendas. 

6) **Perguntas que consigo responder**
- Qual o percentual de cancelamento?  
- Quais produtos têm mais devoluções?  
- A receita está sendo impactada por cancelamentos?  
- Qual categoria tem mais vendas entregues?  
- O status varia ao longo dos meses?  

7) **Exemplos de insights e ações**
- Cancelamento alto → revisar prazo de entrega.  
- Devoluções em um produto → investigar qualidade.  
- Status pendente alto → problema operacional.  
- Entregues com margem baixa → revisar custos logísticos.  
- Melhorar comunicação de status → reduzir cancelamentos.  

8) **Limitações e cuidados**
- Depende da confiabilidade do campo Status.  

9) **Como usar (exemplos de filtros)**
- `WHERE Status = 'Cancelado' AND Ano = 2019`  

10) **Glossário rápido**
- **Taxa_Status:** participação do status no total de vendas.  

**Melhorias futuras**
- Separar cancelamentos por motivo (se houver).
