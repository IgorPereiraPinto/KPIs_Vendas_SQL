/*
  Projeto: KPIs_Vendas_SQL
  Análise: Outliers de Preço e Quantidade
  Objetivo:
    Detectar possíveis outliers de preço e quantidade por produto/categoria.
  Perguntas respondidas:
    - Existem preços muito fora do padrão?
    - Há quantidades anormais por item?
  Definições de KPIs:
    Outlier = valor fora do intervalo [Q1 - 1.5*IQR, Q3 + 1.5*IQR]
  Premissas / Limitações:
    - Usa PERCENTILE_CONT (SQL Server 2012+).
  Como usar (filtros de data/categoria/produto):
    Filtre por Categoria/Produto e período.
*/
WITH cte_base AS (
    SELECT
        cal.Ano,
        cal.Mes,
        dp.Categoria,
        dp.Produto,
        fv.Valor_Unit,
        fv.Qtde
    FROM fVendas AS fv
    LEFT JOIN dProdutos AS dp
        ON fv.Id_Produto = dp.Id_Produto
    LEFT JOIN dCalendario AS cal
        ON fv.Data_Pedido = cal.Data
),
cte_kpis AS (
    SELECT
        *,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Valor_Unit)
            OVER (PARTITION BY Categoria, Produto) AS Q1_Preco,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Valor_Unit)
            OVER (PARTITION BY Categoria, Produto) AS Q3_Preco,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Qtde)
            OVER (PARTITION BY Categoria, Produto) AS Q1_Qtde,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Qtde)
            OVER (PARTITION BY Categoria, Produto) AS Q3_Qtde
    FROM cte_base
),
cte_rank AS (
    SELECT
        *,
        (Q3_Preco - Q1_Preco) AS IQR_Preco,
        (Q3_Qtde - Q1_Qtde) AS IQR_Qtde
    FROM cte_kpis
),
cte_final AS (
    SELECT
        Categoria,
        Produto,
        Ano,
        Mes,
        SUM(CASE WHEN Valor_Unit < (Q1_Preco - 1.5 * IQR_Preco)
                  OR Valor_Unit > (Q3_Preco + 1.5 * IQR_Preco)
                 THEN 1 ELSE 0 END) AS Outliers_Preco,
        SUM(CASE WHEN Qtde < (Q1_Qtde - 1.5 * IQR_Qtde)
                  OR Qtde > (Q3_Qtde + 1.5 * IQR_Qtde)
                 THEN 1 ELSE 0 END) AS Outliers_Qtde,
        COUNT(*) AS Total_Registros
    FROM cte_rank
    GROUP BY Categoria, Produto, Ano, Mes
)
SELECT
    *
FROM cte_final
ORDER BY Outliers_Preco DESC, Outliers_Qtde DESC;
