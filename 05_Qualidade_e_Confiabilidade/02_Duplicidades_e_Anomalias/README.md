# Duplicidades e Anomalias

1) **Em uma frase:** identifica itens duplicados e regras básicas inválidas em vendas. 

2) **Por que isso importa:** duplicidades e valores inválidos distorcem KPIs e decisões. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas.  
- **Saídas:** contagem de duplicidades e regras inválidas.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → carrega Num_Venda, Id_Produto, Qtde e Valor_Unit.  
- **Passo 2: cálculos** → identifica duplicidades e valores inválidos.  
- **Passo 3: agregações** → conta ocorrências.  
- **Passo 4: ranking/variações** → ordena por maior incidência.  

5) **Como interpretar o resultado**
Totais altos indicam falhas de integração ou regras de negócio mal definidas. 

6) **Perguntas que consigo responder**
- Temos itens duplicados por venda?  
- Há quantidades negativas ou zero?  
- Existem preços negativos?  
- O problema está crescendo?  
- Qual regra é mais crítica?  

7) **Exemplos de insights e ações**
- Duplicidades altas → revisar carga de pedidos.  
- Qtde inválida → validar entrada de dados.  
- Valor unitário negativo → corrigir regras fiscais.  
- Duplicidade concentrada → investigar canal específico.  
- Anomalias pontuais → limpar dados antes da análise.  

8) **Limitações e cuidados**
- Algumas duplicidades podem ser legítimas (ex.: ajustes).  

9) **Como usar (exemplos de filtros)**
- `WHERE Data_Pedido BETWEEN '2020-01-01' AND '2020-01-31'`  

10) **Glossário rápido**
- **Duplicidade:** item repetido na mesma venda.  

**Melhorias futuras**
- Incluir validação de ranges por categoria.
