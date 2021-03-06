source("global.R")

# Define UI for application that draws a histogram
tagList(
    useShinyjs(),
    navbarPage(
        id = "navbar",
        title =
            div(img(src = "logomark.png",
                    class = "logo"),
                "Cafe",
                class = "navbar-title"),
        theme = "custom.css",
        fluid = TRUE,
        windowTitle = "CAFE",
        collapsible = TRUE,
        header = tags$head(
            tags$style(HTML(
                "#page-nav > li:first-child { display: none; }"
            )),
            tags$link(rel = "stylesheet", type = "text/css", href = "https://fonts.googleapis.com/css?family=Chivo"),
            tags$link(rel = "stylesheet", type = "text/css", href = "AdminLTE.css"),
            tags$link(rel = "stylesheet", type = "text/css", href = "shinydashboard.css"),
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
            tags$link(rel = "icon", type = "image/png", href = "favicon.png"),
            tags$script(src = "https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js")
        ),
        home,
        navbarMenu(
           "participants",
           venn_ui("participants"),
           demographics_ui("participants")
        ),
        navbarMenu(
            "analysis",
            univar_ui("analysis"),
            concon_ui("analysis"),
            catcon_ui("analysis"),
            multivariate_ui("analysis"),
            multivariate_cor_ui("analysis"),
            tud_ui("analysis"),
            scales_ui("analysis"),
            esquisse_ui("esquisse")
        ),
        navbarMenu(
            "tables",
            preprocessed_table("tables"),
            summarised_table("tables"),
            chronicle_table("tables"),
            maq_table("tables"),
            linked_table("tables")
        ),
        codebook("documentation")
    )
)
