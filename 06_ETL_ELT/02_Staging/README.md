# 02_Staging - Limpeza e padronização

## O que é
Camada de padronização com regras de qualidade e tipos coerentes para o DW.

## Por que existe
Evita que erros da origem cheguem ao DW e distorçam os KPIs.

## Como roda
1) `01_create_tables.sql`  
2) `02_load_incremental.sql`  
3) `03_quality_checks.sql`  
4) `04_reconciliation.sql`

## Como interpretar falhas
- **Num_Venda nulo**: problema de extração ou integração.  
- **Duplicidade**: possível reprocessamento sem deduplicação.  
- **Qtde <= 0 / Valor_Unit < 0**: regra de negócio inválida ou erro de cadastro.

## Ações recomendadas
- Corrigir na origem ou aplicar deduplicação antes do DW.  
- Bloquear cargas com regras críticas acima de 0.
