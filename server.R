library(shiny)
library(tidyverse)
library(cowplot)


function(input, output, session) {
  plot_list <- reactive({
    readRDS('top_plots.RDS')
  })
  output$metabolites <- renderUI({
    plot_names = names(plot_list())
    print(plot_names)
    selectizeInput(inputId = 'met', label = 'Select metabolite',
                choices = plot_names, multiple = TRUE,
                options = list(maxItems = 4),
                selected = plot_names[1:4])
  })

    output$boxPlot <- renderPlot({
      req(input$met)
      ln = length(input$met)
      # The palette with grey:
      cbPalette <- c("#E69F00", "#56B4E9", "#009E73",
                              "#F0E442", "#0072B2", 
                              "#D55E00", "#CC79A7", "#999999")
                              
    if(ln >2){
      x = c(0,.45, 0, .45)
      
      fig_comb <- ggdraw() +
        draw_plot(plot_list()[[input$met[1]]]+
                    scale_fill_manual(values = cbPalette[1:5])+
                    scale_x_discrete(labels=c("G7 (n=6)", "G11 (n=7)",
                                              "G9 (n=5)","G8 (n=6)",
                                              "G10 (n=6)"))+
                    theme(
                      axis.title.x = element_text(size = input$xtitle),
                      axis.text.x = element_text(size = input$xlab),
                      axis.title.y = element_text(size = input$ytitle),
                      axis.text.y = element_text(size = input$ylab)),
                  x = 0, y = 0.5, width = .35, height = .45)+
        draw_plot(plot_list()[[input$met[2]]]+
                    scale_fill_manual(values = cbPalette[1:5])+
                    scale_x_discrete(labels=c("G7 (n=6)", "G11 (n=7)",
                                              "G9 (n=5)","G8 (n=6)",
                                              "G10 (n=6)"))+
                    theme(
                      axis.title.x = element_text(size = input$xtitle),
                      axis.text.x = element_text(size = input$xlab),
                      axis.title.y = element_text(size = input$ytitle),
                      axis.text.y = element_text(size = input$ylab)),
                  x = 0.45, y = 0.5, width = .35, height = .45)
      for(i in 3:4){
        fig_comb <- fig_comb+
          draw_plot(plot_list()[[input$met[i]]]+
                      scale_fill_manual(values = cbPalette[1:5])+
                      scale_x_discrete(labels=c("G7 (n=6)", "G11 (n=7)",
                                                "G9 (n=5)","G8 (n=6)",
                                                "G10 (n=6)"))+
                      theme(
                        axis.title.x = element_text(size = input$xtitle),
                        axis.text.x = element_text(size = input$xlab),
                        axis.title.y = element_text(size = input$ytitle),
                        axis.text.y = element_text(size = input$ylab)),
                    x = x[i], y = 0, width = .35, height = .45)
        
        
    }
    }else{
        if(length(input$met)==1){
          fig_comb <- ggdraw() +
            draw_plot(plot_list()[[input$met[1]]]+
                        scale_fill_manual(values = cbPalette[1:5])+
                        scale_x_discrete(labels=c("G7 (n=6)", "G11 (n=7)",
                                                  "G9 (n=5)","G8 (n=6)",
                                                  "G10 (n=6)"))+
                        theme(
                          axis.title.x = element_text(size = input$xtitle),
                          axis.text.x = element_text(size = input$xlab),
                          axis.title.y = element_text(size = input$ytitle),
                          axis.text.y = element_text(size = input$ylab)),
                      x = 0, y = 0, width = 1, height = 1)
        }else{
          fig_comb <- ggdraw() +
            draw_plot(plot_list()[[input$met[1]]]+
                        scale_fill_manual(values = cbPalette[1:5])+
                        scale_x_discrete(labels=c("G7 (n=6)", "G11 (n=7)",
                                                  "G9 (n=5)","G8 (n=6)",
                                                  "G10 (n=6)"))+
                        theme(
                          axis.title.x = element_text(size = input$xtitle),
                          axis.text.x = element_text(size = input$xlab),
                          axis.title.y = element_text(size = input$ytitle),
                          axis.text.y = element_text(size = input$ylab)),
                      x = 0, y = 0, width = .35, height = 1)+
            draw_plot(plot_list()[[input$met[2]]]+
                        scale_fill_manual(values = cbPalette[1:5])+
                        scale_x_discrete(labels=c("G7 (n=6)", "G11 (n=7)",
                                                  "G9 (n=5)","G8 (n=6)",
                                                  "G10 (n=6)"))+
                        theme(
                          axis.title.x = element_text(size = input$xtitle),
                          axis.text.x = element_text(size = input$xlab),
                          axis.title.y = element_text(size = input$ytitle),
                          axis.text.y = element_text(size = input$ylab)),
                      x = 0.5, y = 00, width = .35, height = 1)
        }
      }
      fig_comb
      
    })

}
