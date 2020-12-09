fluidPage(
  titlePanel("Covid-19: Estimação do Número Reprodutivo Efetivo"),
  withMathJax(),
  tags$p("O número reprodutivo basal ou razão de reprodução básica \\(R_0\\) indica o quão contagiosa uma doença infecciosa é. O número aponta quantas pessoas, em média, um indivíduo infeccioso pode contagiar em uma população totalmente suscetível. Apesar de ser muito útil para avaliar o potencial de propagação de doenças infecciosas em diferentes contextos, é uma medida teórica."),
  tags$p("No momento em que as doenças infecciosas se propagam e indivíduos que já foram infectados tornam-se resistentes, não pertencendo mais ao grupo de suscetíveis, a premissa de uma população totalmente suscetível passa a não ser mais uma boa aproximação da realidade e uma nova medida epidemiológica faz-se necessária."),
  tags$p("O número reprodutivo efetivo ou razão de reprodução efetiva \\(R_t\\) indica quantas pessoas, em média, um indivíduo infeccioso pode contagiar em uma população na qual nem todos são suscetíveis. Se \\(R_t<1\\), ou seja, se cada indivíduo infeccioso causa, em média, menos do que uma nova infecção, então os níveis de contágio da doença irão decair e a doença irá, eventualmente, desaparecer. Se \\(R_t=1\\), ou seja, se cada indivíduo infeccioso causa, em média, exatamente uma nova infecção, então os níveis de contágio da doença permanecerão etáveis e a doença se tornará endêmica. Se \\(R_t>1\\), ou seja, se cada indivíduo infeccioso causa, em média, mais do que uma nova infecção, então a doença se propagará na população e poderá haver uma epidemia."),
  tags$p("A seguir, apresentamos a estimação do número reprodutivo efetivo para a epidemia de Covid-19 no Brasil. A metodologia utilizada encontra-se descrita no", a("Relatório Técnico", href = "http://obsrpb.com.br/ufpb/wp-content/uploads/2020/07/Relatorio_COVID19_01_OBSRUFPB.pdf", noWS = "after"), "elaborado pelo", a("Observatório de Síndromes Respiratórias da UFPB", href = "http://obsrpb.com.br/ufpb/", noWS = "after"), ". Por padrão, o aplicativo mostra o gráfico para os dados do Brasil. O usuário pode especificar um estado ou um estado e um município para que seja feita a estimação."),
  # tags$p("Aplicativo desenvolvido pelo", tags$a("Observatório de Síndromes Respiratórias da UFPB", href = "http://obsrpb.com.br/ufpb/", .noWS = "after"), "."),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "uf", label = "Selecione o estado", choices = uf,
                  selected = "<Todos>"),
      selectInput(inputId = "municipio", label = "Selecione o município", choices = "",
                  selected = "<Todos>"),
      # withMathJax(),
      # p("O número reprodutivo basal ou razão de reprodução básica \\(R_0\\) indica o quão contagiosa uma doença infecciosa é. O número aponta quantas pessoas um indivíduo infeccioso pode contagiar em uma população totalmente suscetível. Apesar de ser muito útil para avaliar o potencial de propagação de doenças infecciosas em diferentes contextos, é uma medida teórica."),
      # p("No momento em que as doenças infecciosas se propagam e indivíduos que já foram infectados tornam-se resistentes, não pertencendo mais ao grupo de suscetíveis, a premissa de uma população totalmente suscetível passa a não ser mais uma boa aproximação da realidade e uma nova medida epidemiológica faz-se necessária."),
      # p("O número reprodutivo efetivo ou razão de reprodução efetiva \\(R_t\\) indica quantas pessoas um indivíduo infeccioso pode contagiar em uma população na qual nem todos são suscetíveis. Se \\(R_t<1\\), ou seja, se cada indivíduo infeccioso causa menos do que uma nova infecção, então os níveis de contágio da doença irão decair e a doença irá, eventualmente, desaparecer. Se \\(R_t=1\\), ou seja, se cada indivíduo infeccioso causa exatamente uma nova infecção, então os níveis de contágio da doença permanecerão etáveis e a doença se tornará endêmica. Se \\(R_t>1\\), ou seja, se cada indivíduo infeccioso causa mais do que uma nova infecção, então a doença se propagará na população e poderá haver uma epidemia."),
      p("Aplicativo desenvolvido pelo", a("Observatório de Síndromes Respiratórias da UFPB", href = "http://obsrpb.com.br/ufpb/", .noWS = "after"), ". Os dados utilizados foram obtidos do Repositório de Dados Públicos",
        a(href = "https://brasil.io", "Brasil.IO", .noWS = "after"), "."),
      p(a(img(src = "logo.png", height = "150px", style = "margin-top: 10px; margin-left: 20px"), href = "http://obsrpb.com.br/ufpb/"))
    ),
    mainPanel(
      plotlyOutput("plot1")
    )
  )
)

