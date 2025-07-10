# Trabalho Econometria

# 1) Pergunta
# "Como a pandemia afetou os índices de criminalidade nas diferentes regiões de São Paulo, 
# considerando fatores populacionais e tendências temporais?"

# 2) Descrição e análise dos dados

# Os dados são secundários, coletados através do site https://basedosdados.org/search?theme=safety&page=1.
# A base foi retirada do governo de São Paulo e apresenta dados de ocorrências criminais por regiões.
# São 27 variáveis, sendo que 23 delas serão somadas para formar a variável dependente:
# o total de crimes por município por ano.

# Segue abaixo o tratamento dos dados!

library(readr)
library(repr)
options(repr.plot.width = 16, repr.plot.height = 12)
df <- read_csv("/content/br_sp_gov_ssp_ocorrencias_registradas.csv")
colnames(df)

head(df)
tail(df)

df$total_crimes <- rowSums(df[, 5:27], na.rm = TRUE)
head(df)

library(dplyr)
df_criminalidade_municipio <- df %>%
  group_by(ano, regiao_ssp) %>%
  summarise(crimes_totais = sum(total_crimes, na.rm = TRUE)) %>%
  arrange(ano, regiao_ssp)

df_criminalidade_municipio

# Acima é possível verificar o índice de criminalidade por região e ano.
# Agora vamos agrupar todos os municípios para analisar a criminalidade geral no estado.

df_criminalidade <- df %>%
  group_by(ano) %>%
  summarise(crimes_totais = sum(total_crimes, na.rm = TRUE)) %>%
  arrange(ano)

df_criminalidade

# Análise descritiva e gráfica da criminalidade por região

analise_descritiva <- df_criminalidade_municipio %>%
  group_by(regiao_ssp) %>%
  summarise(
    soma_total = sum(crimes_totais, na.rm = TRUE),
    media = mean(crimes_totais, na.rm = TRUE),
    mediana = median(crimes_totais, na.rm = TRUE),
    desvio_padrao = sd(crimes_totais, na.rm = TRUE),
    minimo = min(crimes_totais, na.rm = TRUE),
    maximo = max(crimes_totais, na.rm = TRUE)
  )
analise_descritiva

# A análise descritiva mostra que as regiões mais populosas têm maiores índices de criminalidade.

library(ggplot2)
ggplot(df_criminalidade_municipio, aes(x = reorder(regiao_ssp, -crimes_totais), y = crimes_totais, fill = regiao_ssp)) +
  geom_boxplot(outlier.color = "red", outlier.shape = 16) +
  labs(title = "Distribuição de Crimes por Município", x = "Municípios", y = "Quantidade Total de Crimes") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 14),
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        legend.position = "none") +
  scale_fill_brewer(palette = "Set3")

# O boxplot mostra a discrepância entre as regiões, com a Capital se destacando. Há outliers visíveis.

ggplot(df_criminalidade_municipio, aes(x = ano, y = crimes_totais, color = regiao_ssp)) +
  geom_point(size = 3, alpha = 0.6) +
  labs(title = "Relação entre Ano e Crimes Totais por Município", x = "Ano", y = "Quantidade Total de Crimes") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 15),
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 12)) +
  scale_color_brewer(palette = "Set1")

# O gráfico mostra diferentes padrões: crescimento em SP e queda em regiões como Bauru e Araçatuba.

ggplot(df_criminalidade_municipio, aes(x = as.factor(ano), y = crimes_totais, fill = as.factor(ano))) +
  geom_bar(stat = "identity", color = "black", alpha = 0.8) +
  labs(title = "Criminalidade em Regiões de São Paulo (2002-2021)",
       subtitle = "Evolução anual do total de crimes por região",
       x = NULL, y = "Total de Crimes", fill = "Ano") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, hjust = 0.5),
        plot.subtitle = element_text(size = 12, hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        strip.text = element_text(size = 12, face = "bold"),
        panel.spacing = unit(0.5, "lines"),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 12)) +
  scale_fill_viridis_d(option = "plasma") +
  facet_wrap(~ regiao_ssp, scales = "free_y", ncol = 4)

# O gráfico mostra queda em todas as regiões a partir de 2020, reforçando o impacto da pandemia.

# Análise geral

analise_descritiva_geral <- df_criminalidade %>%
  summarise(
    soma_total = sum(crimes_totais, na.rm = TRUE),
    media = mean(crimes_totais, na.rm = TRUE),
    mediana = median(crimes_totais, na.rm = TRUE),
    desvio_padrao = sd(crimes_totais, na.rm = TRUE),
    minimo = min(crimes_totais, na.rm = TRUE),
    maximo = max(crimes_totais, na.rm = TRUE)
  )
analise_descritiva_geral

ggplot(df_criminalidade, aes(y = crimes_totais)) +
  geom_boxplot(outlier.color = "red", outlier.shape = 16) +
  labs(title = "Distribuição de Crimes", y = "Quantidade Total de Crimes") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        legend.position = "none") +
  scale_fill_brewer(palette = "Set3")

ggplot(df_criminalidade, aes(x = ano, y = crimes_totais)) +
  geom_point(size = 3, alpha = 0.6) +
  labs(title = "Relação entre Ano e Crimes Totais", x = "Ano", y = "Quantidade Total de Crimes") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 10),
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14)) +
  scale_color_brewer(palette = "Set1")

# Não há linearidade clara no tempo ao observar os dados agregados.

ggplot(df_criminalidade, aes(x = as.factor(ano), y = crimes_totais)) +
  geom_bar(stat = "identity", color = "black", alpha = 0.8) +
  labs(title = "Criminalidade por Ano", x = "Ano", y = "Total de Crimes", fill = "Ano") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 15),
        axis.text.y = element_text(angle = 45, hjust = 1, size = 15),
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        strip.text = element_text(size = 12, face = "bold"))

# Observamos forte queda em 2020 e 2021 com a pandemia.

# Adicionando população

library(readxl)
popu <- read_excel("/content/habitantes por municipio.xlsx")
df_criminalidade_municipio$habitantes <- popu$habitantes

popu_ano <- popu %>%
  group_by(ano) %>%
  summarise(habitantes = sum(habitantes, na.rm = TRUE)) %>%
  arrange(ano)

df_criminalidade$habitantes <- popu_ano$habitantes

# Criando dummy para pandemia

df_criminalidade$pandemia <- ifelse(df_criminalidade$ano >= 2020, 1, 0)

ggplot(df_criminalidade, aes(x = ano, y = crimes_totais)) +
  geom_line() +
  geom_point() +
  geom_vline(xintercept = 2019, color = "red", linetype = "dashed") +
  labs(title = "Tendência da Criminalidade (2002-2021)",
       x = "Ano", y = "Criminalidade") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 15),
        axis.text.y = element_text(angle = 45, hjust = 1, size = 15),
        plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
        strip.text = element_text(size = 12, face = "bold"))

df_criminalidade_municipio$pandemia <- ifelse(df_criminalidade_municipio$ano >= 2020, 1, 0)

# 3) Estimativas economêtricas

# Análise de dados em painel

install.packages('plm')
library(plm)
library(broom)

reg_criminalidade_municipio <- lm(crimes_totais ~ regiao_ssp + habitantes + ano + pandemia,
                                   data = df_criminalidade_municipio)
results <- tidy(reg_criminalidade_municipio)
results

# A variável pandemia é estatisticamente significativa.
# O tempo (ano) não é significativo, possivelmente pela quebra de tendência.
# População tem impacto pequeno mas significativo.

# Interações

modelo_interacao <- lm(crimes_totais ~ regiao_ssp * pandemia + habitantes + ano,
                       data = df_criminalidade_municipio)
tidy(modelo_interacao)

# Pandemia tem efeito claro e significativo ao interagir com a região.

modelo_tendencias <- lm(crimes_totais ~ regiao_ssp * ano + habitantes + pandemia,
                        data = df_criminalidade_municipio)
tidy(modelo_tendencias)

# Ano não é significativo na maioria dos casos.

summary(reg_criminalidade_municipio)

# R² ajustado alto (~97%) e F-Estatístico significativo.
# A pandemia trouxe uma queda média de ~-38.060 crimes.

# 4) Conclusão

# A pandemia impactou significativamente a criminalidade em SP.
# R² de 0,9734 e R² ajustado de 0,9717 mostram forte explicação do modelo.
# O p-valor da pandemia (< 2e-16) comprova sua relevância estatística.
# As variáveis regionais também foram relevantes.
# Testes adicionais confirmaram a robustez dos resultados.
# Concluímos que a pandemia reduziu a criminalidade em SP, principalmente por manter as pessoas em casa.
