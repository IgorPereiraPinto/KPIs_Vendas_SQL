# KPIs por Gerente

1) **Em uma frase:** consolida o desempenho por gerente em receita, resultado, margem e ticket. 

2) **Por que isso importa:** permite avaliar liderança e eficiência dos times. 

3) **Entradas e saídas (inputs/outputs)**
- **Entradas:** fVendas, dProdutos, dVendedores, dCalendario.  
- **Saídas:** KPIs mensais por gerente.  

4) **Como a query funciona (passo a passo)**
- **Passo 1: base e filtros** → vendas com produto e gerente.  
- **Passo 2: cálculos** → receita, resultado, margem e ticket.  
- **Passo 3: agregações** → por mês, categoria, produto e gerente.  
- **Passo 4: ranking/variações** → ranking por receita.  

5) **Como interpretar o resultado**
Gerentes com alta receita e margem são referências para escala. 

6) **Perguntas que consigo responder**
- Qual gerente lidera em receita?  
- Quem tem maior margem média?  
- Qual time gera mais ticket?  
- A performance do gerente é consistente?  
- Há concentração em poucos gerentes?  

7) **Exemplos de insights e ações**
- Gerente com baixa margem → revisar mix de produtos.  
- Gerente com alta receita e ticket baixo → avaliar descontos.  
- Performance desigual → redistribuir carteira.  
- Melhor gerente → replicar práticas.  
- Queda em um gerente → acompanhar causas.  

8) **Limitações e cuidados**
- Depende do vínculo correto vendedor → gerente.  

9) **Como usar (exemplos de filtros)**
- `WHERE Gerente = 'Guardiola' AND Ano = 2019`  

10) **Glossário rápido**
- **Gerente:** responsável pelo time de vendedores.  

**Melhorias futuras**
- Incluir metas por gerente.
