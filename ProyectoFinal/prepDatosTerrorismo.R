install.packages("dplyr")

library(dplyr)

# Leyendo el conjunto de datos
archivoTerrorism <- file.choose() # Escogiendo el archivo "globalterrorismdb_0718dist.csv"
globalTerr <- read.csv(file = archivoTerrorism, header = T, stringsAsFactors = F)
globalTerr <- tibble::as_tibble(globalTerr)
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
globalTerr_imputados <- mice(globalTerr, method = "pmm", m = 5, maxit = 50, seed = 500)
globalTerr_imputados <- complete(globalTerr_imputados)
globalTerr_imputados <- tibble::as.tibble(globalTerr_imputados)
globalTerr_imputados
str(globalTerr_imputados)

# Colocando la moda de las otras variables
for (col in names(globalTerr_imputados)) {
  if (class(globalTerr[[col]]) == "character" && sum(is.na(globalTerr[[col]])) > 0) {
    globalTerr_imputados[[col]] <- factor(globalTerr_imputados[[col]])
    globalTerr_imputados[[col]] <- as.character(imputeMode(globalTerr_imputados[[col]]))
  }
}

globalTerr_inputados <- complete(globalTerr_imputados)
str(globalTerr_imputados)
globalTerr_imputados


# Eliminando valores atipicos
names(globalTerr_imputados)
attach(globalTerr_imputados)
table(nwound)

# Para identificar los valores atipicos
install.packages("ggplot2")
library(ggplot2)
boxplot(nwound, main = "Boxplot", ylab = "nwound")



# Discretizando valores numericos
install.packages("funModeling")
library(funModeling)


# Guardando los datos preprocesados
write.csv(globalTerr_imputados, file = "datosPrepTerrorismo.csv", row.names = FALSE)

