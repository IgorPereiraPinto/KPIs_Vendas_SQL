# View Calendário com Datas com Venda

1) **Em uma frase:** esta análise prepara o calendário com um indicador simples de quais dias tiveram vendas. 

2) **Por que isso importa:** análises temporais dependem de um calendário consistente; o indicador evita furos na série e ajuda a interpretar períodos sem venda. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** dCalendario, fVendas.  
- **Saídas:** calendário com Ano, Mês, Dia e flag Datas_com_Venda.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → lê a dimensão calendário.  
- **Passo 2: cálculos** → marca Datas_com_Venda quando existe venda no dia.  
- **Passo 3: agregações** → não há agregação.  
- **Passo 4: ranking/variações** → não aplicável.  

5) **Como interpretar o resultado**
Se Datas_com_Venda = 0, não houve venda registrada naquele dia. 

6) **Perguntas que consigo responder**
- Há períodos sem vendas?  
- Quantos dias de venda existem por mês?  
- Qual mês teve maior densidade de vendas?  

7) **Exemplos de insights e ações**
- Muitos dias sem venda → revisar estoque ou campanhas.  
- Queda de dias vendidos em um mês → problema operacional?  
- Datas com vendas concentradas → oportunidade para distribuir demanda.  

8) **Limitações e cuidados**
- Usa **Data Pedido** como referência.  
- Datas faltantes no calendário precisam ser corrigidas na dimensão.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2019 AND Mes = 7`  
- `AND Datas_com_Venda = 1`  

10) **Glossário rápido**
- **Datas_com_Venda:** flag que indica se existe ao menos uma venda no dia.  

**Melhorias futuras**
- Incluir feriados e sazonalidade para comparações mais ricas.
