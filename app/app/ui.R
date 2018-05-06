# ui

source("packages.R")
source("config.R")


ui <- dashboardPage(
  dashboardHeader(title = "Ambassadeurs"),
  dashboardSidebar(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css")
    ),
    sidebarMenu(
      menuItem("Comparaison", tabName = "onglet_1", icon = icon("text-color",lib = "glyphicon")),
      menuItem("Matrice", tabName = "onglet_2", icon = icon("th",lib = "glyphicon")),
      menuItem("Statistics", tabName = "onglet_3", icon = icon("barcode",lib = "glyphicon"))
    )
  ),
  dashboardBody(
    tags$style(HTML("
                    
                    
                    .box.box-solid.box-primary>.box-header {
                    color:#fff;
                    background:#195EA0
                    }
                    
                    .box.box-solid.box-primary{
                    border-bottom-color:#195EA0;
                    border-left-color:#195EA0;
                    border-right-color:#195EA0;
                    border-top-color:#195EA0;
                    }
                    
                    ")),
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"
    ),
    
    
    
    
    tabItems(
      
      
      
      
      
      # 1er onglet
      tabItem(
        tabName = "onglet_1",
        
        fluidRow(
          box(title = "Comparez deux ambassadeurs",
              width = 3,
              status = "primary",
              solidHeader =TRUE ,
              collapsible = TRUE,
              collapsed =FALSE ,
              selectInput(
                inputId="choix_1",
                label = "Ambassadeur 1",
                choices=auteurs_list,
                selected = NULL,
                selectize = TRUE),
              selectInput(
                inputId="choix_2",
                label = "Ambassadeur 2",
                choices=auteurs_list,
                selected = NULL,
                selectize = TRUE)
              ),
          box(title = "Comparaison de style",
              status ="primary" ,
              solidHeader =TRUE ,
              width = 9,
              collapsible =TRUE,
              collapsed = FALSE,
              plotOutput("plot_comparaison"))
        )
        
      ), # fin du premier onglet
     
      tabItem(
        tabName = "onglet_2",
        
        fluidRow(
          box(title = "Matrice des profils ambassadeurs",
              status ="primary" ,
              solidHeader =TRUE ,
              width = 12,
              collapsible =TRUE,
              collapsed = FALSE,
              plotlyOutput("plot_matrix_profil"))
        )
        
      ),
      
      tabItem(
        tabName = "onglet_3",
        
        fluidRow(
          box(title = "Statistics Tab",
              status ="primary" ,
              solidHeader =TRUE ,
              width = 12,
              collapsible =TRUE,
              collapsed = FALSE,
              dataTableOutput("stats_table"))
        )
        
      ) 
      
      
      
      )
    )
)


