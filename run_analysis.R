## Getting and Cleaning Data - Course Project
## -----------------------------------------
## Este script:
## 1) Une los datos de train y test
## 2) Extrae solo variables de mean() y std()
## 3) Usa nombres descriptivos de actividad
## 4) Limpia los nombres de las variables
## 5) Crea un tidy data set con el promedio por sujeto y actividad
##    y lo guarda en tidy_data.txt

library(dplyr)

## Ruta donde está la carpeta "UCI HAR Dataset"
dataPath <- "UCI HAR Dataset"

## 1. Leer metadata: features y labels de actividades
features  <- read.table(file.path(dataPath, "features.txt"),
                        col.names = c("id", "name"))
activities <- read.table(file.path(dataPath, "activity_labels.txt"),
                         col.names = c("id", "activity"))

## 2. Leer datos de TRAIN
x_train <- read.table(file.path(dataPath, "train", "X_train.txt"))
y_train <- read.table(file.path(dataPath, "train", "y_train.txt"),
                      col.names = "activityId")
subject_train <- read.table(file.path(dataPath, "train", "subject_train.txt"),
                            col.names = "subject")

## 3. Leer datos de TEST
x_test <- read.table(file.path(dataPath, "test", "X_test.txt"))
y_test <- read.table(file.path(dataPath, "test", "y_test.txt"),
                     col.names = "activityId")
subject_test <- read.table(file.path(dataPath, "test", "subject_test.txt"),
                           col.names = "subject")

## 4. Asignar nombres de columnas a X_train y X_test
colnames(x_train) <- features$name
colnames(x_test)  <- features$name

## 5. Unir columnas de cada conjunto y luego unir filas (paso 1)
train_data <- cbind(subject_train, y_train, x_train)
test_data  <- cbind(subject_test,  y_test,  x_test)

full_data <- rbind(train_data, test_data)

## 6. Extraer solo columnas con mean() o std() (paso 2)
mean_std_idx <- grep("mean\\(\\)|std\\(\\)", features$name)

## En full_data las dos primeras columnas son subject y activityId,
## por eso sumamos 2 a los índices de features
cols_to_keep <- c(1, 2, mean_std_idx + 2)

meanStd_data <- full_data[, cols_to_keep]

## 7. Usar nombres descriptivos de actividad (paso 3)
meanStd_data <- merge(meanStd_data, activities,
                      by.x = "activityId", by.y = "id",
                      all.x = TRUE)

## Reordenar columnas: subject, activity, y luego el resto
meanStd_data <- meanStd_data %>%
  dplyr::select(subject, activity, dplyr::everything(), -activityId)

## 8. Limpieza de nombres de variables (paso 4)
names(meanStd_data) <- gsub("\\()", "", names(meanStd_data))
names(meanStd_data) <- gsub("-", ".", names(meanStd_data))
names(meanStd_data) <- gsub("^t", "Time.", names(meanStd_data))
names(meanStd_data) <- gsub("^f", "Freq.", names(meanStd_data))
names(meanStd_data) <- gsub("Acc", "Accelerometer", names(meanStd_data))
names(meanStd_data) <- gsub("Gyro", "Gyroscope", names(meanStd_data))
names(meanStd_data) <- gsub("Mag", "Magnitude", names(meanStd_data))
names(meanStd_data) <- gsub("BodyBody", "Body", names(meanStd_data))

## 9. Crear tidy dataset con promedio por sujeto y actividad (paso 5)
tidy_data <- meanStd_data %>%
  group_by(subject, activity) %>%
  summarise(dplyr::across(where(is.numeric), mean), .groups = "drop")

## 10. Guardar el resultado en un archivo de texto
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
