# Clear la work et la console
rm(list=ls())
cat("\014")

# CHARGEMENT DES PARAMETRES ET DES FONCTIONS *** CHARGEMENT DES PARAMETRES ET DES FONCTIONS *** 
# CHARGEMENT DES PARAMETRES ET DES FONCTIONS *** CHARGEMENT DES PARAMETRES ET DES FONCTIONS *** 
# CHARGEMENT DES PARAMETRES ET DES FONCTIONS *** CHARGEMENT DES PARAMETRES ET DES FONCTIONS *** 

# Localisation du script main & pathfile de config
PARAM_main_folder=paste0(dirname(rstudioapi::getSourceEditorContext()$path),"/")
PARAM_config_pathfile=paste0(PARAM_main_folder,"config.R")

# Chargement du fichier config.R
source(PARAM_config_pathfile,encoding = "UTF-8")

# Chargement des fonctions du dossier fun
invisible(lapply(X = PARAM_fun_files ,FUN = function(x)  source(file =x ,encoding = "UTF-8")))

# Importation des librairies
FUN_install_and_load_packages(needed_libraries = PARAM_needed_libraries)



# ON PEUT COMMENCER A TRAVAILLER! *** ON PEUT COMMENCER A TRAVAILLER! *** 
# ON PEUT COMMENCER A TRAVAILLER! *** ON PEUT COMMENCER A TRAVAILLER! *** 
# ON PEUT COMMENCER A TRAVAILLER! *** ON PEUT COMMENCER A TRAVAILLER! *** 

# Conversion du fichier xml en R xml document
data <- xmlParse(PARAM_pathfile)

# Conversion du R xml document en R list
xml_data <- xmlToList(data)

# Conversion de la liste R en Dataframe
df=do.call(rbind,lapply(X = xml_data,FUN =FUN_get_matrix ))
row.names(df)=NULL

# Sauvegarde du dataframe
saveRDS(object =df ,file =paste0(PARAM_data_folder,"df.RDS") )




