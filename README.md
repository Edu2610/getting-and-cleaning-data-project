Getting and Cleaning Data – Course Project

Este repositorio contiene el proyecto final del curso Getting and Cleaning Data (Coursera – Johns Hopkins University).
El objetivo es tomar el conjunto de datos Human Activity Recognition Using Smartphones y producir un conjunto de datos ordenado (tidy data) que resuma las mediciones de acelerómetro y giroscopio por sujeto y actividad.

Contenidos del repositorio
Archivo	Descripción
run_analysis.R	Script principal que procesa los datos crudos y genera tidy_data.txt.
tidy_data.txt	Conjunto de datos final en formato tidy, con promedios por sujeto y actividad.
CodeBook.md	Explicación detallada de variables, transformaciones y estructura del dataset final.
UCI HAR Dataset/	Datos originales sin modificar (carpeta opcional, no siempre subida a GitHub).
README.md	Este archivo, explica cómo reproducir el análisis.
Pasos que realiza run_analysis.R

Fusiona los datasets de entrenamiento (train) y prueba (test).

Extrae solo las variables que contienen mean() o std().

Reemplaza códigos numéricos de actividad por nombres descriptivos.

Limpia y transforma los nombres de variables para que sean más legibles.

Calcula el promedio de cada variable para cada combinación de sujeto y actividad.

Genera tidy_data.txt como resultado final.

Toda la lógica del proyecto está implementada de forma reproducible.

Cómo reproducir el análisis

Descargar el conjunto de datos original del curso y descomprimirlo en la misma carpeta donde se encuentra run_analysis.R, de modo que exista:

UCI HAR Dataset/


Instalar el paquete dplyr si es necesario:

install.packages("dplyr")


Ejecutar el script:

source("run_analysis.R")


Se generará un archivo nuevo:

tidy_data.txt


Este archivo contiene una fila por cada combinación (sujeto, actividad) y el promedio de cada medición.

Estructura del dataset final

30 sujetos

6 actividades

Más de 60 variables promediadas

180 filas en total

Notas

Este proyecto sigue estrictamente los criterios de evaluación del curso:

✔ Dataset tidy
✔ Script reproducible
✔ CodeBook descriptivo
✔ README claro
✔ Trabajo completo en GitHub