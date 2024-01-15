terrorismo <- read.csv(file.choose())
terrorismo$attacktype1_txt <- as.factor(terrorismo$attacktype1_txt)
summary(terrorismo)

# true/fase -> 0/1
cols <- sapply(terrorismo, is.logical)
cols

terrorismo$success <- ifelse(terrorismo$success == "Fallido", 0, ifelse(terrorismo$success == "Exitoso", 1, terrorismo$success))
terrorismo$suicide <- ifelse(terrorismo$suicide == "No suicida", 0, ifelse(terrorismo$suicide == "Suicida", 1, terrorismo$suicide))
terrorismo$crit1 <- ifelse(terrorismo$crit1 == "No", 0, ifelse(terrorismo$crit1 == "Si", 1, terrorismo$crit1))
terrorismo$crit2 <- ifelse(terrorismo$crit2 == "No", 0, ifelse(terrorismo$crit2 == "Si", 1, terrorismo$crit2))
terrorismo$crit3 <- ifelse(terrorismo$crit3 == "No", 0, ifelse(terrorismo$crit3 == "Si", 1, terrorismo$crit3))
terrorismo$country_txt <- ifelse(terrorismo$country_txt == "Dominican Republic", 0, 
                                 ifelse(terrorismo$country_txt == "United States", 1, 
                                        ifelse(terrorismo$country_txt == "Uruguay", 2, 
                                               ifelse(terrorismo$country_txt == "Italy", 3, 
                                                      ifelse(terrorismo$country_txt == "East Germany (GDR)", 4,
                                                             ifelse(terrorismo$country_txt == "Ethiopia", 5, 
                                                                    ifelse(terrorismo$country_txt == "Ethiopia", 6, 
                                                                           ifelse(terrorismo$country_txt == "Guatemala", 7, 
                                                                                  ifelse(terrorismo$country_txt == "Philippines", 8, 
                                                                                         ifelse(terrorismo$country_txt == "Venezuela", 9, 
                                                                                                ifelse(terrorismo$country_txt == "West Germany (FRG)", 10, 
                                                                                                       terrorismo$country_txt)))))))))))

#terrorismo$attacktype1_txt <- ifelse(terrorismo$attacktype1_txt == "Assassination", 0, 
#                                     ifelse(terrorismo$attacktype1_txt == "Armed Assault", 1, 
#                                            ifelse(terrorismo$attacktype1_txt == "Bombing/Explosion", 2, 
#                                                 ifelse(terrorismo$attacktype1_txt == "Facility/Infrastructure Attack", 3,
#                                                          ifelse(terrorismo$attacktype1_txt == "Hijacking", 4,
#                                                                 ifelse(terrorismo$attacktype1_txt == "Unknown", 5,
#                                                                        ifelse(terrorismo$attacktype1_txt == "Hostage Taking (Kidnapping)", 6, 
#                                                                               terrorismo$attacktype1_txt)))))))

#terrorismo$weaptype1_txt <- ifelse(terrorismo$weaptype1_txt == "Unknown", 0, 
#                                   ifelse(terrorismo$weaptype1_txt == "Firearms", 1, 
#                                          ifelse(terrorismo$weaptype1_txt == "Explosives", 2, 
#                                                 ifelse(terrorismo$weaptype1_txt == "Incendiary", 3,
#                                                        terrorismo$weaptype1_txt))))


terrorismo[,cols] <- lapply(terrorismo[,cols], as.numeric)

head(terrorismo)
terrorismo

#install.packages("caTools")
library(caTools)
set.seed(123)

#Tomamos el 66% de las tuplas para entrenamiento, el resto para prueba
split = sample.split(terrorismo$weaptype1_txt, SplitRatio = 0.66)
summary(split)

#Partimos el dataset basado en el vector booleano split
entrena = subset(terrorismo, split == TRUE)
prueba = subset(terrorismo, split == FALSE)


summary(entrena)
summary(prueba)

caracteristicas <- names(terrorismo)
caracteristicas

caracteristicas <- caracteristicas[-which(names(terrorismo) %in% c("weaptype1_txt","attacktype1_txt"))]
caracteristicas

# Concatenamos las cadenas
form <- paste(caracteristicas,collapse=' + ')
form

#Hacemos coincidir con el dataset de entrenamiento
form <- paste('attacktype1_txt ~',form)
form

# Convertir a formula
form <- as.formula(form)
form

#Cargamos la librería neuralnet
library(neuralnet)

# Convertir las columnas deseadas a tipo numérico en entrena
entrena$iyear <- as.numeric(entrena$iyear)
entrena$imonth <- as.numeric(entrena$imonth)
entrena$iday <- as.numeric(entrena$iday)

entrena$country_txt <- as.numeric(as.factor(entrena$country_txt))
entrena$success <- as.numeric(as.factor(entrena$success))
entrena$suicide <- as.numeric(as.factor(entrena$suicide))

entrena$nkill <- as.numeric(entrena$nkill)
entrena$nwound <- as.numeric(entrena$nwound)
entrena$nperps <- as.numeric(entrena$nperps)
entrena$crit1 <- as.numeric(entrena$crit1)
entrena$crit2 <- as.numeric(entrena$crit2)
entrena$crit3 <- as.numeric(entrena$crit3)

# Convertir las columnas deseadas a tipo numérico en prueba
prueba$iyear  <- as.numeric(prueba$iyear)
prueba$imonth <- as.numeric(prueba$imonth)
prueba$iday   <- as.numeric(prueba$iday)

prueba$country_txt <- as.numeric(as.factor(prueba$country_txt))
prueba$success     <- as.numeric(as.factor(prueba$success))
prueba$suicide     <- as.numeric(as.factor(prueba$suicide))

prueba$nkill  <- as.numeric(prueba$nkill)
prueba$nwound <- as.numeric(prueba$nwound)
prueba$nperps <- as.numeric(prueba$nperps)
prueba$crit1  <- as.numeric(prueba$crit1)
prueba$crit2  <- as.numeric(prueba$crit2)
prueba$crit3  <- as.numeric(prueba$crit3)

# Verificar el resultado
# str(entrena)

# Utilizando la función SIGMOIDE
sigmoide = function(x) {1/(1 + exp(-x))}

# Entrenamos la red neuronal
if (any(is.na(entrena))) {
  print("Hay valores faltantes en el conjunto de datos.")
} else {
  print("No hay valores faltantes en el conjunto de datos.")
  # Entrenamos la red neuronal
  red1 <- neuralnet(form,entrena,hidden=c(5,3),linear.output=FALSE)
  red2 <- neuralnet(form, entrena, hidden = c(5, 3), startweights = NULL,
                   learningrate = 0.2, algorithm = "backprop",
                   act.fct = "logistic", linear.output = FALSE)
}


#Graficamos la red neuronal
plot(red1)
red1

plot(red2)
red2


# Veamos los resultados del entrenamiento
out1 <- cbind(red1$covariate, + red1$net.result[[1]])
out1

out2 <- cbind(red2$covariate, + red2$net.result[[1]])
out2

# str(prueba)
# Probamos el modelo entrenado
# Calcular las predicciones sobre el conjunto de prueba
prediccion1 <- predict(red1,prueba)
prediccion2 <- predict(red2,prueba)

prediccion1
prediccion2

# Verificar los resultados
print(head(round(prediccion1,2)))
print(head(round(prediccion2,2)))


