#### SERIES DE TIEMPO ####
###link ayudad https://www.itl.nist.gov/div898/handbook/pmc/section4/pmc41.htm
####https://www.itl.nist.gov/div898/handbook/pmc/section4/pmc45.htm

library(forecast)
library(tseries)
library(ggplot2)
prots<-ts(Produccion_departamentos$producido, start = c(2013,1), frequency = 12)
print(prots)
library(ggfortify)
autoplot(prots, ts.colour = "blue", ts.linetype = "dashed")

autoplot(acf(prots, plot = FALSE))

ndiffs(prots)
nsdiffs(prots)
### eliminamos el componente de tendecias 
diff.prots<-autoplot(diff(prots), ts.linetype = "dashed", ts.colour = "darkmagenta")
diff.prots
###Como podemos ver ahora en la serie ya se ha eliminado la componente de tendencia, una ves eliminada esta componente volvemos a gráficar la función de autocorrelación.
autoplot(acf(diff(prots), plot = FALSE))
###Podemos apreciar que la serie sigue sin ser estacionaria, ya que la función de autocorrelación decrece rápidamente en los desfaces regulares de forma lenta en los retardos (12,24,36), de forma que no es estacionaria en la parte estacional, además nuevamente se vuelve a ver la componente estacional de perido 12.
monthplot(diff(prots), col = "midnightblue")
diffpro<-diff(prots)
boxplot(diffpro~cycle(diffpro))
##Se puede apreciar que los picos más altos se presentan en los meses de marzo y abril, mientras que los picos más bajos se presentan en los meses agosto y septiembre. Ahora eliminaremos el componente estacional

diff.prots.12<-diff(prots, lag = 12)
autoplot(diff.prots.12, ts.colour = "darkorange4", ts.linetype = "dashed")

library(tseries)
adf<-adf.test(diff.prots.12)
adf$p.value
kpss<-kpss.test(diff.prots.12)
kpss$p.value
autoplot(acf(diff.prots.12, plot = FALSE))
autoplot(pacf(diff.prots.12, plot = FALSE))

library(forecast)
arima1<- Arima(prots, order=c(0,1,2), seasonal=list(order=c(0,1,1),period=12))
arima2<- Arima(prots, order=c(1,1,0), seasonal=list(order=c(2,1,0),period=12))
arima3<- Arima(prots, order=c(1,1,0), seasonal=list(order=c(2,1,1),period=12))
arima4<- Arima(prots, order=c(1,1,1), seasonal=list(order=c(2,1,1),period=12))
arima5<- Arima(prots, order=c(1,1,2), seasonal=list(order=c(1,1,1),period=12))
arima6<- Arima(prots, order=c(0,1,1), seasonal=list(order=c(0,1,1),period=12))
arima7<- Arima(prots, order=c(1,1,0), seasonal=list(order=c(1,1,0),period=12))
###Cálculamos los criterios AIC y BIC.
AIC(arima1,arima2,arima3,arima4,arima5,arima6,arima7)
BIC(arima1,arima2,arima3,arima4,arima5,arima6,arima7)


autoplot(acf(arima6$residuals, plot = FALSE))
autoplot(pacf(arima6$residuals, plot = FALSE))

ggtsdiag(arima6)
bp <- Box.test(arima6$residuals) # Test de Box-Pierce
bp$p.value
lb <- Box.test(arima6$residuals, type="Ljung-Box") # Test de Ljung-Box
lb$p.value
jb <- jarque.bera.test(arima6$residuals) # Test de Jarque-Bera
jb$p.value
sht<-shapiro.test(arima6$residuals) ## Test de Shapiro-Wilk
sht$p.value

auto.arima(prots, stepwise = FALSE, approximation = FALSE)

forecast1<-forecast(arima6, level = c(13), h = 50)
autoplot(forecast1)

