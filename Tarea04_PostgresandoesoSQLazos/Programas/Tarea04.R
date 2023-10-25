# Tarea 4 PostgresandoesoSQLazos

# Establecemos el directorio donde vamos a trabajar
setwd("/home/vengarl/Documentos/R/")

# Carggamos los datos del csv descargado
datos <- read.csv("6ClassCsv.csv")

# Hacemos un resumen de los datos para ver las variables categoricas
str(datos)
sapply(datos, class)
head(datos)
# Guardamos las 2 variables categoricas como factores

datos$Star.color <- as.factor(datos$Star.color)
datos$Spectral.Class <- as.factor(datos$Spectral.Class)

# Hacemos un resumen de los datos
summary(datos)
print(datos)

# Histogramas
# Temperatura K
hist(datos$Temperature..K., 
     main = "Histograma de Temperatura",
     xlab = "Valores",
     ylab = "Frecuencia",
     col = "blue",
     border = "black")

boxplot(datos$Temperature..K.,
        main = "Boxplot de Temperatura",
        xlab = "Valores",
        col = "green")
# Luminocidad
hist(datos$Luminosity.L.Lo., 
     main = "Histograma de Luminocidad",
     xlab = "Valores",
     ylab = "Frecuencia",
     col = "blue",
     border = "black")

boxplot(datos$Luminosity.L.Lo.,
        main = "Boxplot de Luminocidad",
        xlab = "Valores",
        col = "green")
# Radio
hist(datos$Radius.R.Ro., 
     main = "Histograma de Radio",
     xlab = "Valores",
     ylab = "Frecuencia",
     col = "blue",
     border = "black")

boxplot(datos$Radius.R.Ro.,
        main = "Boxplot de Radio",
        xlab = "Valores",
        col = "green")
# Magnitud Absoluta
hist(datos$Absolute.magnitude.Mv., 
     main = "Histograma de Magnitud Absoluta",
     xlab = "Valores",
     ylab = "Frecuencia",
     col = "blue",
     border = "black")

boxplot(datos$Absolute.magnitude.Mv.,
        main = "Boxplot de Magnitud Absoluta",
        xlab = "Valores",
        col = "green")
# Tipo de estrella
hist(datos$Star.type, 
     main = "Histograma de Tipo de estrella",
     xlab = "Valores",
     ylab = "Frecuencia",
     col = "blue",
     border = "black")

boxplot(datos$Star.type,
        main = "Boxplot de Tipo de estrella",
        xlab = "Valores",
        col = "green")

# Grafica de Barras de las varibale Spectral.Class
# barplot(table(datos$Spectral.Class))

# install.packages("ggplot2") # Si no se tiene instalada
library("ggplot2")
ggplot(datos, aes(x = datos$Spectral.Class)) + geom_bar()

# Graficar diagrama de dispersion sin las variables categoricas
# install.packages("car") # Si no se tiene instalada
library("car")
pairs(datos[, 1:(ncol(datos) - 2)])

# Graficar la correlacion entre las variables numericas
# install.packages("car") # Si no se tiene instalada
library("corrplot")
matriz_correlacion <- cor(datos[, 1:(ncol(datos) - 2)])
corrplot(matriz_correlacion)
