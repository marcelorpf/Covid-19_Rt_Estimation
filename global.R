# Pacotes necessários

library(shiny)
library(EpiEstim)
library(incidence)
library(tidyverse)
library(magrittr)
library(lubridate)
library(plotly)
library(scales)
library(reshape2)
library(caTools)

# Definições adicionais
`%>%` <- magrittr::`%>%`

# Opções adicionais
options(scipen = 999, OutDec = ",")
theme_set(theme_bw() + theme(text = element_text(size = 12)))

# Leitura dos dados
dados <- read_csv("https://data.brasil.io/dataset/covid19/caso_full.csv.gz")
dados <- dados %>%
  select(-c("city_ibge_code", "is_last", "is_repeated", "last_available_date",
            "order_for_place")) %>%
  rename(confirmed = last_available_confirmed, confirmed_per_100k = last_available_confirmed_per_100k_inhabitants,
         deaths = last_available_deaths, death_rate = last_available_death_rate) %>%
  mutate(state = case_when(
    state == "RO" ~ "Rondônia",
    state == "AC" ~ "Acre",
    state == "AM" ~ "Amazonas",
    state == "RR" ~ "Roraima",
    state == "PA" ~ "Pará",
    state == "AP" ~ "Amapá",
    state == "TO" ~ "Tocantins",
    state == "MA" ~ "Maranhão",
    state == "PI" ~ "Piauí",
    state == "CE" ~ "Ceará",
    state == "RN" ~ "Rio Grande do Norte",
    state == "PB" ~ "Paraíba",
    state == "PE" ~ "Pernambuco",
    state == "AL" ~ "Alagoas",
    state == "SE" ~ "Sergipe",
    state == "BA" ~ "Bahia",
    state == "MG" ~ "Minas Gerais",
    state == "ES" ~ "Espírito Santo",
    state == "RJ" ~ "Rio de Janeiro",
    state == "SP" ~ "São Paulo",
    state == "PR" ~ "Paraná",
    state == "SC" ~ "Santa Catarina",
    state == "RS" ~ "Rio Grande do Sul",
    state == "MS" ~ "Mato Grosso do Sul",
    state == "MT" ~ "Mato Grosso",
    state == "GO" ~ "Goiás",
    state == "DF" ~ "Distrito Federal"
  ))

dados_uf <- dados %>%
  filter(place_type == "state")

dados_municipios <- dados %>%
  filter(place_type == "city")

pop_br = dados_uf %>%
  filter(date == max(date)) %>%
  select(estimated_population_2019) %>%
  sum()

dados_brasil <- dados_uf %>%
  group_by(date) %>%
  summarise(
    epidemiological_week = last(epidemiological_week),
    confirmed = sum(confirmed),
    deaths = sum(deaths),
    new_confirmed = sum(new_confirmed),
    new_deaths = sum(new_deaths)
  ) %>%
  mutate(
    confirmed_per_100k = 100000*confirmed/pop_br,
    death_rate = deaths/confirmed
  )

# Nomes das UFs

uf <- unique(dados_uf$state)
uf <- uf[order(uf)]
uf <- c("<Todos>",uf)
