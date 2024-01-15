# Autores:
# Aguilera Moreno Adrián     - Cta. 421005200
# Hernández Dorantes Israel  - Cta. 318206604


# ==============================================================================
# EJERCICIO 2
# ==============================================================================

# Definimos el data set
data <- data.frame(
  age = c(23, 23, 27, 27, 39, 41, 47, 49, 50, 52, 54, 54, 56, 57, 58, 58, 60, 61),
  fat = c(9.5, 26.5, 7.8, 17.8, 31.4, 25.9, 27.4, 27.2, 31.2, 34.6, 42.5, 28.8, 33.4, 30.2, 34.1, 32.9, 41.2, 35.7)
)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (a)

# Media de data (variables age y fat):
media_age <- mean(data$age)
media_fat <- mean(data$fat)
# Mostrar medias para las variables age y fat
cat("Media para age:", media_age, "\n")
cat("Media para fat:", media_fat, "\n")

# Definimos una función para calcular la moda
moda <- function(x) {
  tabla <- table(x)
  modas <- as.numeric(names(tabla[tabla == max(tabla)]))
  if(length(x) == length(modas)) {
    return(NULL)
  } else {
    return(modas)
  }
}

# Moda de data (variables age y fat):
moda_age <- moda(data$age)
moda_fat <- moda(data$fat)
# Mostrar modas para las variables age y fat
cat("Moda para age:", moda_age, "\n")
cat(if(is.null(moda_fat)){
  "fat es un conjunto amodal."
  } else{paste("Moda para fat:", moda_fat, "\n")})

# Mediana de data (variables age y fat):
mediana_age <- median(data$age)
mediana_fat <- median(data$fat)
# Mostrar medianas para las variables age y fat
cat("Mediana para age:", mediana_age, "\n")
cat("Mediana para fat:", mediana_fat, "\n")

# Desviación estándar de data (variables age y fat):
ds_age <- sd(data$age)
ds_fat <- sd(data$fat)
# Mostrar desviación estándar para las variables age y fat
cat("Desviación estándar para age:", ds_age, "\n")
cat("Desviación estándar para fat:", ds_fat, "\n")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (b)

# Cuartil 1:
cuartil_1_age <- quantile(data$age, 0.25)
cuartil_1_fat <- quantile(data$fat, 0.25)

# Cuartil 3:
cuartil_3_age <- quantile(data$age, 0.75)
cuartil_3_fat <- quantile(data$fat, 0.75)

# Mostrar resultados
cat("Primer cuartil (Q1) de age:", cuartil_1_age, "\n")
cat("Primer cuartil (Q1) de fat:", cuartil_1_fat, "\n")
cat("Tercer cuartil (Q3) de age:", cuartil_3_age, "\n")
cat("Tercer cuartil (Q3) de fat:", cuartil_3_fat, "\n")

# Diagrama de caja
boxplot(data$age, data$fat, names = c("Age", "Fat"), main = "Diagrama de Caja", ylab = "Valor", col = c("skyblue", "lightgreen"))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (c)

install.packages(c("Hmisc", "ROCR", "gridExtra", "pander", "reshape2", "lazyeval", "moments", "entropy"))
install.packages("/home/aguilera/Downloads/funModeling_1.9.4.tar.gz", repos = NULL, type = "source")
library(funModeling)

data <- tibble::as_tibble(data)
data_grp = data %>% group_by(age) %>% summarise(fat = max(fat))

data_grp$fat_frec = equal_freq(var = data_grp$fat, n_bins = 3)
describe(data_grp$fat_frec)

p=ggplot(data_grp, aes(fat_frec)) + 
  geom_bar(fill="#CC79A7") + theme_bw()
p

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (d)

# definir función de normalización:
normalizar_min_max_rango <- function(x, nuevo_rango) {
  rango_nuevo <- nuevo_rango[2] - nuevo_rango[1]
  minimo_nuevo <- nuevo_rango[1]
  return(rango_nuevo * (x - min(x)) / (max(x) - min(x)) + minimo_nuevo)
}

rango <- c(0.0, 0.1)
data_normalizado <- normalizar_min_max_rango(data$age, rango)
print(data_normalizado)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (e)

data_normalizados_z_score <- scale(data$fat)
print(data_normalizados_z_score)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (f)
matriz_correlacion_parson <- cor(data)
print(matriz_correlacion_parson)

# ==============================================================================
# EJERCICIO 4
# ==============================================================================
# Instalando paquetes necesarios
install.packages("arules")
install.packages("tidyverse")

# Creando la tabla con los datos de transacciones
library(tidyverse)
datos_transacciones <- tibble(
  IDTransaccion = 1:8,
  ItemsComprados = list(c("a", "b"), c("b", "c"), c("a", "b", "c"), c("d", "e", "f"),
                        c("a", "b", "c"), c("d", "f"), c("c", "d", "e", "f"), c("a", "b", "c", "d", "e"))
)

# Mostrando los datos
datos_transacciones

# Convertiendo la columna "ItemsComprados" en un objeto de la clase "transactions"
library(arules)
transacciones <- as(datos_transacciones$ItemsComprados, "transactions")
# Ejecutando el algoritmo apriori a la base de datos generada con un soporte minimo de 0.3 y una confianza 
# minima de 0.77
rules <- apriori(transacciones, parameter = list(support = 0.3, confidence = 0.77))
# Mostrando las reglas de asociación generadas por el algoritmo
inspect(rules)



# ==============================================================================
# EJERCICIO 5
# ==============================================================================
# a)
#Creando el conjunto de entrenamiento
datos_entrenamiento <- data.frame(ID = c(1, 2, 3, 4, 5, 6, 7, 8, 9),
                                  a1 = c(TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, TRUE, FALSE),
                                  a2 = c(TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE),
                                  a3 = c(1.0, 6.0, 4.0, 7.0, 3.0, 4.0, 8.0, 7.0, 5.0),
                                  Clase = c("C1", "C1", "C2", "C1", "C2", "C2", "C2", "C1", "C2"))


# Mostrando datos
datos_entrenamiento

# Funcion que calcula la entropia del conjunto de entrenamiento con respescto a la clase C1
entropia_c1 <- function(data) {
  p_c1 <- sum(data$Clase == "C1") / nrow(data)
  p_c2 <- 1 - p_c1
  
  if (p_c1 == 0 || p_c2 == 0) {
    # Si c1 o c2 no está presente
    return(0)
  }
  
  -sum(c(p_c1, p_c2) * log2(c(p_c1, p_c2)))
}


# Mostrando resultado 
r_entropia_c1 <- entropia_c1(datos_entrenamiento)
r_entropia_c1



# b)
# Función para calcular la entropía inicial del un conjunto de entrenamiento
entropia <- function(data) {
  proporciones <- table(data$Clase) / nrow(data)
  -sum(proporciones * log2(proporciones))
}

# Función para calcular la ganancia de información de un atributo
ganancia_informacion <- function(data, atributo) {
  entropia_inicial <- entropia(data)
  
  # Dividir el conjunto de datos según el atributo
  grupos <- split(data, data[[atributo]])
  
  # Calcular la entropía ponderada después de la división
  entropia_dividida <- sum(sapply(grupos, function(subgrupo) {
    p <- nrow(subgrupo) / nrow(data)
    p * entropia(subgrupo)
  }))
  
  # Calcular la ganancia de información
  ganancia <- entropia_inicial - entropia_dividida
  return(ganancia)
}

# Calcular la ganancia de información de a1 y a2
ganancia_a1 <- ganancia_informacion(datos_entrenamiento, "a1")
ganancia_a2 <- ganancia_informacion(datos_entrenamiento, "a2")

# Mostrando la ganancia de informacion de a1
ganancia_a1
# Mostrando la ganancia de informacion de a2
ganancia_a2


# c)
# Ordenando los datos de entrenamiento segun los valores de a3
datos_ordenados <- datos_entrenamiento[order(datos_entrenamiento$a3), ]

# Calculando el punto medio entre cada par de valores consecutivos de a3
puntos_medios <- (datos_ordenados$a3[-1] + datos_ordenados$a3[-length(datos_ordenados$a3)]) / 2

# Calculando la entropía del conjunto de entrenamiento
entropia_conjunto <- -sum(prop.table(table(datos_entrenamiento$Clase)) * log2(prop.table(table(datos_entrenamiento$Clase))))

# Funcion que calcula la ganancia de informacion para cada punto medio
ganancias_informacion_division <- sapply(puntos_medios, function(punto_medio) {
  # Dividimos los datos en dos grupos según el punto medio
  grupo1 <- datos_ordenados$a3 <= punto_medio
  grupo2 <- datos_ordenados$a3 > punto_medio
  
  # Calculamos la entropía de cada grupo
  entropia_grupo1 <- -sum(prop.table(table(datos_ordenados$Clase[grupo1])) * log2(prop.table(table(datos_ordenados$Clase[grupo1]))))
  entropia_grupo2 <- -sum(prop.table(table(datos_ordenados$Clase[grupo2])) * log2(prop.table(table(datos_ordenados$Clase[grupo2]))))
  
  # Calculamos la ganancia de información para el punto medio
  ganancia_informacion <- entropia_conjunto - sum(grupo1) / length(datos_ordenados$a3) * entropia_grupo1 - sum(grupo2) / length(datos_ordenados$a3) * entropia_grupo2
  
  return(ganancia_informacion)
})

# Mostrando las ganancias de información para cada punto medio
ganancias_informacion_division


# d)
# Funcion que calcula la entropia (y la regresa)
calcular_entropia <- function(data) {
  proporciones <- table(data) / length(data)
  entropia <- -sum(proporciones * log2(proporciones))
  return(entropia)
}

# Funcion que calcula la ganancia de informacion para a3
calcular_ganancia_informacion <- function(data, variable) {
  entropia_inicial <- calcular_entropia(data$Clase)
  
  entropias <- sapply(unique(data[[variable]]), function(valor) {
    subset_data <- data[data[[variable]] == valor, ]
    proporcion <- nrow(subset_data) / nrow(data)
    entropia <- calcular_entropia(subset_data$Clase)
    proporcion * entropia
  })
  
  ganancia_informacion <- entropia_inicial - sum(entropias)
  return(ganancia_informacion)
}

# Calculando la ganancia de información de a3
ganancia_a3 <- calcular_ganancia_informacion(datos_entrenamiento, "a3")

# Mostrando la ganancia de informacion de a1
ganancia_a1
# Mostrando la ganancia de informacion de a2
ganancia_a2
# Mostrando la ganancia de informacion de a3
ganancia_a3

# La mejor division es "a3"

# ==============================================================================
# EJERCICIO 6
# ==============================================================================

# Definimos el dataset
data <- data.frame(
  ID_Cliente = 1:20,
  Genero = c("m", "m", "m", "m", "m", "m", "f", "f", "f", "f", "m", "m", "m", "m", "f", "f", "f", "f", "f", "f"),
  Tipo_Auto = c("Familiar", "Deportivo", "Deportivo", "Deportivo", "Deportivo", "Deportivo", "Deportivo", "Deportivo", "Deportivo", "Lujo", "Familiar", "Familiar", "Familiar", "Lujo", "Lujo", "Lujo", "Lujo", "Lujo", "Lujo", "Lujo"),
  Talla_Playeras = c("Ch", "M", "M", "G", "XG", "XG", "Ch", "Ch", "M", "G", "G", "XG", "M", "XG", "Ch", "Ch", "M", "M", "M", "G"),
  Clase = c("C0", "C0", "C0", "C0", "C0", "C0", "C0", "C0", "C0", "C0", "C1", "C1", "C1", "C1", "C1", "C1", "C1", "C1", "C1", "C1")
)

install.packages("ineq")
library(ineq)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (a)
data_numeric <- as.numeric(as.vector(unlist(data)))
indice_gini_total <- Gini(data_numeric)
cat("El índice Gini del conjunto de entrenamiento es:", indice_gini_total)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (b)
data$Genero_numerico <- ifelse(data$Genero == 'm', 1, 0)
indice_gini_G <- Gini(data$Genero_numerico)
cat("El índice Gini del Género es:", indice_gini_G)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (c)
data$Tipo_Auto_numerico <- ifelse(data$Tipo_Auto == 'Deportivo', 0,
                                  ifelse(data$Tipo_Auto == 'Familiar', 1,
                                         ifelse(data$Tipo_Auto == 'Lujo', 2, NA)))

indice_gini_TA <- Gini(data$Tipo_Auto_numerico)
cat("El índice Gini del tipo de auto es:", indice_gini_TA)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (d)
data$Talla_Playeras_numerico <- ifelse(data$Talla_Playeras == 'Ch', 0,
                                       ifelse(data$Talla_Playeras == 'M', 1,
                                              ifelse(data$Talla_Playeras == 'G', 2,
                                                     ifelse(data$Talla_Playeras == 'XG', 3, NA))))

indice_gini_TP <- Gini(data$Talla_Playeras_numerico)
cat("El índice Gini de la talla de playeras es:", indice_gini_TP)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Inciso (e)
data$Clase_numerico <- ifelse(data$Clase == 'C0', 0, 1)
indice_gini_C <- Gini(data$Clase_numerico)
cat("El índice Gini del Clase es:", indice_gini_C)
