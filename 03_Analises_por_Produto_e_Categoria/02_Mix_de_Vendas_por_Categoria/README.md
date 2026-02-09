# Mix de Vendas por Categoria

1) **Em uma frase:** mostra a participação de cada categoria no faturamento e no volume de itens. 

2) **Por que isso importa:** o mix revela concentração de receita e ajuda a balancear o portfólio. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** Receita_Categoria, Qtde_Categoria, Mix_Receita_Pct e Mix_Volume_Pct.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas por categoria e calendário.  
- **Passo 2: cálculos** → receita e volume por categoria.  
- **Passo 3: agregações** → soma por mês/categoria.  
- **Passo 4: ranking/variações** → calcula % sobre o total do mês.  

5) **Como interpretar o resultado**
Uma categoria com Mix_Receita_Pct alto domina o faturamento do mês. 

6) **Perguntas que consigo responder**
- O mix está concentrado em poucas categorias?  
- Qual categoria cresceu participação?  
- Qual categoria perdeu relevância?  
- O volume acompanha a receita?  
- Há risco de dependência em uma categoria?  

7) **Exemplos de insights e ações**
- Mix muito concentrado → diversificar portfólio.  
- Categoria com mix baixo → campanhas para impulsionar.  
- Volume alto e receita baixa → revisar precificação.  
- Categoria em crescimento → reforçar estoque.  
- Perda de mix → investigar concorrência.  

8) **Limitações e cuidados**
- A participação depende do período analisado.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2020 AND Mes = 6`  

10) **Glossário rápido**
- **Mix:** participação percentual no total.  

**Melhorias futuras**
- Incluir mix por canal ou unidade, se disponível.
