#~~~~~~~~~~~~~~~~ 1er inciso.
# Crear un dataframe con los vectores de datos
data <- data.frame(
  vector1 = c(6, 4, 0, 0),
  vector2 = c(3, 6, 1, 0),
  vector3 = c(0, 2, 5, 3),
  vector4 = c(0, 1, 2, 7)
)

# Calcular la matriz de correlación de Pearson
matriz_correlacion <- cor(data)

# Imprimir la matriz de correlación
print(matriz_correlacion)

# Data frame, el mismo pero con los rangos.
data <- data.frame(
    Rango = c("(25,35]", "(35,45]", "(45,55]", "(55,65]"),
   `22 > X/Y` = c(6, 3, 0, 0),
   `22 > 20` = c(4, 6, 2, 1),
   `22 > 30` = c(0, 1, 5, 2),
   `22 > 40` = c(0, 0, 3, 7)
)

#~~~~~~~~~~~~ 2do Inciso
# Renombrar la columna '22 > X/Y' a un nombre válido
colnames(data)[colnames(data) == "X22...X.Y"] <- "X_over_Y"

# Cambiar los nombres de las columnas a nombres válidos
colnames(data) <- c("Rango", "X_over_Y", "X_22_over_20", "X_22_over_30", "X_22_over_40")

# Ajustar el modelo de regresión lineal
model <- lm(X_over_Y ~ X_22_over_20 + X_22_over_30 + X_22_over_40, data = data)

# Mostrar un resumen del modelo
summary(model)


# Estimar la habilidad verbal para un puntaje de razonamiento abstracto de 70
razonamiento_abstracto <- data.frame(X_22_over_20 = 70, X_22_over_30 = 70, X_22_over_40 = 70)
habilidad_verbal_estimada <- predict(model, newdata = razonamiento_abstracto)
habilidad_verbal_estimada
