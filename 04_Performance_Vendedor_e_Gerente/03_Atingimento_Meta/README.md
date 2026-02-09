# Atingimento de Meta por Vendedor

1) **Em uma frase:** compara o faturamento do vendedor com a meta mensal definida. 

2) **Por que isso importa:** metas direcionam o time comercial e mostram se o resultado está dentro do esperado. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dVendedores, dCalendario, fMetas.  
- **Saídas:** Receita, Meta, Atingimento_Pct e Gap por vendedor/mês.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → receita mensal por vendedor.  
- **Passo 2: cálculos** → junta metas e calcula atingimento.  
- **Passo 3: agregações** → por mês e vendedor.  
- **Passo 4: ranking/variações** → não aplicável.  

5) **Como interpretar o resultado**
Atingimento_Pct >= 1 indica meta atingida; Gap mostra quanto faltou ou excedeu. 

6) **Perguntas que consigo responder**
- Quem bateu meta no mês?  
- Quem ficou abaixo do esperado?  
- Qual o gap total de metas?  
- Atingimento está melhorando?  
- Vendedor com meta muito alta?  

7) **Exemplos de insights e ações**
- Baixo atingimento → revisar carteira e coaching.  
- Meta superada → reconhecer e replicar boas práticas.  
- Gap alto em vários vendedores → metas desalinhadas.  
- Meta constante com receita sazonal → ajustar metas por período.  
- Atingimento alto e margem baixa → revisar mix.  

8) **Limitações e cuidados**
- Se a coluna de meta não existir em fMetas, crie um template:  
  - **fMetas(Data, Id_Vendedor, Meta)**.  
- A consulta usa Data de fMetas para relacionar ano/mês.  

9) **Como usar (exemplos de filtros)**
- `WHERE Ano = 2019 AND Mes = 4 AND Vendedor = 'Ronaldo'`  

10) **Glossário rápido**
- **Meta:** objetivo de receita para o vendedor.  
- **Gap:** diferença entre realizado e meta.  

**Melhorias futuras**
- Incluir metas por categoria ou produto.
