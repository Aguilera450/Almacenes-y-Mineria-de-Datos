install.packages("dplyr")

library(dplyr)

# Leyendo el conjunto de datos
archivoTerrorism <- file.choose() # Escogiendo el archivo "globalterrorismdb_0718dist.csv"
globalTerr <- read.csv(file = archivoTerrorism, header = T, stringsAsFactors = F)
globalTerr <- tibble::as.tibble(globalTerr)
globalTerr


# Seleccionando las variables escogidas
variables_conservadas <- c("iyear", "imonth", "iday", "country_txt", "success", "suicide", 
                           "attacktype1_txt", "weaptype1_txt", "nkill", "nwound", "nperps", 
                           "crit1", "crit2", "crit3")
globalTerr <- globalTerr %>% select(variables_conservadas)     
globalTerr
str(globalTerr)

# Imputando los datos
install.packages("mice")
library(mice)
# Colcando la media o mediana en las variables numericas
globalTerr_inputados <- mice(globalTerr, method = "pmm", m = 5, seed = 500)
globalTerr_inputados <- complete(globalTerr_inputados)
str(globalTerr_inputados)
globalTerr_inputados

# Colocando la moda de las otras variables
for (col in names(globalTerr_inputados)) {
  if (class(globalTerr[[col]]) == "character" && sum(is.na(globalTerr[[col]])) > 0) {
    globalTerr_inputados[[col]] <- factor(globalTerr_inputados[[col]])
    globalTerr_inputados[[col]] <- as.character(imputeMode(globalTerr_inputados[[col]]))
  }
}

globalTerr_inputados <- complete(globalTerr_inputados)
str(globalTerr_inputados)
globalTerr_inputados

# Eliminando valores atipicos
names(globalTerr_inputados)
attach(globalTerr_inputados)
table(country_txt)



# Discretizando valores numericos
install.packages("funModeling")
library(funModeling)


# Guardando los datos preprocesados
write.csv(globalTerr_inputados, file = "datosPrepTerrorismo.csv", row.names = FALSE)

