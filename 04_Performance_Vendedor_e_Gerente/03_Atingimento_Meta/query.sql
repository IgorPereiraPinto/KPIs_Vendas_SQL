/*
  Projeto: KPIs_Vendas_SQL
  Análise: Atingimento de Meta por Vendedor
  Objetivo:
    Comparar receita realizada com a meta do vendedor.
  Perguntas respondidas:
    - O vendedor atingiu a meta no mês?
    - Qual o gap entre meta e realizado?
  Definições de KPIs:
    Atingimento_% = Receita / Meta
    Gap = Receita - Meta
  Premissas / Limitações:
    - fMetas deve conter coluna Meta (valor numérico).
    - Se não existir, criar a coluna Meta em fMetas ou usar template descrito no README.
  Como usar (filtros de data/categoria/produto):
    Filtre por Ano/Mes e Vendedor.
*/
WITH cte_base AS (
    SELECT
        cal.Ano,
        cal.Mes,
        dv.Id_Vendedor,
        dv.Vendedor,
        SUM(fv.Qtde * fv.Valor_Unit) AS Receita
    FROM fVendas AS fv
    LEFT JOIN dVendedores AS dv
        ON fv.Id_Vendedor = dv.Id_Vendedor
    LEFT JOIN dCalendario AS cal
        ON fv.Data_Pedido = cal.Data
    GROUP BY cal.Ano, cal.Mes, dv.Id_Vendedor, dv.Vendedor
),
cte_kpis AS (
    SELECT
        base.Ano,
        base.Mes,
        base.Id_Vendedor,
        base.Vendedor,
        base.Receita,
        fm.Meta AS Meta
    FROM cte_base AS base
    LEFT JOIN fMetas AS fm
        ON base.Id_Vendedor = fm.Id_Vendedor
        AND base.Ano = YEAR(fm.Data)
        AND base.Mes = MONTH(fm.Data)
),
cte_rank AS (
    SELECT
        *,
        CASE
            WHEN Meta = 0 THEN NULL
            ELSE Receita / NULLIF(Meta, 0)
        END AS Atingimento_Pct,
        Receita - Meta AS Gap
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
