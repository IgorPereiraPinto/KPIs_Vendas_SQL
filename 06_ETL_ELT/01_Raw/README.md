# 01_Raw - Ingestão bruta

## O que é
Camada que espelha as fontes sem transformação, apenas com colunas técnicas.

## Por que existe
Serve como “fonte auditável” para reprocessamentos e validações.

## Como roda
1) `01_create_tables.sql` cria as tabelas raw.  
2) `02_load_incremental.sql` demonstra o uso do watermark.  
3) `03_quality_checks.sql` registra regras básicas em `dq_resultado`.

## Como validar
- Verifique se `dt_carga` e `origem` estão preenchidos.  
- Conferir nulos críticos e Qtde <= 0 em `dq_resultado`.
