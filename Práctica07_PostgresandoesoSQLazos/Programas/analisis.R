# Cargar el conjunto de datos
vgsales <- read.csv("vgsales.csv")

# Hacemos un resumen de los datos
summary(vgsales)

# Vemos las primeras lineas del dataset
head(vgsales)

# Boxplot para verificar valoresa anomalos en cada columna (Solo para variables numericas)
# Para variables categoricas añadimos tambien la función table
boxplot(vgsales$Rank)
boxplot(table(vgsales$Name))
boxplot(table(vgsales$Platform))
boxplot(vgsales$Year)
boxplot(table(vgsales$Genre))
boxplot(table(vgsales$Publisher))
boxplot(vgsales$NA_Sales)
boxplot(vgsales$EU_Sales)
boxplot(vgsales$JP_Sales)
boxplot(vgsales$Other_Sales)
boxplot(vgsales$Global_Sales)

#Hacemos un histograma por cada columna:
#Para variables categoricas añadimos tambien la función table
hist(vgsales$Rank)
hist(table(vgsales$Name))
hist(table(vgsales$Platform))
hist(vgsales$Year)
hist(table(vgsales$Genre))
hist(table(vgsales$Publisher))
hist(vgsales$NA_Sales)
hist(vgsales$EU_Sales)
hist(vgsales$JP_Sales)
hist(vgsales$Other_Sales)
hist(vgsales$Global_Sales)

# Gráfico de dispersión para atributos numéricos
pairs(vgsales[, sapply(vgsales, is.numeric)])


# Valores más comunes en una columna específica (variables categoricas)
barplot(table(vgsales$Name))
barplot(table(vgsales$Platform))
barplot(table(vgsales$Genre))
barplot(table(vgsales$Publisher))

# Detección de valores faltantes
cat("Valores faltantes en el conjunto de datos:", sum(is.na(data)), "\n")
print(sum(is.na(vgsales$Rank)))
print(sum(is.na(vgsales$Name)))
print(sum(is.na(vgsales$Platform)))
print(sum(is.na(vgsales$Year)))
print(sum(is.na(vgsales$Genre)))
print(sum(is.na(vgsales$Publisher)))
print(sum(is.na(vgsales$NA_Sales)))
print(sum(is.na(vgsales$EU_Sales)))
print(sum(is.na(vgsales$JP_Sales)))
print(sum(is.na(vgsales$Other_Sales)))
print(sum(is.na(vgsales$Global_Sales)))

# Revisión de posibles errores en los datos (por ejemplo, valores negativos en ventas)
cat("Valores negativos en las ventas globales:", sum(vgsales$NA_Sales < 0), "\n")
cat("Valores negativos en las ventas globales:", sum(vgsales$EU_Sales < 0), "\n")
cat("Valores negativos en las ventas globales:", sum(vgsales$JP_Sales < 0), "\n")
cat("Valores negativos en las ventas globales:", sum(vgsales$Other_Sales < 0), "\n")
cat("Valores negativos en las ventas globales:", sum(vgsales$Global_Sales < 0), "\n")
