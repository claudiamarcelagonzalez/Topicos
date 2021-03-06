#setwd("/Users/claudiamgonzalez/Documents/INV/PPID_H019_2016/Trabajo/R/Topics/biblioGIS/Tópicos")
# -seba: ojo con esta función setwd(), si yo la ejecuto hago un lío en mis directorios, una vez que-
#... usas la función setwd() bloqueala con un # (como hice arriba)..

########################################################################################################
# Aplicación de la técnica de agrupamiento k-means al corpus Scopus_CS_Argentina_xArgentinos_2010_2015 #
########################################################################################################

# Paquete bibliometrix https://cran.r-project.org/web/packages/bibliometrix/bibliometrix.pdf
library (bibliometrix)

# Convierto en Data.Frame el resultado de la búsqueda de Scopus
# Leo el archivo de entrada de Scopus en formato Bibtex y lo guardo en "largechar", tal como lo indica el ejemplo
# de la documentación
# Convierto el objeto recien generado en data.frame
# Hago uno global para todos los años
# largechar_2010_2015 <- readLines('TodosCampos_scopus_2010_2015.bib')
# scopus_df_2010_2015 <- scopus2df(largechar_2010_2015)

# A continuación convierto el data.frame en tipo tibble
# library(tidyverse)
# tibble_scopus_df_2010_2015 <- as_tibble(scopus_df_2010_2015) #cambió a tibble..

# Importo los datos
# *****************
# Levanto el csv que me envia Sebastian 01/12/2017. Se supone que es mi data.frame en formato tibble. Lo hacemos
# para asegurarnos que los dos trabajamos sobre los mismos datos.

#Importación de Claudia:
library(tidyverse)  #esto carga el paquete readr entre otros
dataset1 <- read_csv(("~/Documents/INV/DATOS/Repositorios-RG/2017_12_30/datasetSebastian.csv"), guess_max = 10000)
#debería funcionar. No sé por qué tenés el "~/ en el path, eso es por la Mac?, una forma segura de
#...encontrar el path es clickear arriba a la derecha en "Import Dataset", buscar el archivo y luego en vez de
#...importar, te copias la sentencia que aparece abajo a la derecha. A ese path le agregas: , guess_max = 10000)


#Importación de Sebastian:
library(tidyverse)
dataset1 <- read_csv(("C:/Users/User/Desktop/Seba/Datasets enraizados. No tocar ni mover/dataset.csv"), guess_max = 10000)

# Genero una stop-word en inglés (y por lo visto en castellano...)
custom_stopEN <- read.csv("stop-word-list-en-sp.csv",header = FALSE, encoding="UTF-8")

# Extraigo el campo resumen y elimino los faltantes 
AB_dataset1 <- as.data.frame(dataset1$AB) #selecciona la variable AB
AB_dataset1_sinNA <- as.data.frame(na.omit(AB_dataset1)) #elimina los NA (missing), baja el n a 3153
colnames(AB_dataset1_sinNA)[1] <- "AB"  #cambia el nombre la variable

# Genero una nueva variable en el data.frame con solo los términos del resumen sin stemming
# *****************************************************************************************
# Utilizo la funcion termExtraction de bibliometrix aplicando stopword, sin stemming
# Genera una nueva data.frame igual a la entrada pero con una nueva variable que contiene las palabras del
# abstracts separadas con ; como unigramas. La variable se llama AB_TM. 
AB_TM_dataset1_stop_sinStem <- termExtraction(AB_dataset1_sinNA, Field = "AB", stemming = FALSE, language = "english", remove.numbers = TRUE, remove.terms = custom_stopEN$V1, verbose = TRUE)

# Reemplazo  el separador ; por espacio con una expresión regular
# ***************************************************************
AB_TM_dataset1_stop_sinStem_sinPunto <- data.frame(lapply(AB_TM_dataset1_stop_sinStem, function(x) {gsub("[;]"," ", x)}))

# Renombro la columna AB_TM
# *************************
# Esto debo hacerlo porque de otra forma la funcion conceptualStructure del paquete bibliometrix, que utilizo
# para hacer el clustering, no funciona
colnames(AB_TM_dataset1_stop_sinStem_sinPunto)[2] <- "AB"
colnames(AB_TM_dataset1_stop_sinStem_sinPunto, do.NULL = TRUE, prefix = "col")

# Genero los clusters
# *******************
# El número máximo de clusters que acepta la función es 8: k.max, pongo el máximo. El minDegree es la frecuencia mínima: pruebo opciones.
SinStemmAB100_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=100, k.max = 8, labelsize=4)
SinStemmAB75_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=75, k.max = 8, labelsize=4)
SinStemmAB50_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=50, k.max = 8, labelsize=4)
SinStemmAB30_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=30, k.max = 8, labelsize=4)
SinStemmAB25_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=25, k.max = 8, labelsize=4)
SinStemmAB20_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=20, k.max = 8, labelsize=4)
SinStemmAB15_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=15, k.max = 8, labelsize=4)
SinStemmAB10_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=10, k.max = 8, labelsize=4)
SinStemmAB8_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=8, k.max = 8, labelsize=4)
SinStemmAB5_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=5, k.max = 8, labelsize=4)
SinStemmAB2_8 <- conceptualStructure(AB_TM_dataset1_stop_sinStem_sinPunto, field="AB", stemming=FALSE, minDegree=2, k.max = 8, labelsize=4)
