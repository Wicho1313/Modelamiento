#### SERIES DE TIEMPO ####
###link ayudad https://www.itl.nist.gov/div898/handbook/pmc/section4/pmc41.htm
####https://www.itl.nist.gov/div898/handbook/pmc/section4/pmc45.htm
##CARGE LA BASE DE DATOS CO2
library(forecast)
library(tseries)
library(ggplot2)
co2ts<-ts(co2$CO2, start = c(1959,1), frequency = 12)
print(co2ts)
library(ggfortify)
###e puede determinar que presenta una tendencia ascendente 
###(la serie no es estacionaria en media). Con esto se puede 
##afirmar que la serie no es estacionaria. Tambien se puede 
##observar que la serie es estacionaria en cuando a la varianza, 
##ya que no se aprecia gran variabiliad. Para confirmar lo dicho
##vamos a trazar la gráfica de su función de autocorrelación.
autoplot(co2ts, ts.colour = "blue", ts.linetype = "dashed")
###e puede apreciar en esta gráfica como la serie no es 
##estacionaria ya que el valor de la función de autocorrelación 
##no decae de manera exponencial a medida que aumentan los rezagos
##en el tiempo. También apreciamos que existe la componente 
##estacional, con un periodo de 12, por lo tanto se analizará 
##las componente por separado para ello descomponemos la serie.
autoplot(acf(co2ts, plot = FALSE))

#### MODELAMIENTO DE LA SERIE ####
###El análisis previo nos revela que tenemos que eliminar la tendencia y la estacionalidad de la serie para que pueda ser estacionaria. El modelo que vamos a utilizar es un modelo ARIMA, diferenciando la serie lograremos que sea convertida a estacionaria, por lo tanto vamos a ver que nos dice las funciones ndiffs y nsdiffs, que calculan cada una el número de diferenciaciones regulares y estacionales respectivamente que se necesita llevar a cabo para que la serie sea estacionaria.
ndiffs(co2ts)
nsdiffs(co2ts)
### eliminamos el componente de tendecias 
diff.co2ts<-autoplot(diff(co2ts), ts.linetype = "dashed", ts.colour = "darkmagenta")
diff.co2ts
###Como podemos ver ahora en la serie ya se ha eliminado la componente de tendencia, una ves eliminada esta componente volvemos a gráficar la función de autocorrelación.
autoplot(acf(diff(co2ts), plot = FALSE))
###Podemos apreciar que la serie sigue sin ser estacionaria, ya que la función de autocorrelación decrece rápidamente en los desfaces regulares de forma lenta en los retardos (12,24,36), de forma que no es estacionaria en la parte estacional, además nuevamente se vuelve a ver la componente estacional de perido 12.
monthplot(diff(co2ts), col = "midnightblue")
diffco2<-diff(co2ts)
boxplot(diffco2~cycle(diffco2))
##Se puede apreciar que los picos más altos se presentan en los meses de marzo y abril, mientras que los picos más bajos se presentan en los meses agosto y septiembre. Ahora eliminaremos el componente estacional
