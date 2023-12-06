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

globalTerr_imputados <- complete(globalTerr_imputados)
str(globalTerr_imputados)
globalTerr_imputados


# Eliminando valores atipicos ====================================

# Función para eliminar valores atípicos en columnas numéricas
limpiar_numerico <- function(columna_numeric) {
  Q1 <- quantile(columna_numeric, 0.25)
  Q3 <- quantile(columna_numeric, 0.75)
  IQR_value <- Q3 - Q1
  
  umbral_inferior <- Q1 - 1.5 * IQR_value
  umbral_superior <- Q3 + 1.5 * IQR_value
  
  return(between(columna_numeric, umbral_inferior, umbral_superior))
}

# Filtrar valores atípicos en columnas numéricas
globalTerrSinAtipicos <- globalTerr_imputados %>%
  filter(limpiar_numerico(iyear),
         limpiar_numerico(imonth),
         limpiar_numerico(iday),
         limpiar_numerico(success),
         limpiar_numerico(suicide),
         limpiar_numerico(nkill),
         limpiar_numerico(nwound),
         limpiar_numerico(nperps),
         limpiar_numerico(crit1),
         limpiar_numerico(crit2),
         limpiar_numerico(crit3)
         )

# Filtrar filas sin valores nulos en columnas de cadenas
globalTerrSinAtipicos <- globalTerrSinAtipicos %>%
  filter(!is.na(country_txt),
         !is.na(attacktype1_txt),
         !is.na(weaptype1_txt)
         )

# Filtrar filas de meses y dias 0 
globalTerrSinAtipicos <- globalTerrSinAtipicos %>%
  filter(iday != 0,
         imonth != 0
  )

# Visualizar el tibble resultante
print(globalTerrSinAtipicos )

summary(globalTerr_imputados)
summary(globalTerrSinAtipicos)

# Discretizando atributos numericos ========================

cortesIyear <- c(1969,1979,1989,1999,2009,2019)
cortesImonth <- c(0,2,4,6,8,10,12)
cortesIDay <- c(0,10,20,31)
cortesNperps <- c(-100,0,1,max(globalTerrSinAtipicos$nperps))

globalTerrDiscretizado <- globalTerrSinAtipicos %>%
  mutate(
    iyearDis = cut(iyear, breaks = cortesIyear, labels = c("70s", "80s", "90s", "00s", "10s")),
    imonthDis = cut(imonth, breaks = cortesImonth, labels = c("1er", "2do", "3er", "4to", "5to", "6to")),
    idayDis = cut(iday, breaks = cortesIDay, labels = c("1er tercio", "2do tercio", "3er tercio")),
    successDis = ifelse(nwound == 1, "Exitoso","Fallido"),
    suicideDis = ifelse(nwound == 1, "Suicida","No suicida"),
    nkillDis = ifelse(nwound == 1, "Con decesos","Sin decesos"),
    nwoundDis = ifelse(nwound == 1, "Con heridos","Sin heridos"),
    nperpsDis = cut(nperps, breaks = cortesNperps, labels = c("Desconocido", "Independiente", "Grupal")),
    crit1Dis = ifelse(nwound == 1, "Si","No"),
    crit2Dis = ifelse(nwound == 1, "Si","No"),
    crit3Dis = ifelse(nwound == 1, "Si","No")
  )

globalTerrDiscretizado <- globalTerrDiscretizado %>%
  select(-one_of(c("iyear", "imonth", "iday", "success", "suicide", "nkill", "nwound", "nperps", 
                   "crit1", "crit2", "crit3")))

print(globalTerrDiscretizado)
# Guardando los datos preprocesados
write.csv(globalTerr_imputados, file = "datosPrepTerrorismo.csv", row.names = FALSE)
