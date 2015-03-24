library("shiny")

#Define UI script

shinyUI(fluidPage(
  titlePanel(h2("Title Panel")),
  
  sidebarLayout(position="l",
  sidebarPanel(h3("Sidebar Panel")),
  
  mainPanel(
    h3("Text for Main Panel Heading", align="left"),
    br(),
    p("BRIC countries in charts are represented by country flag"),
    br(),
    p(img(src="Flag_Brazil.png", height=20, width="auto"), "- Brazil"),
    p(img(src="Flag_Russia.png", height=20, width="auto"), "- Russia"),
    p(img(src="Flag_India.png", height=20, width="auto"), "- India"),
    p(img(src="Flag_China.png", height=20, width="auto"), "- China")
    )
  
  ))
  )