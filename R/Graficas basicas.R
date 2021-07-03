#### Graficas en R ####
# Instalar ggplot2 
# Cargar mundial variables
boxplot(Mundial_variables$Alfabetizacion)
hist(Mundial_variables$Alfabetizacion)

a=hist(Mundial_variables$Alfabetizacion)
a

### COn ggplot 2
library(ggplot2)

#### Forma aburrida
ggplot(Mundial_variables, aes(x=Religion))

ggplot(Mundial_variables, aes(x=Religion))+geom_bar()

#### Forma menos aburrida

grafica=ggplot(Mundial_variables, aes(x=Religion))+geom_bar()

## Titulos
grafica+xlab("Religion del país")+ylab("Número de paises")+
  ggtitle("Gráfico de barras")


### Color y demas

grafica=ggplot(Mundial_variables, aes(x=Religion))+
  geom_bar(width=0.8, colour="red", fill="blue")

grafica+xlab("Religion del país")+ylab("Número de paises")+
  ggtitle("Gráfico de barras")

### Mas opciones

grafica=ggplot(Mundial_variables, aes(x=Religion))+
  geom_bar(width=0.8, colour="red", fill="blue")

grafica+xlab("Religion del país")+ylab("Número de paises")+
  ggtitle("Gráfico de barras")

grafica+xlab("Religion del país")+ylab("Número de paises")+
  ggtitle("Gráfico de barras por paises Gráfico de barras por paises Gráfico de barras por paises ")

grafica+xlab("Religion del país")+ylab("Número de paises")+
  ggtitle("Gráfico de barras por paises Gráfico de barras
          por paises Gráfico de barras por paises ")
grafica+xlab("Religion del país")+ylab("Número de paises")+
  ggtitle("Gráfico de barras por paises Gráfico de barras \n por paises Gráfico de barras por paises ")


### Como quito los NA

grafica=ggplot(Mundial_variables[is.na(Mundial_variables$Religion)==F,],
               aes(x=Religion))+
  geom_bar(width=0.8, colour="red", fill="blue")

grafica+xlab("Religion del país")+ylab("Número de paises")+
  ggtitle("Gráfico de barras")

### Histograma

grafica=ggplot(Mundial_variables, aes(x=Alfabetizacion))
grafica+geom_histogram()

### Dividir en grupos preestablecidos (cada 10%)
grafica+geom_histogram(binwidth = 10, 
               fill="red", colour="black")
grafica+geom_histogram(binwidth = 10, 
                       fill="red", colour="black", na.rm=T)


##### Graficas con una base mas bonita ####
## Cargar hepatitis

grafica=ggplot(Hepatitis, aes(x=Sexo))

grafica+geom_bar()

grafica+geom_bar(fill="firebrick", colour="hotpink2")+
  ylab("Conteo")
### Con porcentajes 
grafica+geom_bar(aes(y = (..count..)/sum(..count..)))


grafica+geom_bar(aes(y =100*(..count..)/sum(..count..)),
                 fill="firebrick", colour="hotpink2")
#### Colocale titulos 

#### Graficas bivariadas ####

grafica=ggplot(Hepatitis,aes(x=Sexo, fill=Esteroides))

grafica+geom_bar()

grafica+geom_bar(position = "dodge")

### Como quito NAs 

grafica=ggplot(Hepatitis[is.na(Hepatitis$Esteroides)==F,],aes(x=Sexo))

grafica+geom_bar()


### Agregar mas cosas
grafica=ggplot(Hepatitis,aes(x=Sexo, fill=Esteroides))

grafica+geom_bar()


grafica+geom_bar(position = "dodge")

grafica+geom_bar(position = "dodge")+ylab(NULL)

grafica+geom_bar(position = "dodge")+facet_grid(Clase ~.)

grafica+geom_bar(position = "dodge")+facet_grid(.~Clase)


#### Histogramas 

grafica=ggplot(Hepatitis, aes(x=SGOT))
grafica+geom_histogram()
1+log(152, 2)
(max(Hepatitis$SGOT)-min(Hepatitis$SGOT))/8

grafica+geom_histogram(binwidth = 81)

### Por sexo
grafica=ggplot(Hepatitis, aes(x=SGOT, fill=Sexo))
grafica+geom_histogram(binwidth = 81)

### Forma 2 

grafica=ggplot(Hepatitis, aes(x=SGOT))
grafica+geom_histogram(binwidth = 81)+facet_grid(.~Sexo)
grafica+geom_histogram(binwidth = 81)+facet_grid(Sexo~.)

#### Densidades

grafica=ggplot(Hepatitis, aes(x=SGOT))
grafica+geom_density()
grafica+geom_density()+facet_grid(.~Sexo)


grafica=ggplot(Hepatitis, aes(x=SGOT, fill=Sexo))
grafica+geom_density()

#### Boxplot
grafica=ggplot(Hepatitis, aes(y=Albumina))
grafica+geom_boxplot()

grafica=ggplot(Hepatitis, aes(y=Albumina, fill=Sexo))
grafica+geom_boxplot()

grafica=ggplot(Hepatitis, aes(x=Sexo, y=Albumina))
grafica+geom_boxplot()

grafica=ggplot(Hepatitis, aes(y=Albumina, fill=Sexo))
grafica+geom_boxplot()+facet_grid(.~Clase)


### Graficos de dispersion

grafica=ggplot(Hepatitis, aes(x=SGOT, y=Albumina))
grafica+geom_point()

grafica+geom_point()+facet_grid(.~Sexo)


grafica+geom_point(aes(colour=Sexo))

grafica+geom_point(aes(colour=Protina))


grafica+geom_point(aes(colour=Sexo))+geom_smooth()

grafica+geom_point(aes(colour=Sexo))+geom_smooth(method="lm")


grafica+geom_point()+geom_smooth(method="lm")+facet_grid(.~Clase)


### 
flores=iris

grafica=ggplot(flores, aes(x=Sepal.Length, y=Sepal.Width))

grafica+geom_point(aes(colour=Petal.Width))+facet_grid(~Species)+geom_smooth()
