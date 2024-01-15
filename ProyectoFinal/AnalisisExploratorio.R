library(dplyr)
globalTerr <- read.csv(file = "globalterrorismdb_0718dist.csv", header = T, stringsAsFactors = F)
globalTerr <- tibble::as.tibble(globalTerr)

nom_variables_numericas <- names(globalTerr)[sapply(globalTerr, is.numeric)]
nom_variables_no_numericas <- names(globalTerr)[!sapply(globalTerr, is.numeric)]

variables_numericas <- globalTerr[, nom_variables_numericas]
variables_no_numericas <- globalTerr[, nom_variables_no_numericas]

write.csv(names(globalTerr), file = "names.csv")
write.csv(summary(variables_no_numericas), file = "summaryNoNum.csv")

analisis <- data.frame(
  Nombre = nom_variables_numericas,
  Porcentaje_Perdidos = sapply(variables_numericas, function(x) sum(is.na(x)) / length(x) * 100),
  Minimo = sapply(variables_numericas, min, na.rm = T),
  Maximo = sapply(variables_numericas, max, na.rm = T),
  Media = sapply(variables_numericas, mean, na.rm = T),
  Desviacion_Estandar = sapply(variables_numericas, sd, na.rm = T)
)

write.csv(analisis, file = "summaryNum.csv")

barplot(table(globalTerr$gname), main = "G", xlab = "X", ylab = "Y")

# Función para calcular el porcentaje de valores perdidos
porcentaje_perdido <- function(x) {
  porcentaje <- sum(x == "" | is.na(x)) / length(x) * 100
  return(porcentaje)
}
# Aplicar la función a cada columna
porcentajes <- apply(globalTerr, 2, porcentaje_perdido)

# Crear un nuevo DataFrame con los resultados
resultados <- data.frame(
  Variable = names(globalTerr),
  Val_Perdidos = porcentajes
)

# Guardar los resultados en un archivo CSV
write.csv(resultados, "AnalisisComp.csv", row.names = FALSE)

install.packages("outliers")
library(outliers)

outlier(globalTerr$weaptype1)