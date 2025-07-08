# Análise de Criminalidade no Estado de São Paulo

Este repositório contém o trabalho de econometria em **R**, que analisa como a pandemia de COVID-19 afetou os índices de criminalidade nas diferentes regiões do estado de São Paulo, considerando fatores populacionais e tendências temporais.

## Conteúdo

* **notebooks/**

  * `TrabalhoEconometria.Rmd`: Documento RMarkdown com todo o código em R, incluindo tratamento de dados, análise descritiva, visualizações e estimativas econométricas.
* **data/**

  * `br_sp_gov_ssp_ocorrencias_registradas.csv`: Base de dados de ocorrências criminais por município e região.
  * `habitantes_por_municipio.xlsx`: Planilha com estimativas populacionais por município e ano.
* **scripts/**

  * `analise_criminalidade.R`: Script em R que reproduz toda a análise de forma sequencial.
* **Analise criminalidade.txt**: Exportação do notebook original (para referência).

## Estrutura do Projeto

```bash
├── data/
│   ├── br_sp_gov_ssp_ocorrencias_registradas.csv
│   └── habitantes_por_municipio.xlsx
├── notebooks/
│   └── TrabalhoEconometria.Rmd
├── scripts/
│   └── analise_criminalidade.R
├── Analise criminalidade.txt
└── README.md
```

## Pré-requisitos

* R (>= 4.0)
* RStudio ou outro editor compatível com RMarkdown

### Pacotes R

* `readr`
* `dplyr`
* `ggplot2`
* `plm`
* `lubridate`
* `tidyr`

Instale-os no R com:

```r
install.packages(c("readr", "dplyr", "ggplot2", "plm", "lubridate", "tidyr"))
```

## Como Executar

1. Clone este repositório:

   ```bash
   git clone https://github.com/seu-usuario/analise-criminalidade-sp.git
   cd analise-criminalidade-sp
   ```
2. Abra o RStudio e carregue o arquivo RMarkdown:

   ```r
   # No console do R
   rmarkdown::render("notebooks/TrabalhoEconometria.Rmd")
   ```
3. Para rodar o script sequencial em R:

   ```r
   source("scripts/analise_criminalidade.R")
   ```

## Descrição do Fluxo de Trabalho

1. **Aquisição de dados**: importação das bases de criminalidade e população.
2. **Tratamento**: criação da variável `total_crimes`, agregação por região e ano, junção com dados populacionais.
3. **Análises descritivas**: estatísticas resumidas, boxplots, gráficos de dispersão e de barras para explorar tendências e diferenças regionais.
4. **Modelos econométricos**: estimativas de painel e regressões para medir o impacto da pandemia, controlando por população e efeitos de região.
5. **Conclusão**: interpretação dos resultados e verificações de robustez.

## Principais Resultados

* Observou‑se redução significativa na criminalidade a partir de 2020, atribuída às medidas de isolamento social.
* Variáveis demográficas e regionais mostraram-se estatisticamente relevantes.
* O modelo de painel apresentou R² ajustado elevado, indicando bom poder explicativo.

## Licença

Este projeto está sob a [MIT License](LICENSE).

## Contato

* Autor: Jonathas Costa da Sila
* Email: joncosil@hotmail.com
* LinkedIn: https://www.linkedin.com/in/jonathas-costa-da-silva-939b311b6/
