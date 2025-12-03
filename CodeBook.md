Code Book – Getting and Cleaning Data Project

Este documento describe el origen del conjunto de datos, las transformaciones aplicadas y la estructura del resultado final tidy_data.txt, generado por el script run_analysis.R.

1. Origen de los datos

Los datos provienen del estudio:

Human Activity Recognition Using Smartphones
Universidad de California, Irvine (UCI Machine Learning Repository)

Los datos fueron recolectados usando un smartphone Samsung Galaxy S II que capturaba señales del acelerómetro y giroscopio mientras 30 sujetos realizaban 6 actividades:

WALKING

WALKING_UPSTAIRS

WALKING_DOWNSTAIRS

SITTING

STANDING

LAYING

El dataset original contiene:

features.txt — nombres de las 561 variables medidas

activity_labels.txt — nombres descriptivos de actividades

datos de train (70%) y test (30%) divididos en:

X_train.txt / X_test.txt — mediciones

y_train.txt / y_test.txt — código numérico de actividad

subject_train.txt / subject_test.txt — identificador del sujeto

Los datos se distribuyen dentro de la carpeta:
UCI HAR Dataset/

2. Transformaciones realizadas (pasos del script)

El script run_analysis.R realiza las siguientes operaciones:

Paso 1 – Unificación de train y test

Se leen los tres componentes de train y de test.

Se asignan los nombres de las variables desde features.txt.

Se combinan los datos de train y test usando rbind().

Resultado: un dataframe con todos los sujetos, actividades y mediciones.

Paso 2 – Selección de variables de media y desviación estándar

Se filtran únicamente las columnas cuyos nombres contienen:

mean()

std()

Estas representan mediciones de media y desviación estándar de:

aceleración en X, Y, Z

velocidad angular en X, Y, Z

magnitudes combinadas

señales en el dominio del tiempo (t) y de la frecuencia (f)

Paso 3 – Reemplazo de códigos de actividad por nombres descriptivos

El identificador numérico (activityId) se une con activity_labels.txt, generando la columna:

activity
(por ejemplo: STANDING, WALKING, LAYING, etc.)

Paso 4 – Limpieza y estandarización de nombres de variables

Se aplican transformaciones para mejorar la legibilidad:

eliminar ()

reemplazar - por .

cambiar:

^t → Time.

^f → Freq.

Acc → Accelerometer

Gyro → Gyroscope

Mag → Magnitude

BodyBody → Body

El resultado son nombres de variables consistentes y descriptivos, adecuados para un dataset tidy.

Paso 5 – Creación del dataset tidy con promedios

Se agrupa por:

subject

activity

y se calcula el promedio de cada variable numérica seleccionada.

El resultado:

180 filas (30 sujetos × 6 actividades)

más de 60 columnas de variables promedio

Se guarda mediante:

write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

3. Descripción de las variables en el dataset final

Las primeras dos columnas son:

subject

Identificador del sujeto (1 a 30)

activity

Actividad realizada

Posibles valores:

WALKING

WALKING_UPSTAIRS

WALKING_DOWNSTAIRS

SITTING

STANDING

LAYING

4. Variables medidas (todas en formato tidy)

Cada una corresponde al promedio por sujeto y actividad de una de las mediciones originales del acelerómetro/giroscopio.

Ejemplos típicos:

Time.BodyAccelerometer.mean.X

Time.BodyAccelerometer.std.Y

Time.GravityAccelerometer.mean.Z

Time.BodyGyroscope.std.X

Freq.BodyAccelerometer.mean.X

Freq.BodyGyroscope.std.Z

Time.BodyAccelerometerMagnitude.std

Características generales:

Valores normalizados entre -1 y 1

Unidades: aceleración (g) y velocidad angular (rad/s), según las señales originales

Ejes: X, Y, Z

Magnitudes vectoriales (en .Magnitude)

5. Archivo final generado

El archivo final del proyecto es:

tidy_data.txt

Incluye una fila única por combinación de sujeto y actividad y contiene únicamente variables promedio.