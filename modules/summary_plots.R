###################
## UI COMPONENTS ##
###################

summarised_histograms <- function(id) {
    ns <- NS(id)
    tabPanel("TUD histograms",
             fluidRow(column(
                 width = 4,
                 box(width = 12,
                     title = "Select column",
                     uiOutput(ns("hist_column")))
             ),
             column(
                 width = 8,
                 box(
                     width = 12,
                     solidHeader = TRUE,
                     title = "Histogram",
                     addSpinner(
                         plotOutput(outputId = ns("histogram")),
                         spin = "bounce",
                         color = cols[1]
                     )
                 ),
                 box(
                     width = 12,
                     solidHeader = FALSE,
                     downloadButton(ns("histogram_download"), "Download figure"),
                     align = "left"
                 )
             )))
}

summarised_crossplots <- function(id) {
    ns <- NS(id)
    tabPanel("TUD crossplots",
             fluidRow(column(
                 width = 4,
                 box(
                     width = 12,
                     solidHeader = TRUE,
                     title = "Select column",
                     uiOutput(ns("cross_columns"))
                 )
             ),
             column(
                 width = 8,
                 box(
                     width = 12,
                     solidHeader = TRUE,
                     title = "Cross-plot",
                     addSpinner(plotOutput(ns("crossplot")), spin = "bounce", color = cols[1])
                 ),
                 box(
                     width = 12,
                     solidHeader = FALSE,
                     downloadButton(ns("crossplot_download"), "Download figure"),
                     align = "left"
                 )
             )))
    
}

#######################
## SERVER COMPONENTS ##
#######################

summary_plots <-
    function(input,
             output,
             session,
             rawdata) {
        ns <- session$ns

        output$hist_column <- renderUI(
            radioButtons(
                inputId = ns('histcol'),
                choices = rawdata$tud$summarised_coltypes$numeric[rawdata$tud$summarised_coltypes$numeric != "nc.SubjectIdentification"],
                label = 'Column'
            )
        )
        
        output$histogram <-
            renderPlot({
                plot_summary_histogram(rawdata$tud$summarised, input$histcol)
            })
        
        output$histogram_download <-
            downloadHandler(
                filename = "histogram.png",
                content = function(file) {
                    ggsave(
                        file,
                        plot_summary_histogram(rawdata$tud$summarised, input$histcol),
                        width = 8,
                        height = 5
                    )
                }
            )
        
        output$cross_columns <- renderUI(checkboxGroupInput(
            ns("crosscol"),
            "Choose columns:",
            choices = c(
                rawdata$tud$summarised_coltypes$numeric,
                rawdata$tud$summarised_coltypes$factorial[rawdata$tud$summarised_coltypes$factorial != "nc.SubjectIdentification"],
                rawdata$tud$summarised_coltypes$boolean
            )
        ))

        output$crossplot <-
            renderPlot({
                plot_crossplot(rawdata$tud$summarised, input$crosscol)
            })
        
        output$crossplot_download <-
            downloadHandler(
                filename = "crossplot.png",
                content = function(file) {
                    ggsave(
                        file,
                        plot_crossplot(rawdata$tud$summarised, input$crosscol),
                        width = 8,
                        height = 5
                    )
                }
            )
        
    }