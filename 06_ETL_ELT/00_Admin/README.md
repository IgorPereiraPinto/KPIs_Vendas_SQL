# 00_Admin - Controle e Qualidade

## O que é
Esta pasta guarda as tabelas de **controle de carga** e **resultados de qualidade**.

## Por que existe
Sem um watermark e registro de regras, não há rastreabilidade nem execução incremental confiável.

## Como roda
1) Execute `01_controle_carga.sql` antes da primeira carga.  
2) Atualize `etl_controle_carga` em cada etapa incremental.

## Como validar
- Verifique se `etl_controle_carga` está com a data da última carga por entidade.  
- Inspecione `dq_resultado` para regras com valores > 0.
