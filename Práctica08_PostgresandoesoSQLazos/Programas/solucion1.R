# Cargar el conjunto de datos
vgsales <- read.csv("/Users/isra/Documents/AlmacenesYMineria/Almacenes-y-Mineria-de-Datos/Práctica08_PostgresandoesoSQLazos/Datasets/vgsales.csv")

# Hacemos un resumen de los datos
summary(vgsales)

# Vemos las primeras lineas del dataset
head(vgsales)

# ---- Limpieza de datos ----

# -- Valores faltantes --
# Obteniendo la suma de los valores faltantes en toda la columna de los datos de "vgsales": 
colSums(is.na(vgsales))

install.packages("mi")

library(mi)

# Generando el 30% de valores perdidos
vgsales.mis <- prodNA(vgsales, noNA = 0.3)
summary(vgsales.mis)

# Imputando los valores perdidos con el paquete mi
imputados_mi <- mi(vgsales.mis, seed = 335)
summary(imputados_mi)

datos_completos <- complete(imputados_mi, m = 2)

mice_plot <- aggr(datos_completos, col=c('navyblue','yellow'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(vgsales.mis), cex.axis=.6,cex.numbers=0.5,
                  gap=3, ylab=c("Datos perdidos","Patrón"))

image(imputados_mi)







