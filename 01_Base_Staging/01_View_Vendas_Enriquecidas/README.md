# View Vendas Enriquecidas

1) **Em uma frase:** esta análise cria uma base única de vendas com produto, categoria, cliente, vendedor e KPIs calculados por item. 

2) **Por que isso importa:** sem uma base padronizada, cada time calcula receita/margem de um jeito diferente, gerando decisões contraditórias. Aqui tudo fica alinhado e auditável. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dVendedores, dClientes, dPagamento, dStatus, dUnidades, dCalendario.  
- **Saídas:** tabela com dimensões + Receita, Resultado, Margem e componentes de custo.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → junta fVendas com as dimensões usando chaves.  
- **Passo 2: cálculos** → Receita = Qtde*Valor Unit; custos unitários multiplicados pela Qtde.  
- **Passo 3: agregações** → não há agregação, mantemos o grão do item.  
- **Passo 4: ranking/variações** → não aplicável aqui.  

5) **Como interpretar o resultado**
Cada linha representa um item de venda. Use filtros por data, produto ou categoria para análises específicas. 

6) **Perguntas que consigo responder**
- Qual a receita por item de venda?  
- Qual produto/categoria gerou maior resultado?  
- Qual vendedor vendeu itens com maior margem?  
- Qual cliente tem maior volume?  
- Qual status de venda impacta a receita?  

7) **Exemplos de insights e ações**
- Produto com margem negativa → revisar custo/precificação.  
- Categoria com alto volume e baixo resultado → reavaliar mix.  
- Vendedor com ticket alto → replicar estratégia.  
- Cliente com frequência alta → programa de fidelidade.  
- Status “Cancelado” alto → investigar processo de entrega.  

8) **Limitações e cuidados**
- Se faltar dimensão (ex.: cliente sem cadastro), os campos podem vir nulos.  
- Use Data Pedido como padrão; Data Envio é alternativa.  
- Margem % fica nula quando Receita = 0.  

9) **Como usar (exemplos de filtros)**
- `WHERE Data_Pedido BETWEEN '2019-01-01' AND '2019-12-31'`  
- `AND Categoria = 'Computadores'`  
- `AND Produto = 'Notebook X'`  

10) **Glossário rápido**
- **Receita:** Qtde * Valor Unit.  
- **Ticket:** Receita / Qtde de Vendas.  
- **Preço médio:** Receita / Qtde.  
- **Margem:** Resultado / Receita.  
- **MoM/YoY:** variação mês contra mês / ano contra ano.  

**Melhorias futuras**
- Criar view materializada para performance em grandes volumes.
