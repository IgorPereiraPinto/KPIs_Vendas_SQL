# Comissão, Custos, Impostos e Despesas

1) **Em uma frase:** mede quanto cada componente de custo representa no faturamento. 

2) **Por que isso importa:** entender onde o dinheiro “vaza” ajuda a melhorar margem. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** valores e percentuais de custo, despesa, impostos e comissão.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas + produto + calendário.  
- **Passo 2: cálculos** → totais e percentuais sobre a receita.  
- **Passo 3: agregações** → por mês/categoria/produto.  
- **Passo 4: ranking/variações** → não aplicável.  

5) **Como interpretar o resultado**
Percentuais altos indicam onde focar negociação ou revisão de política. 

6) **Perguntas que consigo responder**
- A comissão está muito alta?  
- Qual categoria tem maior peso de impostos?  
- Custos subiram em algum mês?  
- Onde a despesa é mais relevante?  
- Qual produto tem custo desproporcional?  

7) **Exemplos de insights e ações**
- Comissão acima do esperado → revisar metas.  
- Impostos altos → avaliar regime fiscal.  
- Custos subindo → renegociar fornecedores.  
- Despesas altas → otimizar logística.  
- Produto com custo alto → reprecificar.  

8) **Limitações e cuidados**
- Percentuais dependem de Receita > 0.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2020 AND Mes = 3`  
- `AND Categoria = 'Vídeos'`  

10) **Glossário rápido**
- **Custo %:** custo total / receita.  
- **Comissão %:** comissão total / receita.  

**Melhorias futuras**
- Incluir metas de custo para comparação automática.
