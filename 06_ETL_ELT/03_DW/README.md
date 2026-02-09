# 03_DW - Modelo dimensional

## O que é
Modelo dimensional com fato `fact_vendas` e dimensões `dim_*`.

## Por que existe
Cria consistência e performance para análises, com histórico em dimensões críticas.

## Como roda
1) `01_create_tables.sql`  
2) `02_load_incremental.sql`  
3) `03_quality_checks.sql`  
4) `04_reconciliation.sql`

## SCD Tipo 2
- Aplicado em **dim_produto** e **dim_vendedor**.  
- Colunas: `dt_inicio_vigencia`, `dt_fim_vigencia`, `flag_ativo`.

## Como validar
- Verificar se apenas uma linha ativa por Id_Produto/Id_Vendedor.  
- Checar se `fact_vendas` não possui chaves nulas.
