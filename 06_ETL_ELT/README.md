# 06 - ETL/ELT (visão geral)

codex/create-and-publish-kpi-analysis-project-2074tc
## O que já existe e o que faltava
- **Já existia**: estrutura de pastas (Raw/Staging/DW/Marts) e scripts iniciais.  
- **Complementado aqui**: scripts numerados por etapa, controle de carga (watermark), reconciliação entre camadas, SCD Tipo 2 e runbook mais didático.  

## Fluxo recomendado (ordem de execução)
1) `06_ETL_ELT/00_Admin/01_controle_carga.sql`  
2) `06_ETL_ELT/01_Raw/01_create_tables.sql`  
3) `06_ETL_ELT/01_Raw/02_load_incremental.sql`  
4) `06_ETL_ELT/01_Raw/03_quality_checks.sql`  
5) `06_ETL_ELT/02_Staging/01_create_tables.sql`  
6) `06_ETL_ELT/02_Staging/02_load_incremental.sql`  
7) `06_ETL_ELT/02_Staging/03_quality_checks.sql`  
8) `06_ETL_ELT/02_Staging/04_reconciliation.sql`  
9) `06_ETL_ELT/03_DW/01_create_tables.sql`  
10) `06_ETL_ELT/03_DW/02_load_incremental.sql`  
11) `06_ETL_ELT/03_DW/03_quality_checks.sql`  
12) `06_ETL_ELT/03_DW/04_reconciliation.sql`  
13) `06_ETL_ELT/04_Marts/01_create_views.sql`  
14) `06_ETL_ELT/04_Marts/02_quality_checks.sql`  
15) `06_ETL_ELT/04_Marts/03_reconciliation.sql`  

## Como validar rapidamente
- Cheque os resultados em `dbo.dq_resultado` após cada etapa.  
- Compare reconciliações (RAW x STG x DW x MART) para garantir consistência.  

## Glossário rápido
- **Raw**: dados brutos, sem transformações.  
- **Staging**: limpeza e padronização.  
- **DW**: modelo dimensional com chaves substitutas.  
- **Marts**: views finais para análises.  
- **Watermark**: data da última carga.  
- **SCD Tipo 2**: histórico de mudanças em dimensões.

## Objetivo
Descrever como os dados chegam até a camada analítica do projeto **KPIs_Vendas_SQL**, garantindo rastreabilidade e qualidade.

## Visão do fluxo
1) **Raw**: ingestão “como veio” das fontes (sem regras de negócio).  
2) **Staging (Stg)**: limpeza, padronização e validações básicas.  
3) **DW**: modelagem dimensional (fato/dimensões) com chaves e tipos corretos.  
4) **Marts**: views finais que alimentam as análises existentes (ex.: `vw_vendas_enriquecidas`).

## Frequência e incremental
- Sugerido: carga diária (ou conforme disponibilidade da fonte).  
- Incremental padrão: por **Data_Pedido** e/ou **Num_Venda**.  
- Logs de execução em `dbo.etl_run_log` para auditoria.

## Onde estão os scripts
- **01_Raw** → criação de tabelas raw.  
- **02_Staging** → transformação e limpeza.  
- **03_DW** → tabelas dimensionais e fato final.  
- **04_Marts** → views finais para consumo analítico.

> Observação: esta camada complementa as consultas analíticas já existentes, sem alterá-las.
main
