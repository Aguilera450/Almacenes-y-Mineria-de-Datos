# -------------- Arbol de decision CART --------------
archivoTerrorism <- file.choose() # Escogiendo el archivo "datosPrepTerrorismo.csv"
globalTerr <- read.csv(file = archivoTerrorism, header = T, stringsAsFactors = F)
globalTerr
names(globalTerr)
attach(globalTerr)

install.packages("rpart")
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

# Para el exito de los ataques

arbolSuccess <- rpart(
  country_txt ~ .,
  data = globalTerr,
  method = "class",
  control = rpart.control(
    minsplit = 5,   # Número mínimo de observaciones requeridas para dividir un nodo (ajustado a 10)
    minbucket = 2,   # Número mínimo de observaciones en una hoja (ajustado a 5)
    cp = 0.0025       # Complejidad del árbol, parámetro de poda (ajustado a 0.005)
  )
)
prp(arbolSuccess)

arbolSuccess <- rpart(
  country_txt ~ .,
  data = globalTerr,
  method = "class",
  control = rpart.control(
    minsplit = 10,   # Número mínimo de observaciones requeridas para dividir un nodo (ajustado a 10)
    minbucket = 5,   # Número mínimo de observaciones en una hoja (ajustado a 5)
    cp = 0.005       # Complejidad del árbol, parámetro de poda (ajustado a 0.005)
  )
)
prp(arbolSuccess)

arbolSuccess <- rpart(
  country_txt ~ .,
  data = globalTerr,
  method = "class",
  control = rpart.control(
    minsplit = 1,   # Número mínimo de observaciones requeridas para dividir un nodo (ajustado a 10)
    minbucket = 1,   # Número mínimo de observaciones en una hoja (ajustado a 5)
    cp = 0.001       # Complejidad del árbol, parámetro de poda (ajustado a 0.005)
  )
)
prp(arbolSuccess)


# -------------- Red Neuronal --------------
