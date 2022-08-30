
# Seteamos el directorio de trabajo
# Que es el lugar desde donde se cargarán los datos 

# Script PCA
# El principal obejtivo de este anális es determinar cual de mis variables está
# otorgando más variabilidad a los datos (al resultado). Esto permite definir cual 
# es la variable que más efecto tiene sobre mi resultado y descartar con ellos 
# aquellas que no tienen efecto, porque no generan variación.
# Un PCA también permite determinar cuales factores están correlacionados y 
# poder asociarlos en grupos.
# Este análisis es un método de aprendizaje no supervisado (no hay conocimiento
# previo sobre las variables) el cual no pretende
# predecir, sino que extraer información sobre las variables en si mismas.
# Es un modelo de tipo matemático y no estadístico, esto significa por ejemplo, que
# no tiene pvalue asociados y no es fácil de comprender matemáticamente.


setwd("C:/Users/ruthc/Desktop/UDD/Scripts")

# Como el archivo es un csv, se lee con un read csv
# row.names=1 Indica que la columna 1 se debe asignar como nombre de las filas
# al hacer esto R las mantiene pero no las toma en cuenta para ningún cálculo.
expresion = read.csv("pca.csv", row.names = 1)
View(expresion)

# Como lo que se pretende medir es cuanto varía nuestra lectura con cada variable.
apply(expresion,2,var)

#Con esto noto que la variable que mÃ¡s cambios genera en cada gen es
#NaCl. Sin embargo:

    # Problema 1: Las variables tienen distintas magnitudes
    # Problema 2 : Debemos reconocer que las muestras provienen de distintos
                        #tratamientos por lo que no son comparables.

    # SOLUCION: Centrar la media = Indica el numero de desviaciones estandar 
                                    #que un numero se situa por encima o por abajo 
                                    #de la media. Por tanto aca la media es el valor 0.
                                    #El centrado de la media se realiza de la stge forma: (x-u)/DE
                                    #Con esto reduzco la variabilidad a D.E y no a valores concretos que pueden estar
                                    #"sucios" por las magnitudes.

# Siempre se recomienda usar center = T y scale =TRUE
# (x-u)/DE
# Donde center=T : Restar el promedio
# scale = T : Dividir por la DE.

expresion.pca <- prcomp(expresion, center = TRUE,scale = TRUE)

# Muestro el resultado por consola
expresion.pca


#Me entrega los valores de la desviacion estandar de los 7 PCA.
# Y abajo vemos la matriz de rotacion 
#que indica los coeficientes de las combinaciones lineales de las variables continuas

# Cada columna PC es el espacio que explica o captura mas la variabilidad.
# ¿Que variabilidad? La variabilidad en la expresion de genes, por ejemplo.


#Ploteamos las varianzas
plot(expresion.pca, type = "l", main = "Componentes principales",xlab="X-axis label")

#No existe un metodo para seleccinar con que PC quedarse.
# Pero se puede usar la "Regla del codo", que indica quedarse con los PC
# anteriores a la primera inflexión fuerte del gráfico. En este caso
# el componente principal 3 podría indicarse como el punto de inflexión
# fuerte del gráfic o codo.

# Otra forma de decidir y de analizar de forma cuantitativa los datos es
# hacer un summary de las combinaciones lineales, con esto se puede
# visualizar la proporcion de la varianza que explica cada componente.
summary(expresion.pca)
#La fila "Cumulative Proportion" nos puede ayudar a seleccionar los PC
# Un limite es utilizar hasta el PC que explique un 80% o 90%


#También podemos ver el resultado en un gráfico, que por default te muestra
# el PCA 1 y PCA2
# Además también indica qué variables se relacionan con tus datos.
# Por ejemplo, el gráfico nos dice  el gen 30 está altamente relacionado con la el Ph=5
# simplemente porque se ven cercanos.
biplot(expresion.pca, scale =1)

# Al hacer el biplot anterior scale permite hacer compensaciones para que distintas 
# medidas no tengan mayor peso en la comparación.
# Scale=0, no compensa nada
# Cuando escala = 1, el producto interno entre las variables se 
# aproxima a la covarianza y la distancia entre los puntos se aproxima 
# a la distancia de Mahalanobis. Esto último significa que se están dando
# igual importancia tanto a las medidas pequeñas como a las grandes.


##########################################################################
#Otra forma de hacer un PCA (de mejor calidad de diseño) es usando
#la librería ggbiplot, que es específica para hacer biplot
library(ggbiplot)

#Esta línea es igual que la de arriba, calculo las combinaciones lineales.
wine.pca <- prcomp(expresion, scale. = TRUE)

# cargo el vector que contiene los datos
 ggbiplot(wine.pca, scale = 1) +
  scale_color_discrete(name = 'PCA - Prueba') +
  theme(legend.direction = 'horizontal', legend.position = 'top')

 
 
# Otro ejemplo con datos distintos
# Se utilizarán los datos wine que corresponde a:
?wine
 
# Hacemos el llamado a los datos
data(wine)
# Calculamos 
wine.pca <- prcomp(wine, scale. = TRUE)
 
 ggbiplot(wine.pca, scale = 1,
          #Ellipse encierra los grupos (si se han declarado grupos) 
          # en una elipse normal
          groups = wine.class, ellipse = TRUE) +
   scale_color_discrete(name = '') +
   theme(legend.direction = 'horizontal', legend.position = 'top')
 