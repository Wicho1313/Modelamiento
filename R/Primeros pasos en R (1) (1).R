#### Bienvenidos ####
### R es una calculadora ####
4+3

5*4

5+6+7*8

(-1)^(0.5)
(-1+0i)^0.5

#### warning ####

x

#### error ####


10^(-16)
10^100
#### 1e-16 es igual a 1*10^(-16)
#### R tambien hace algebra logica ####
2>1
3<2
3==6
3!=0

3==6
# Nota:
# - NA   : "Not Available", no disponible.
# - NULL : objeto "vac?o"
# - NaN  : "Not a Number", no es un n?mero 

datos=c(1,2,3,NA,5,6)
log(datos)


#### operaciones logicas ####
3>2 | 4/5<7/8 
3>2 | 4/5==7/8 
1>2 | 4/5==7/8


3>2 & 4/5<7/8 
3>2 & 4/5 == 7/8 
1>2 & 4/5 == 7/8


#### Funciones ####

cos(1)
tan(3)
tan(90)
tan(pi/2)
sqrt(6)
6^0.5
6^(1/2)
log(exp(1))

? exp
log(23, pi)
# graficas

curve(sin(x))

curve(sin(x), from=0, to=2*pi)

abline(h=0)

abline(v=0)

abline(a=0, b=1)

abline(a=4, b=-1)
warnings()
 abline(a=3, b=-1, col=5)
 abline(a=2, b=-1, col="red")
 abline(a=2, b=1, col=red)
 
 #### vectores de datos ####
 
x=c(1,2,3,4,5,6) 
str(x)# este comando muestra qeu tipo de variable es
sum(x)

length(x)
 
sum(x)/length(x)

mean(x)


5*x

y=exp(x)
y1<-exp(x)
exp(x)->y2


sin(x)

x>3

x[x>3]

x[x>2 & x<5]

x[x>2 & x<=5]
x[x<=2 & x>=5]

z=c("S", "S", "D", "D")
zz=as.factor(z)
z[z=="S"]
z[z=="M"]

v1=c(1,2,3,4,5,6)
v2=c("S", "S", "D", "D", "S", "D")

v2[v1==2]
v2[v2=="S" & v1<2]

y=cos(x)
y

acos(y)

x+3

z=x+3

z^2

#### Algebra lineal
### Escribir una matriz
unamatriz=matrix(c(2,2,3,4,5,6,7,8,9), ncol=3, nrow=3, byrow=T)

unamatriz

### Operaciones basicas
det(unamatriz)
eigen(unamatriz)
svd(unamatriz)
chol(unamatriz) ### La matriz no es definida positiva
###Transpuesta

t(unamatriz)


###Un vector fila
unvector=c(1,2,3)

### No funciona como producto
unvector*unamatriz

### Producto de matrices
unvector%*%unamatriz

### Una definida positiva
t(unamatriz)%*%unamatriz

chol(t(unamatriz)%*%unamatriz)

a=t(unamatriz)%*%unamatriz

chol(a)
### Inversa
solve(a)

b=matrix(1:9, ncol=3)
b
solve(b)

#### Inversa generalizada

ginv(b)

###Debemos cargar el paquete MASS
library(MASS)

ginv(b)
c=ginv(b)
c%*%b%*%c

b%*%c%*%b

### Sistemas de ecuaciones Ax=b

A=matrix(c(2,3,4,5,8,9,100,20,30), ncol=3, byrow=T) 
x=c(1,2,3)

solve(A,x)

solve(b,x)

solve(A,b)

#### trabajo con las bases de ####
datos1=Mundial_variables
summary(datos1)




