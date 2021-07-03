#### SERIES DE TIEMPO ####
###link ayudad https://www.itl.nist.gov/div898/handbook/pmc/section4/pmc41.htm
####https://www.itl.nist.gov/div898/handbook/pmc/section4/pmc45.htm
##CARGE LA BASE DE DATOS CO2
library(forecast)
library(tseries)
library(ggplot2)
co2ts=ts(co2$CO2, start = c(1959,1), frequency = 12)
print(co2ts)
library(ggfortify)
###Se puede determinar que presenta una tendencia ascendente 
###(la serie no es estacionaria en media). Con esto se puede 
##afirmar que la serie no es estacionaria. Tambien se puede 
##observar que la serie es estacionaria en cuando a la varianza, 
##ya que no se aprecia gran variabiliad. Para confirmar lo dicho
##vamos a trazar la gráfica de su función de autocorrelación.
autoplot(co2ts, ts.colour = "blue", ts.linetype = "dashed")
###Se puede apreciar en esta gráfica como la serie no es 
##estacionaria ya que el valor de la función de autocorrelación 
##no decae de manera exponencial a medida que aumentan los rezagos
##en el tiempo. También apreciamos que existe la componente 
##estacional, con un periodo de 12, por lo tanto se analizará 
##las componente por separado para ello descomponemos la serie.
autoplot(acf(co2ts, plot = FALSE))

#### MODELAMIENTO DE LA SERIE ####
###El análisis previo nos revela que tenemos que eliminar la 
###tendencia y la estacionalidad de la serie para que pueda ser 
##estacionaria. El modelo que vamos a utilizar es un modelo ARIMA,
###diferenciando la serie lograremos que sea convertida a 
###estacionaria, por lo tanto vamos a ver que nos dice las 
##funciones ndiffs y nsdiffs, que calculan cada una el número de 
##diferenciaciones regulares y estacionales respectivamente que se
##necesita llevar a cabo para que la serie sea estacionaria.
ndiffs(co2ts)
nsdiffs(co2ts)
### eliminamos el componente de tendecias 
diff.co2ts<-autoplot(diff(co2ts), ts.linetype = "dashed", ts.colour = "darkmagenta")
diff.co2ts
###Como podemos ver ahora en la serie ya se ha eliminado
##la componente de tendencia, una ves eliminada esta componente 
##volvemos a gráficar la función de autocorrelación.
autoplot(acf(diff(co2ts), plot = FALSE))
###Podemos apreciar que la serie sigue sin ser estacionaria,
###ya que la función de autocorrelación decrece rápidamente en
##los desfaces regulares de forma lenta en los retardos (12,24,36),
##de forma que no es estacionaria en la parte estacional, además
##nuevamente se vuelve a ver la componente estacional de perido 12.
monthplot(diff(co2ts), col = "midnightblue")
diffco2<-diff(co2ts)
boxplot(diffco2~cycle(diffco2))
##Se puede apreciar que los picos más altos se presentan en los
#meses de marzo y abril, mientras que los picos más bajos se
#presentan en los meses agosto y septiembre. 
diff.co2ts.12<-diff(co2ts, lag = 12)
autoplot(diff.co2ts.12, ts.colour = "darkorange4", ts.linetype = "dashed")
###Una vez eliminado tanto la componente de tendencia y 
##la estacional, observemos que esta serie se parece bastante 
##a una serie estacionaria, ya que parece ser constante en media
##y varianza, para asegurarnos aplicamos un test de estacionariedad
##como el test ADF (Dickey-Fuller) y el test de KPSS (Kwiatkowski-Phillips-Schmidt-Shin).
##H0:  La serie es no estacionaria: tiene raíz unitaria
##H1: La serie es estacionaria: no tiene raíz unitaria
library(tseries)
adf<-adf.test(diff.co2ts.12)
adf$p.value
kpss<-kpss.test(diff.co2ts.12)
kpss$p.value
autoplot(acf(diff.co2ts.12, plot = FALSE))
autoplot(pacf(diff.co2ts.12, plot = FALSE))
####Vistas la gráficas acf y pacf pueden plantear varios modelos 
##tentativos para el análisis, como lo serían los 
###ARIMA(0,1,2)(0,1,1) o ARIMA(1,1,0)(2,1,0) deducidos,
##o realizando una combinación de estos como ARIMA(1,1,2)(2,1,1)) 
##o incluso variando algunos de los componentes como puede ser 
##con ARIMA(1,1,1)(2,1,1)) o ARIMA(1,1,2)(1,1,1)) o
##ARIMA(0,1,1)(0,1,1) o ARIMA(1,1,0)(1,1,0), etc.
library(forecast)
arima1<- Arima(co2ts, order=c(0,1,2), seasonal=list(order=c(0,1,1),period=12))
arima2<- Arima(co2ts, order=c(1,1,0), seasonal=list(order=c(2,1,0),period=12))
arima3<- Arima(co2ts, order=c(1,1,2), seasonal=list(order=c(2,1,1),period=12))
arima4<- Arima(co2ts, order=c(1,1,1), seasonal=list(order=c(2,1,1),period=12))
arima5<- Arima(co2ts, order=c(1,1,2), seasonal=list(order=c(1,1,1),period=12))
arima6<- Arima(co2ts, order=c(0,1,1), seasonal=list(order=c(0,1,1),period=12))
arima7<- Arima(co2ts, order=c(1,1,0), seasonal=list(order=c(1,1,0),period=12))
###Cálculamos los criterios AIC y BIC.
AIC(arima1,arima2,arima3,arima4,arima5,arima6,arima7)
BIC(arima1,arima2,arima3,arima4,arima5,arima6,arima7)
##Aquí se puede apreciar que los ajustes que mejor AIC 
###y BIC presentan son aquellas que solo tienen componente 
##de médias móviles y no tienen componente autorregresiva, 
##siendo ARIMA(0,1,1)(0,1,1) el modelo que los test arrojan 
##con un menor valor y por tanto con una mayor consideración. 
##Una vez estimados los modelos y elegido el mejor de ellos,
##en este caso ARIMA(0,1,1)(0,1,1), se procede a validarlo.
##Para ello en primer lugar se grafican los correlogramas de
##los residuos para comprobar que son ruido blanco:

autoplot(acf(arima6$residuals, plot = FALSE))
autoplot(pacf(arima6$residuals, plot = FALSE))
##Se puede apreciar en los correlogramas que no hay ningún 
##rezago significativo (aparte del 0 del ACF, que es 1 por 
##definición) que denote ningún tipo de estructura, por lo
##tanto podemos decir que los residuos son ruido blanco.
##Ahora, vamos a pintar también una serie de gráficas sobre 
##los residuos:
ggtsdiag(arima6)
bp <- Box.test(arima6$residuals) # Test de Box-Pierce
bp$p.value
lb <- Box.test(arima6$residuals, type="Ljung-Box") # Test de Ljung-Box
lb$p.value
jb <- jarque.bera.test(arima6$residuals) # Test de Jarque-Bera
jb$p.value
sht<-shapiro.test(arima6$residuals) ## Test de Shapiro-Wilk
sht$p.value
##En R existe una función llamada auto.arima que puede calcular 
##automáticamente cuál es la mejor combinación de órdenes para 
##el modelo ARIMA:
auto.arima(co2ts, stepwise = FALSE, approximation = FALSE)
##En este caso la función sugiere que el mejor modelo que
##representa a la serie sería un ARIMA(1,0,1)(0,1,1) con
##tendencia, y que arroja un AIC de 81.16, siendo algo mejor al
##modelo que anteriormente habíamos visto, 83.83
##prediccion de la serie
forecast1<-forecast(arima6, level = c(95), h = 50)
autoplot(forecast1)
