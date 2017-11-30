#setwd("/Users/claudiamgonzalez/Documents/INV/PPID_H019_2016/Trabajo/R/Topics/biblioGIS/")

#seba: ojo con esta función setwd(), si yo la ejecuto hago un lío en mis directorios, una vez que-
#... usas la función setwd() bloqueala con un # (como hice arriba)


# Paquete bibliometrix https://cran.r-project.org/web/packages/bibliometrix/bibliometrix.pdf
library (bibliometrix)

# Convierto en Data.Frame el resultado de la búsqueda de Scopus
# Leo el archivo de entrada de Scopus en formato Bibtex y lo guardo en "largechar", tal como lo indica el ejemplo
# de la documentación
# Convierto el objeto recien generado en data.frame
# Hago uno global para todos los años
largechar_2010_2015 <- readLines('TodosCampos_scopus_2010_2015.bib')
scopus_df_2010_2015 <- scopus2df(largechar_2010_2015)

#Seba: si el archivo "TodosCampos_scopus_2010_2015.bib" no está en github, yo no puedo- 
#... aceder a él, y no puedo hacer la transformación. Pongo el código abajo para que-
#... lo hagas vos:

# Convierto el data.frame en tipo tibble
library(tidyverse)
tibble_scopus_df_2010_2015 <- as_tibble(scopus_df_2010_2015) #cambió a tibble..

#Seba: si tibble_scopus_df_2010_2015 sigue sin subir el archivo a github por su tamaño, acá va codigo-
#...para extraer una muestra para trabajar, y luego al final aplicamos las sentencias-
#... sobre el archivo completo. El resultado será aproximadamente igual:

#Muestra de la data.frame "scopus_df_2010_2015":

# muestra_scopus_df_2010_2015 <- scopus_df_2010_2015[sample(1:nrow(poblacion), 3000 , replace=FALSE),]

#Seba: eso sube seguro al github...

# Genero una stopword en Inglés-Español
custom_stopEN_ES <- read.csv("stop-word-list-en-sp.csv",header = FALSE, encoding="UTF-8")
remove.terms <- as.character(custom_stopEN_ES)
