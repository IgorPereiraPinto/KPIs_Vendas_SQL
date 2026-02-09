# 04_Marts - Views finais

## O que é
Views finais que alimentam as análises existentes (retrocompatíveis).

## Por que existe
Mantém as queries analíticas intactas e separa consumo do processamento.

## Como roda
1) `01_create_views.sql`  
2) `02_quality_checks.sql`  
3) `03_reconciliation.sql`

## Como validar
- Conferir se `vw_vendas_enriquecidas` tem as colunas esperadas.  
- Comparar receita e contagens com `fact_vendas`.
