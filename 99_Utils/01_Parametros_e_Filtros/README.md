# Parâmetros e Filtros (Template)

1) **Em uma frase:** fornece um modelo simples de filtros para reutilizar nas consultas. 

2) **Por que isso importa:** padroniza o jeito de filtrar datas, categorias e produtos, evitando inconsistência. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos.  
- **Saídas:** exemplo de consulta filtrada.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → declara datas e filtros de categoria/produto.  
- **Passo 2: cálculos** → não aplicável.  
- **Passo 3: agregações** → não aplicável.  
- **Passo 4: ranking/variações** → não aplicável.  

5) **Como interpretar o resultado**
Use o template como bloco inicial em outras queries. 

6) **Perguntas que consigo responder**
- Como filtrar por período?  
- Como filtrar por categoria/produto?  
- Como deixar filtros opcionais?  
- Como reutilizar o padrão em qualquer consulta?  
- Como garantir consistência?  

7) **Exemplos de insights e ações**
- Ajustar período para campanhas específicas.  
- Filtrar apenas categoria estratégica.  
- Comparar produtos similares.  
- Reutilizar em validações de qualidade.  
- Garantir que todos usem o mesmo filtro.  

8) **Limitações e cuidados**
- Ajuste os tipos conforme o seu schema.  

9) **Como usar (exemplos de filtros)**
- `DECLARE @DataInicio = '2020-01-01'`  
- `DECLARE @Categoria = 'Smart TV'`  

10) **Glossário rápido**
- **Filtro opcional:** filtro que só aplica se a variável não for nula.  

**Melhorias futuras**
- Criar tabela de parâmetros para BI.
