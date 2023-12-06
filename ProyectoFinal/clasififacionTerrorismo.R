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
  success ~ .,
  data = globalTerr,
  method = "class",
  control = rpart.control(
    minsplit = 20,      # Número mínimo de observaciones requeridas para dividir un nodo
    minbucket = 10,     # Número mínimo de observaciones en una hoja
    cp = 0.01           # Complejidad del árbol, parámetro de poda
  )
)


rpart.plot(arbolSuccess, main = "Árbol de Decisión CART - Éxito del Ataque")

# Para los ataques suicidas
arbolSuicide <- rpart(
  suicide ~ .,
  data = globalTerr,
  method = "class",
  control = rpart.control(
    minsplit = 10,   # Número mínimo de observaciones requeridas para dividir un nodo (ajustado a 10)
    minbucket = 5,   # Número mínimo de observaciones en una hoja (ajustado a 5)
    cp = 0.005       # Complejidad del árbol, parámetro de poda (ajustado a 0.005)
  )
)

rpart.plot(arbolSuicide, main = "Árbol de Decisión CART - Ataque Suicida")


# Para los ataques con criterio 1 (crit1) que tienen objetivos politicos, economicos, sociales o religiosos
arbolCrit1 <- rpart(
  crit1 ~ .,
  data = globalTerr,
  method = "class",
  control = rpart.control(
    minsplit = 5,
    minbucket = 10,
    cp = 0
  )
)

rpart.plot(arbolCrit1, main = "Árbol de Decisión CART - Ataque con el Cirterio 1")


# -------------- Red Neuronal --------------

