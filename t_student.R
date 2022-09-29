# Programa para implementar un análisis de t-student
# Este programa compara dos grupos, el grupo a y b

# Instrucciones:

# Creamos el grupo A
a=c(355,345,353,242,144,234,242,245,532)
# Creamos el grupo B
b=c(2,3,4,5,6,7,8,9,10)
t.test(a,b)

# Resultado:
# p-value = 4.934e-05
# Los grupos son distintos-
# O correctamente dicho: Las diferencias entre los datos 
# tienen una probabilidad de 4.934e-05
# de ser efecto del azar.