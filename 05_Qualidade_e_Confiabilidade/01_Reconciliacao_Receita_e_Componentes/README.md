# Reconciliação de Receita e Componentes

1) **Em uma frase:** verifica se a conta da receita bate com a soma dos componentes de custo e resultado. 

2) **Por que isso importa:** garante que a lógica financeira está consistente e sem erros de cálculo. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dCalendario.  
- **Saídas:** Receita, componentes e coluna Diferenca.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas por produto e calendário.  
- **Passo 2: cálculos** → receita e componentes.  
- **Passo 3: agregações** → por mês, categoria e produto.  
- **Passo 4: ranking/variações** → calcula diferença e ordena.  

5) **Como interpretar o resultado**
Diferenca próxima de zero indica conciliação correta. Valores altos indicam erro. 

6) **Perguntas que consigo responder**
- Há divergências no cálculo de resultado?  
- Quais produtos têm diferença mais alta?  
- O problema ocorre em um mês específico?  
- A divergência é por custo, imposto ou comissão?  
- A receita está sub ou superestimada?  

7) **Exemplos de insights e ações**
- Diferenca positiva → componentes subestimados.  
- Diferenca negativa → receita subestimada.  
- Divergência em um produto → revisar cadastro de custos.  
- Divergência em mês específico → verificar ETL.  
- Diferenca zero → processo confiável.  

8) **Limitações e cuidados**
- Depende da correta multiplicação dos unitários pela Qtde.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2020 AND Mes = 5`  

10) **Glossário rápido**
- **Reconciliação:** validação de consistência entre valores.  

**Melhorias futuras**
- Incluir tolerância percentual configurável.
