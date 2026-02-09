# 06 - ETL/ELT (visão geral)

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
