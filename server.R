function(input, output, session) {
  
  # Dados selecionados
  
  selectedData <- reactive({
    if (input$uf == "<Todos>")
      dados_brasil
    else if (input$municipio == "<Todos>") {
      dados_uf %>%
        filter(state == input$uf)
    } else {
      dados_municipios %>%
        filter(state == input$uf, city == input$municipio)
    }
  })
  
  cities_list <- reactive({
    if (input$uf != "<Todos>") {
      tmp <- filter(dados_municipios, state == input$uf)
      tmp <- unique(tmp$city)
      tmp <- tmp[tmp != "Importados/Indefinidos"]
      tmp <- tmp[order(tmp)]
      tmp
    }
  })
  observe({
    updateSelectInput(session, "municipio", choices = c("<Todos>", cities_list()))
  })
  
  place_name <- reactive({
    if (input$uf == "<Todos>")
      "Brasil"
    else if (input$municipio == "<Todos>") {
      input$uf
    } else {
      paste0(input$municipio, ", ", input$uf)
    }
  })
  
  # ##### Cálculo dos Rt's #####
  # df <- selectedData()
  # #df <- filter(dados_uf, state == "Paraíba")
  # df <- data.frame(I = df$new_confirmed, date = df$date)
  # Rt <- estimate_R(df,
  #                  method = "parametric_si",
  #                  config = make_config(list(mean_si = 4.7, std_si = 2.9)))
  # df <- tibble(date = df$date[8:length(df$date)],
  #              R = Rt$R[, 3],
  #              lower = Rt$R[, 5],
  #              upper = Rt$R[, 11])
  # #plot(Rt, what = "R")
  
  ##### Gráfico dos Rt's #####
  output$plot1 <- renderPlotly({
    ##### Cálculo dos Rt's #####
    df <- selectedData()
    #df <- filter(dados_uf, state == "Paraíba")
    df <- data.frame(I = df$new_confirmed, date = df$date)
    df$I[df$I < 0] <- 0
    fim01 = length(df$date)
    tstart01 <- seq(2,(fim01-13))
    tend01 <- tstart01+13
    Rt <- estimate_R(df,
                     method = "parametric_si",
                     #config = make_config(list(mean_si = 4.7, std_si = 2.9))
                     config = make_config(list(mean_si = 4.8, std_si = 2.3,
                                               t_start=tstart01, t_end=tend01)))
    df <- tibble(date = df$date[15:length(df$date)],
                 R = Rt$R[, 3],
                 lower = Rt$R[, 5],
                 upper = Rt$R[, 11],
                 ma14 = runmean(Rt$R[, 3], 14))
    R_last <- df$R[length(df$R)]
    l_last <- df$lower[length(df$R)]
    u_last <- df$upper[length(df$R)]
    ma_last <- df$ma14[length(df$R)]
    #plot(Rt, what = "R")
    plt = plot_ly(
      df,
      x = ~date,
      y = ~upper,
      name = "Quantil 97,5%",
      type = "scatter",
      mode = "lines",
      line = list(color = "transparent"),
      showlegend = FALSE
    ) %>%
      add_trace(y = ~lower, name = "Quantil 2,5%", type = "scatter", mode = "lines",
                line = list(color = "transparent"), fillcolor='rgba(0,100,80,0.2)',
                fill = "tonexty", showlegend = FALSE) %>%
      add_trace(y = ~R, name = expression(R(t)), type = "scatter",
                mode = "lines", line = list(color='rgb(0,100,80)'), showlegend = T) %>%
      add_trace(y = ~ma14, name = "Média Móvel (14 dias)", type = "scatter",
                mode = "lines", line = list(color="red", dash = "dot"),
                showlegend = T) %>%
      add_lines(y = ~1, name = "Limite",
                line = list(color = "gray", dash = "dot"),
                showlegend = FALSE) %>%
      layout(title = paste("Número Reprodutivo Efetivo,", place_name()),
             xaxis = list(title = "Data",
                          type = "date",
                          zeroline = TRUE),
                          #showline = TRUE),
             yaxis = list(title = "R(t)",
                          rangmode = "nonnegative"),
             legend = list(x = .6, y = .9),
             modebar = list(orientation = "v")
             ) %>%
      config(displayModeBar = TRUE,
             displaylogo = FALSE,
             locale = "pt-br",
             mathjax = 'cdn') %>%
      ## Add update date
      add_annotations(text = paste0("Atualizado em ", format(df$date[length(df$date)], "%d/%m/%y")),
                      x = 1, y = 0, xref = "paper", yref = "paper",
                      font = list(family = "Arial", size = 10), align = "right",
                      showarrow = FALSE) %>%
      add_annotations(text = "Fonte: http://obsrpb.com.br/ufpb/",
                      x = 0, y = 0, xref = "paper", yref = "paper",
                      font = list(family = "Arial", size = 10), align = "left",
                      showarrow = FALSE) %>%
      add_annotations(text = paste0("<b>R(t) = <b>", round(R_last, 4),
                                    "\nIC 95% = (", round(l_last, 4), ";",
                                    round(u_last, 4), ")",
                                    "\nMédia Móvel (14 dias) do R(t) = ", round(ma_last, 4)),
                      x = .85, y = .65, xref = "paper", yref = "paper",
                      font = list(family = "Arial", size = 10), align = "left",
                      showarrow = FALSE)
    plt
  })
}

