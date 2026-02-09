# KPIs_Vendas_SQL

## O que é e para quem serve
Este projeto entrega um conjunto completo de análises em **SQL Server (T-SQL)** para acompanhar performance de vendas por **Produto e Categoria**, com foco em **faturamento, resultado, margem, volume, ticket e qualidade de dados**. Ele foi pensado para times de **negócio, BI e dados** que precisam de consultas claras, auditáveis e fáceis de adaptar para novos bancos. 

## Como começar (ordem de leitura)
1) **00_Documentacao** → entenda o modelo, o dicionário de KPIs e as perguntas de negócio.  
2) **01_Base_Staging** → gere a base “Vendas Enriquecidas” e a visão de calendário.  
3) **02_KPIs_Principais** → consulte KPIs mensais por produto e categoria.  
4) **03_Analises_por_Produto_e_Categoria** → aprofunde em rankings, mix, Pareto, crescimento e perfil de pagamentos.  
5) **04_Performance_Vendedor_e_Gerente** → acompanhe desempenho de vendedores e gerentes.  
6) **05_Qualidade_e_Confiabilidade** → valide consistência, duplicidades e outliers.  
7) **99_Utils** → parâmetros, filtros e templates reutilizáveis.

## Checklist rápido de perguntas de negócio
- Quanto vendemos por mês, produto e categoria?  
- A margem está saudável? Em quais produtos ela cai?  
- O ticket médio está melhorando ou piorando?  
- Quais produtos/categorias respondem por 80% do faturamento?  
- Quais cidades/estados trazem melhor resultado?  
- Qual o impacto do método de pagamento?  
- Vendedores e gerentes estão batendo metas?  
- Há dados com problemas (nulos, duplicados, preços anormais)?  

## Onde encontrar KPIs, análises e validações
- **KPIs principais**: `/02_KPIs_Principais`  
- **Análises por produto/categoria**: `/03_Analises_por_Produto_e_Categoria`  
- **Performance de pessoas**: `/04_Performance_Vendedor_e_Gerente`  
- **Qualidade de dados**: `/05_Qualidade_e_Confiabilidade`  
- **Base staging**: `/01_Base_Staging`  

codex/create-and-publish-kpi-analysis-project-2074tc
## Como os dados chegam (ETL/ELT)
- A camada **ETL/ELT** está em `/06_ETL_ELT`, cobrindo **Raw → Staging → DW → Marts**.  
- Consulte `00_Documentacao/04_Processo_ETL.md` para regras de qualidade, incremental e SCD.  


## Como os dados chegam (ETL/ELT)
- A camada de ETL/ELT está em `/06_ETL_ELT`, cobrindo **Raw → Staging → DW → Marts**.
- Consulte `00_Documentacao/04_Processo_ETL.md` para regras de qualidade, incremental e SCD.
 

main

## Como adaptar para outro banco/esquema
1) Ajuste nomes de tabelas/colunas em **00_Documentacao/00_Modelo_Dados.md**.  
2) Atualize a query de **Vendas Enriquecidas** para refletir chaves e joins.  
3) Revise tipos de data e funções de janela (se não for SQL Server).  
4) Reexecute validações em **05_Qualidade_e_Confiabilidade**.  

## Estrutura do repositório
codex/create-and-publish-kpi-analysis-project-2074tc

main
00_Documentacao/
01_Base_Staging/
02_KPIs_Principais/
03_Analises_por_Produto_e_Categoria/
04_Performance_Vendedor_e_Gerente/
05_Qualidade_e_Confiabilidade/
codex/create-and-publish-kpi-analysis-project-2074tc
06_ETL_ELT/
99_Utils/



06_ETL_ELT/

main

> Dica: comece pela pasta **01_Base_Staging** para garantir que os cálculos de Receita, Resultado e Margem estejam corretos antes das análises.
