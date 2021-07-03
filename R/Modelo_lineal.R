#### Ajustar un modelo lineal a Protina 
library(ggplot2)

ggplot(Hepatitis,aes(x=Edad, y=Protina))+geom_point()

ggplot(Hepatitis,aes(x=Sexo, y=Protina))+geom_boxplot()

ggplot(Hepatitis,aes(x=Esteroides, y=Protina))+geom_boxplot()

ggplot(Hepatitis,aes(x=Antivirales, y=Protina))+geom_boxplot()
ggplot(Hepatitis,aes(x=Fatiga, y=Protina))+geom_boxplot()
ggplot(Hepatitis,aes(x=Malestar, y=Protina))+geom_boxplot()
ggplot(Hepatitis,aes(x=Anorexia, y=Protina))+geom_boxplot()
ggplot(Hepatitis,aes(x=`Higado Grande`, y=Protina))+geom_boxplot()

ggplot(Hepatitis,aes(x=Billirubina, y=Protina))+geom_point()

ggplot(Hepatitis,aes(x=Fosfato, y=Protina))+geom_point()

ggplot(Hepatitis,aes(x=SGOT, y=Protina))+geom_point()


ggplot(Hepatitis,aes(x=Albumina, y=Protina))+geom_point()


ggplot(Hepatitis,aes(x=Histologia, y=Protina))+geom_boxplot()


modelo=lm(Protina~Albumina, data=Hepatitis)
summary(modelo)

modelo=lm(Protina~Albumina+Sexo, data=Hepatitis)
summary(modelo)


modelo=lm(Protina~Albumina+Sexo+Antivirales, data=Hepatitis)
summary(modelo)


modelo=lm(Protina~Albumina*Sexo, data=Hepatitis)
summary(modelo)

predict(modelo, newdata =data.frame(Albumina=c(0,2,3,4),
  Sexo=c("Mujer","Hombre", "Mujer", "Hombre")),
  interval = "prediction")

ggplot(Hepatitis, aes(x=Albumina, y=Protina, colour=Sexo))+
  geom_smooth()

