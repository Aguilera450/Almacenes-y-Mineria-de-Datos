# Cargar el conjunto de datos
vgsales <- read.csv("/Users/isra/Documents/AlmacenesYMineria/Almacenes-y-Mineria-de-Datos/Práctica08_PostgresandoesoSQLazos/Datasets/vgsales.csv")

# Hacemos un resumen de los datos
summary(vgsales)

# Vemos las primeras lineas del dataset
head(vgsales)

# ---- Limpieza de datos ----
# Quitamos los campos que tienen NA
vgsalesLimpio <- replace(vgsales, is.na(vgsales), 0)

# Ponemos las plataformas en mayusculas
vgsalesLimpio$Platform <- toupper(vgsalesLimpio$Platform)

# Corrigiendo los valores erroneos de WII
vgsalesLimpio$Platform <- ifelse(vgsalesLimpio$Platform == "WI", "WII", vgsalesLimpio$Platform)

# Corrigiendo los valores erroneos de Play Station 2
vgsalesLimpio$Platform <- ifelse(vgsalesLimpio$Platform == "PLAYSTATION2", "PS2", vgsalesLimpio$Platform)
vgsalesLimpio$Platform <- ifelse(vgsalesLimpio$Platform == "PSTATION2", "PS2", vgsalesLimpio$Platform)
vgsalesLimpio$Platform <- ifelse(vgsalesLimpio$Platform == "PLAYS2", "PS2", vgsalesLimpio$Platform)

# Unificando los nombres para las consolas de XBOX
vgsalesLimpio$Platform <- ifelse(vgsalesLimpio$Platform == "XB", "XBOX", vgsalesLimpio$Platform)
vgsalesLimpio$Platform <- ifelse(vgsalesLimpio$Platform == "XB360", "XBOX360", vgsalesLimpio$Platform)
vgsalesLimpio$Platform <- ifelse(vgsalesLimpio$Platform == "X360", "XBOX360", vgsalesLimpio$Platform)
vgsalesLimpio$Platform <- ifelse(vgsalesLimpio$Platform == "XONE", "XBOXONE", vgsalesLimpio$Platform)

# Corrigiendo filas que tienen mal escrito Action
vgsalesLimpio$Genre <- ifelse(vgsalesLimpio$Genre == "ACTON", "Action", vgsalesLimpio$Genre)
vgsalesLimpio$Genre <- ifelse(vgsalesLimpio$Genre == "ation", "Action", vgsalesLimpio$Genre)

# Corrigiendo filas que tienen genero en blanco por Misc
vgsalesLimpio$Genre <- ifelse(vgsalesLimpio$Genre == "", "Misc", vgsalesLimpio$Genre)

# Corrigiendo filas que tienen mal escrito Nintendo
vgsalesLimpio$Publisher <- ifelse(vgsalesLimpio$Publisher == "intendo", "Nintendo", vgsalesLimpio$Publisher)
vgsalesLimpio$Publisher <- ifelse(vgsalesLimpio$Publisher == "nintndo", "Nintendo", vgsalesLimpio$Publisher)

# Unificando SNK PLaymore y SNK en solo SNK Playmore
vgsalesLimpio$Publisher <- ifelse(vgsalesLimpio$Publisher == "SNK", "SNK PLAYMORE", vgsalesLimpio$Publisher)

# Exportamos el csv
write.csv(vgsalesLimpio, "vgsalesLimpio.csv", row.names = FALSE)

#Prueba Chi

tabla <- table(vgsalesLimpio$Genre, vgsalesLimpio$Publisher)

chisq.test(tabla)

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







