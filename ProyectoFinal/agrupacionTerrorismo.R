# ---------- Agrupacion ----------

# Instalando paquetes necesarios
install.packages("readxl")
install.packages("tribble")
install.packages("tidyverse")
install.packages("cluster")
install.packages("factoextra")

library(readxl)
library(tibble)
library(tidyverse)
library(cluster)
library(factoextra)

# Escogiendo el archivo "datosPrepTerrorismo.csv"
archivoTerrorism <- file.choose()
globalTerr <- read.csv(file = archivoTerrorism, header = T, stringsAsFactors = F)
globalTerr

# Convertiendo las variables categóricas en numéricas usando one-hot encoding
datos_cluster <- globalTerr[, c("iyear", "imonth", "iday", "nkill", "nwound")]
datos_categoricos <- globalTerr[, c("country_txt", "success", "suicide", "attacktype1_txt", "weaptype1_txt", "crit1", "crit2", "crit3")]
datos_categoricos <- model.matrix(~.-1, datos_categoricos)

# Combinando las variables numéricas y categóricas
datos_completos <- cbind(datos_cluster, datos_categoricos)

# Estandarizando los datos
globalTerr_estandarizado <- scale(datos_completos)
head(globalTerr_estandarizado)

# Obteniendo la 'k'
wcss <- numeric(length = 10) # suma de cuadrados intra-cluster
for (i in 1:10) {
  kmeans_model <- kmeans(globalTerr_estandarizado, centers = i)
  wcss[i] <- kmeans_model$tot.withinss
}

# Graficando el resultado del método del codo
plot(1:10, wcss, type = "b", main = "Método del Codo", xlab = "Número de Clusters (k)", ylab = "WCSS")

# Con el resultado anterior observamos que el mejor candidato es 5
# Aplicando k-medias
resultado <- kmeans(globalTerr_estandarizado, centers = 5)
resultado
str(resultado)

# Ploteamos los clusters
fviz_cluster(resultado, data = globalTerr_estandarizado)


# Centroides
resultado$centers
