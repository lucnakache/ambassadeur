# server

shinyServer(function(input, output, session) {
  

  
  output$plot_comparaison <- renderPlot({
    temp_df=basic_stats[basic_stats$author == input$choix_1 | basic_stats$author == input$choix_2,]
    temp_df$p[temp_df$author==unique(temp_df$author)[2]] = -1 * temp_df$p[temp_df$author==unique(temp_df$author)[2]]
    
    g1 <- ggplot(temp_df,
                 aes(x = as.factor(type), y = p, fill=author)) + 
      geom_bar(data=temp_df[temp_df$author == input$choix_1,] ,stat = "identity") + 
      geom_bar( data=temp_df[temp_df$author == input$choix_2,] ,stat = "identity") +
      coord_flip() + 
      scale_y_continuous(breaks = seq(-1, 1, 0.25), 
                         labels = paste0(abs(seq(-1, 1, 0.25)))) + 
      xlab("") +
      ggtitle (label = "Difference de styles entre ambassadeurs",subtitle = "")+
      theme_bw() +
      theme(legend.position="bottom", legend.title = element_blank())
    
    
    g1
    
  })
  
  
  output$plot_matrix_profil <- renderPlotly({
    p <- ggplot(basic_stats, aes(x,y,text=paste0("Ambassadeur : ",author,
                                                 "<BR>Type : ",type,
                                                 "<BR>p : ",p)))
    p = p + geom_point(colour = basic_stats$color, size=20, shape=15) + 
      theme(axis.line=element_blank(),axis.text.x=element_blank(),
            axis.text.y=element_blank(),axis.ticks=element_blank(),
            axis.title.x=element_blank(),
            axis.title.y=element_blank())+
      ggtitle(label="",
              subtitle  = "Représentation matricielle du style des ambassadeurs")+
      theme_bw() +
      scale_x_discrete(limits=unique(basic_stats$type)) +
      scale_y_discrete(limits=unique(basic_stats$author)) +
      ylab("")+
      xlab("") + 
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank())
    
    ggplotly(p,tooltip = "text")


    
  })
  
  
  
  
  
  output$stats_table <- renderDataTable(basic_stats_t2)
  
})