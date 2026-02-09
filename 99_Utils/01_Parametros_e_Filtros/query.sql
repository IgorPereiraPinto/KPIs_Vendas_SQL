/*
  Projeto: KPIs_Vendas_SQL
  Análise: Parâmetros e Filtros (Template)
  Objetivo:
    Oferecer um template de filtros para reutilização nas queries.
  Perguntas respondidas:
    - Como filtrar por período, categoria e produto?
  Definições de KPIs:
    Não aplicável (template de filtros).
  Premissas / Limitações:
    - Ajuste as variáveis conforme necessidade.
  Como usar (filtros de data/categoria/produto):
    Substitua as variáveis abaixo nas queries finais.
*/
DECLARE @DataInicio DATE = '2019-01-01';
DECLARE @DataFim DATE = '2019-12-31';
DECLARE @Categoria NVARCHAR(100) = NULL; -- exemplo: 'Computadores'
DECLARE @Produto NVARCHAR(150) = NULL; -- exemplo: 'Notebook X'

-- Exemplo de uso
SELECT
    fv.*
FROM fVendas AS fv
LEFT JOIN dProdutos AS dp
    ON fv.Id_Produto = dp.Id_Produto
WHERE fv.Data_Pedido BETWEEN @DataInicio AND @DataFim
  AND (@Categoria IS NULL OR dp.Categoria = @Categoria)
  AND (@Produto IS NULL OR dp.Produto = @Produto);
