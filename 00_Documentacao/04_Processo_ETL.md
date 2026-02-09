# 04 - Processo ETL/ELT (Runbook)

## 1) Pré-requisitos
- SQL Server 2019+.
- Schemas/tabelas RAW disponíveis ou rotinas de ingestão prontas.
- Permissões para criar tabelas e views.

## 2) Fontes e frequência
- **Fontes**: ERP/CRM, financeiro e cadastros (produto/cliente/vendedor).  
- **Frequência**: diária (recomendado).  
- **Granularidade**: item por venda (Num_Venda + Id_Produto).  

## 3) Fluxo de dados (camadas)
1. **Raw** (`raw_*`) → dados “como vieram”, sem transformações.  
2. **Staging** (`stg_*`) → limpeza, padronização e validações.  
3. **DW** (`dim_*`, `fact_*`) → modelo dimensional.  
4. **Marts** (`vw_*`) → views finais usadas nas análises.  

## 4) Ordem de execução (passo a passo)
1) `06_ETL_ELT/00_Admin/01_controle_carga.sql`  
2) Raw: `01_create_tables.sql` → `02_load_incremental.sql` → `03_quality_checks.sql`  
3) Staging: `01_create_tables.sql` → `02_load_incremental.sql` → `03_quality_checks.sql` → `04_reconciliation.sql`  
4) DW: `01_create_tables.sql` → `02_load_incremental.sql` → `03_quality_checks.sql` → `04_reconciliation.sql`  
5) Marts: `01_create_views.sql` → `02_quality_checks.sql` → `03_reconciliation.sql`  

## 5) Parâmetros e incremental (watermark)
- **Watermark principal**: `Data_Pedido`.  
- **Alternativo**: `Data_Envio`.  
- Controle em `dbo.etl_controle_carga` com `Dt_Ultima_Carga` por entidade.

## 6) Regras de qualidade
- **Nulos**: chaves críticas não podem ser nulas.  
- **Duplicidade**: Num_Venda + Id_Produto deve ser único.  
- **Valores inválidos**: Qtde > 0, Valor_Unit >= 0.  
- **Reconciliação**: Receita consistente entre camadas.  

## 7) SCD (mudanças em dimensões)
- **Padrão**: SCD Tipo 2 em `dim_produto` e `dim_vendedor`.  
- **Tipo 1** em dimensões restantes (sobrescreve).  

## 8) Troubleshooting (exemplos)
- **Muitos nulos** → revisar ingestão ou mapping de chaves.  
- **Duplicidades** → aplicar deduplicação antes do DW.  
- **Receita divergente** → checar filtros e regras de Qtde/Valor_Unit.  

## 9) Melhorias futuras
- Automatizar alertas quando `dq_resultado` > 0.  
- Expandir reconciliação para custos/impostos.  
- Otimizar carga incremental com CDC.
# 04 - Processo ETL/ELT

## 1) Fontes e frequência
- **Fontes**: ERP/CRM, sistemas financeiros e cadastro de produtos/clientes/vendedores.  
- **Frequência**: diária (recomendado), com possibilidade de cargas intradiárias para operações críticas.  
- **Granularidade**: item por venda (Num_Venda + Id_Produto).  

## 2) Fluxo de dados (camadas)
1. **Raw** (`raw_*`) → dados “como vieram”, sem transformações.  
2. **Staging** (`stg_*`) → limpeza, padronização e validações.  
3. **DW** (`dw_*`) → modelo dimensional com chaves e tipos corretos.  
4. **Marts** (`vw_*`) → views finais usadas pelas análises.  

## 3) Regras de qualidade
- **Nulos**: chaves primárias e campos críticos não podem ser nulos.  
- **Duplicidade**: validar Num_Venda + Id_Produto como chave do item.  
- **Valores inválidos**: Qtde > 0, Valor_Unit >= 0, datas válidas.  
- **Reconciliação**: Receita = Qtde * Valor_Unit e Resultado consistente.  

## 4) Estratégia incremental
- **Critério principal**: `Data_Pedido` como recorte de carga.  
- **Critério alternativo**: `Num_Venda` para cargas por lote.  
- **Controle**: log de execução em `dbo.etl_run_log` com data/hora, status e contagens.

## 5) Tratamento de mudanças em dimensões (SCD)
- **Padrão**: SCD Tipo 1 (sobrescreve valores).  
- **Alternativa**: SCD Tipo 2 (histórico), quando necessário manter mudanças de atributos (ex.: mudança de gerente).  

## 6) Observações
- As queries analíticas existentes consomem `vw_vendas_enriquecidas` (camada Marts).  
- Qualquer divergência de coluna deve ser documentada em `00_Modelo_Dados.md`.
