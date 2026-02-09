# Validador de Chaves e Nulos

1) **Em uma frase:** este diagnóstico mostra se existem campos críticos vazios na tabela de vendas. 

2) **Por que isso importa:** chaves ou valores nulos quebram joins e distorcem KPIs, levando a decisões erradas. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas.  
- **Saídas:** lista de campos com contagem de nulos.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → carrega colunas críticas da fVendas.  
- **Passo 2: cálculos** → conta nulos por campo.  
- **Passo 3: agregações** → soma total por campo.  
- **Passo 4: ranking/variações** → ordena por maior número de nulos.  

5) **Como interpretar o resultado**
Campos com muitos nulos indicam falhas de cadastro ou integração. 

6) **Perguntas que consigo responder**
- Temos produtos sem cadastro?  
- Existem vendas sem cliente?  
- Custos e impostos estão preenchidos?  
- Alguma medida está incompleta?  
- Qual campo é a maior fonte de inconsistência?  

7) **Exemplos de insights e ações**
- Muitos nulos em Id_Produto → revisar ETL de produtos.  
- Nulos em Valor Unit → erro de captura de preço.  
- Nulos em Id_Status → ajustar workflow de pedidos.  
- Nulos em Id_Vendedor → reforçar cadastro obrigatório.  
- Nulos em Impostos → risco fiscal.  

8) **Limitações e cuidados**
- Nulo não significa necessariamente erro, pode ser regra de negócio.  
- Valide com o time de dados antes de corrigir.  

9) **Como usar (exemplos de filtros)**
- `WHERE Data_Pedido BETWEEN '2023-01-01' AND '2023-12-31'`  

10) **Glossário rápido**
- **Nulo:** campo sem valor preenchido.  

**Melhorias futuras**
- Incluir checagem de chaves inexistentes (join quebrado).
