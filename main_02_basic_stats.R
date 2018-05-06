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

# Import du df construit
df=readRDS(file = paste0(PARAM_data_folder,"df.RDS"))


# ON PEUT COMMENCER A TRAVAILLER! *** ON PEUT COMMENCER A TRAVAILLER! *** 
# ON PEUT COMMENCER A TRAVAILLER! *** ON PEUT COMMENCER A TRAVAILLER! *** 
# ON PEUT COMMENCER A TRAVAILLER! *** ON PEUT COMMENCER A TRAVAILLER! *** 

# Comptage du nombre de paragraphes par AUTEUR x TYPE
basic_stats=df %>% 
  group_by(exp,.attrs) %>% 
  summarise (freq = n()) %>% 
  mutate(number_of_paragraphes = sum(freq))

# Calcul des probabilités
basic_stats$p = round(basic_stats$freq / basic_stats$number_of_paragraphes,2)

# Factor to character
basic_stats$.attrs=as.character(basic_stats$.attrs)
basic_stats$exp=as.character(basic_stats$exp)

# Ajout des type à 0
all_types=unique(basic_stats$.attrs)
all_authors=unique(basic_stats$exp)
column_author=rep(all_authors,each=length(all_types))
column_types=rep(all_types,length(all_authors))
dummy_df=data.frame("author"=column_author,"type"=column_types,"dummy"="check",stringsAsFactors = FALSE)
basic_stats=merge(x =dummy_df,
      y=basic_stats,
      all.x=TRUE,
      by.x=c("author","type"),
      by.y=c("exp",".attrs"))
basic_stats[is.na(basic_stats)] = 0

# Add position of cells, matrix plot
n_authors=length(unique(basic_stats$author))
n_types=length(unique(basic_stats$type))
basic_stats$y=rep(seq(1,n_authors),each=n_types)
basic_stats$x=rep(seq(1,n_types),n_authors)
rbPal <- colorRampPalette(c('grey','red'))
basic_stats$color=rbPal(10)[as.numeric(cut(basic_stats$p,breaks = 10))]


# Sauvegarde de basic_stats
saveRDS(object = basic_stats,
        file = paste0(PARAM_data_folder,"basic_stats.RDS"))


# Sauvegarde de basic_stats_t
basic_stats$info=paste(basic_stats$freq," (",basic_stats$p*100,"%)")
basic_stats_t=dcast(basic_stats[,c("author","type","info")], author ~ type)
saveRDS(object = basic_stats_t,
        file = paste0(PARAM_data_folder,"basic_stats_t.RDS"))



# Vizualization
temp_df=basic_stats[basic_stats$author == "DOTEZAC" | basic_stats$author == "GRAMONT",]
temp_df$p[temp_df$author==unique(temp_df$author)[2]] = -1 * temp_df$p[temp_df$author==unique(temp_df$author)[2]]

g1 <- ggplot(temp_df,
             aes(x = as.factor(type), y = p, fill=author)) + 
  geom_bar(data=temp_df[temp_df$author == "DOTEZAC",] ,stat = "identity") + 
  geom_bar( data=temp_df[temp_df$author == "GRAMONT",] ,stat = "identity") +
  coord_flip() + 
  scale_y_continuous(breaks = seq(-1, 1, 0.25), 
                     labels = paste0(abs(seq(-1, 1, 0.25)))) + 
  xlab("") +
  ggtitle (label = "Difference de styles entre ambassadeurs",subtitle = "")+
  theme_bw() + 
  theme(legend.position="bottom", legend.title = element_blank())


g1



a=runif(10, min = 0, max = 1)
b=runif(10, min = -1, max = 0)
df=data.frame("p"=c(a,b),
           "g"=rep(c("a","b"),each=10),
           "type"=c(letters[1:10],letters[1:10]))


g <- ggplot(df,
             aes(x = as.factor(type), y = p, fill=g)) +
  geom_bar(data=df[df$g == "a",] ,stat = "identity") +
  geom_bar( data=df[df$g == "b",] ,stat = "identity") +
  coord_flip() +
  scale_y_continuous(breaks = seq(-1, 1, 0.25),
                     labels = paste0(abs(seq(-1, 1, 0.25)))) +
  xlab("") +
  theme_bw()

g

ggplotly(g)



g <- df %>%
  ggplot(aes(x = type, y = p, fill = g)) +
  geom_col() +
  coord_flip()
g
ggplotly(g)













p <- ggplot(basic_stats, aes(x,y,text=paste0("Ambassadeur : ",author,
                                             "<BR>Type : ",type,
                                             "<BR>p : ",p)))
p = p + geom_point(colour = basic_stats$color, size=16, shape=15) + 
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

p
ggplotly(p,tooltip = "text")
