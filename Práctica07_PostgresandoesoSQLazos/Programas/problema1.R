#problema1.R
vector <- sample(-5000:5000,10000,replace =TRUE)
print(vector)

min <- min(vector)
firstQ <- quantile(vector,0.25)
median <- median(vector)
mean <- mean(vector)
thirdQ <- quantile(vector,0.75)
max <- max(vector)
resultados <- c(min,firstQ,median,mean,thirdQ,max)

print(resultados)
summary(vector)
