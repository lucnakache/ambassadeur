# CONFIG
PARAM_needed_libraries=c("XML","dplyr","ggplot2","plotly","shiny","shinydashboard","reshape2","data.table")
PARAM_data_filename="oridiploxml.xml"

# BUILD PARAMETERS
PARAM_fun_folder=paste0(PARAM_main_folder,"fun/")
PARAM_data_folder=paste0(PARAM_main_folder,"data/")
PARAM_pathfile=paste0(PARAM_data_folder,PARAM_data_filename)
PARAM_fun_files = list.files(path =PARAM_fun_folder ,all.files =FALSE ,full.names = TRUE)

