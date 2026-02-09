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
