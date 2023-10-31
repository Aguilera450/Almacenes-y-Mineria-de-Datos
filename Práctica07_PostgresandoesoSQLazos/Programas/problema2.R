setwd("/home/marco/Documentos/R/")

grupoA <- read.csv("grupoA.csv")
grupoB <- read.csv("grupoB.csv")

# Grafica de pay de GrupoA
conteosA <- table(grupoA$Gr_sang)
pie(conteosA, labels = paste(names(conteosA), "\n(", conteosA, ")",sep = ""),
    main = "Grupo A")

# Grafica de pay de GrupoB
conteosB <- table(grupoB$Gr_sang)
pie(conteosB, labels = paste(names(conteosB), "\n(", conteosB, ")",sep = ""),
    main = "Grupo B")

# Histograma de variable estaturas del grupo A
hist(grupoA$Estatura, main = "Histograma estaturas Grupo A")

# Histograma de variable estaturas del grupo B
hist(grupoB$Estatura, main = "Histograma estaturas Grupo B")


# Crear un gráfico de caja del grupo A
boxplot(grupoA$Edad, main = "Gráfico de Caja Grupo A")

# Agregar identificadores a los valores atípicos
outliers <- boxplot(grupoA$Edad, plot = FALSE)$out
if (length(outliers) > 0) {
  points(rep(1, length(outliers)), outliers, col = "red", pch = 19)
  cat("Valores atípicos:", outliers, "\n")
} else {
  cat("No hay valores atípicos en el conjunto de datos.\n")
}

# Crear un gráfico de caja del grupo B
boxplot(grupoB$Edad, main = "Gráfico de Caja Grupo B")

# Agregar identificadores a los valores atípicos
outliers <- boxplot(grupoB$Edad, plot = FALSE)$out
if (length(outliers) > 0) {
  points(rep(1, length(outliers)), outliers, col = "red", pch = 19)
  cat("Valores atípicos:", outliers, "\n")
} else {
  cat("No hay valores atípicos en el conjunto de datos.\n")
}


# Promedio de estaturas de A
meanEstaturasA <- mean(grupoA$Estatura, na.rm = TRUE)
# Promedio de estaturas de B
meanEstaturasB <- mean(grupoB$Estatura, na.rm = TRUE)

print(meanEstaturasA)
print(meanEstaturasB)

# Mediana de estaturas de A
medianEstaturasA <- median(grupoA$Estatura, na.rm = TRUE)
# Mediana de estaturas de B
medianEstaturasB <- median(grupoB$Estatura, na.rm = TRUE)

print(meanEstaturasA)
print(meanEstaturasB)

  
