# Covid-19_Rt_Estimation

O número reprodutivo basal ou razão de reprodução básica R<sub>0</sub> indica o quão contagiosa uma doença infecciosa é. O número aponta quantas pessoas, em média, um indivíduo infeccioso pode contagiar em uma população totalmente suscetível. Apesar de ser muito útil para avaliar o potencial de propagação de doenças infecciosas em diferentes contextos, é uma medida teórica.

No momento em que as doenças infecciosas se propagam e indivíduos que já foram infectados tornam-se resistentes, não pertencendo mais ao grupo de suscetíveis, a premissa de uma população totalmente suscetível passa a não ser mais uma boa aproximação da realidade e uma nova medida epidemiológica faz-se necessária.

O número reprodutivo efetivo ou razão de reprodução efetiva R<sub>t</sub> indica quantas pessoas, em média, um indivíduo infeccioso pode contagiar em uma população na qual nem todos são suscetíveis. Se R<sub>t</sub> < 1, ou seja, se cada indivíduo infeccioso causa, em média, menos do que uma nova infecção, então os níveis de contágio da doença irão decair e a doença irá, eventualmente, desaparecer. Se R<sub>t</sub> = 1, ou seja, se cada indivíduo infeccioso causa, em média, exatamente uma nova infecção, então os níveis de contágio da doença permanecerão etáveis e a doença se tornará endêmica. Se R<sub>t</sub> > 1, ou seja, se cada indivíduo infeccioso causa, em média, mais do que uma nova infecção, então a doença se propagará na população e poderá haver uma epidemia.

Nesta aplicação Shiny, fornecemos estimativas do número reprodutivo efetivo para a epidemia de Covid-19 no Brasil. Por padrão, o aplicativo mostra o gráfico para os dados do Brasil. O usuário pode especificar um estado ou um estado e um município para que seja feita a estimação.
