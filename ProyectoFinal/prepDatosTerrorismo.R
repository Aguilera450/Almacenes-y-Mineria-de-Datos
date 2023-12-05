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

# Imputando los datos
install.packages("mice")
library(mice)
globalTerr_inputados <- mice(globalTerr, method = "pmm", m = 5)
globalTerr_inputados <- complete(globalTerr_inputados)
str(globalTerr_inputados)

# Eliminando valores atipicos


# Discretizando variables numericas
install.packages("funModeling")
library(funModeling)

