/*
  Projeto: KPIs_Vendas_SQL
  Análise: View Calendário com Datas com Venda
  Objetivo:
    Disponibilizar a dimensão calendário enriquecida com indicador de datas com venda.
  Perguntas respondidas:
    - Quais datas possuem venda?
    - Como organizar análises por ano, mês e dia?
  Definições de KPIs:
    Datas_com_Venda = 1 quando existe pelo menos uma venda na data.
  Premissas / Limitações:
    - Usa Data Pedido como referência de venda.
  Como usar (filtros de data/categoria/produto):
    Filtre por Ano, Mes e Dia para análise temporal.
*/
WITH cte_base AS (
    SELECT
        cal.Id_Data,
        cal.Data,
        cal.Dia,
        cal.Mes,
        cal.Ano
    FROM dCalendario AS cal
),
cte_kpis AS (
    SELECT
        base.*, 
        CASE WHEN fv.Data_Pedido IS NULL THEN 0 ELSE 1 END AS Datas_com_Venda
    FROM cte_base AS base
    LEFT JOIN (
        SELECT DISTINCT Data_Pedido
        FROM fVendas
    ) AS fv
        ON base.Data = fv.Data_Pedido
),
cte_rank AS (
    SELECT
        *
    FROM cte_kpis
),
cte_final AS (
    SELECT
        *
    FROM cte_rank
)
SELECT
    *
FROM cte_final;
