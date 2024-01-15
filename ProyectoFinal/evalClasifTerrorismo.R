install.packages("caret")
install.packages('caTools')
library(caTools)

archivoTerrorism <- file.choose() # Escogiendo el archivo "datosPrepTerrorismo.csv"
globalTerr <- read.csv(file = archivoTerrorism, header = T, stringsAsFactors = F)


sample_data <- sample.split(globalTerr, SplitRatio = 0.8)
train_data <- subset(globalTerr, sample_data == TRUE)
test_data <- subset(globalTerr, sample_data == FALSE)

install.packages("rpart")
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

# Para el exito de los ataques

arbolSuccess <- rpart(
  country_txt ~ .,
  data = train_data,
  method = "class",
  control = rpart.control(
    minsplit = 5,   # Número mínimo de observaciones requeridas para dividir un nodo (ajustado a 10)
    minbucket = 2,   # Número mínimo de observaciones en una hoja (ajustado a 5)
    cp = 0.0025       # Complejidad del árbol, parámetro de poda (ajustado a 0.005)
  )
)

# Hacer predicciones en el conjunto de prueba
predicciones <- predict(arbolSuccess, newdata = test_data, type = "class")

# Comparar las predicciones con los valores reales
matriz_confusion <- table(test_data$country_txt, predicciones)
