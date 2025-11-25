# bigdata2025_2_2
Realización de actividades del curso Bigdata 

Evidencia de Aprendizaje 2 

Descripción 
Este proyecto implementa un flujo completo de:

Ingesta de datos
Procesamiento con Spark
Validación técnica
Consultas SQL
Persistencia en Delta Tables
Gestión usando Unity Catalog

Arquitectura del Proyecto
Diseño del esquema
Creación de tablas
Ingesta desde Kaggle + carga manual
Validación de metadatos
Consultas con SQL y Spark



Diagrama Unity Catalog utilizado en el proyecto:

Esquema

DDL del Esquema (Spark SQL)

DDL.sql
Archivo DDL.sql

CONFIGURACIÓN DE DATABRICKS
Creación y Configuración del Cluster
Parámetros usados:

Runtime 15.4 LTS
Python 3.10
Autoscaling

4 vCPU / 16GB RAM

Verificación de Versiones

El notebook imprime:

spark.version
sys.version

Estructura de Almacenamiento

Se usan:

Unity Catalog → Catálogo + Schema
Volumes → Ruta por defecto
DBFS → /Ventas/Ventas_viviendas/ventas_schema/viviendas/

Obtención de Datos de Kaggle

Configuración de credenciales
Funciones para descargar datasets
Extracción y lectura del CSV
Conversión de Pandas → Spark DataFrame

Ingesta del Dataset
Carga manual del CSV
Archivo CSV cargado a Volumes.

Lectura con Spark
spark.read.csv(path, header=True, inferSchema=True)

Persistencia
Tabla temporal

Tabla administrada en Unity Catalog
Tabla  final tbl_ventas

Validaciones y Análisis
Metadatos
DESCRIBE TABLE
DESCRIBE DETAIL

SHOW CREATE TABLE

Estadística descriptiva
Comparación SQL vs Spark.

Consultas analíticas
Se ejecutaron consultas:

COUNT(*)

SELECT * LIMIT n

Exploración inicial del dataset

SQL VS SPARK: Ventajas y Desventajas
Spark
Procesamiento distribuido
Ideal para volúmenes grandes
Mejor rendimiento en ETL

SQL

Más simple para analítica
Fácil de entender y mantener
Más declarativo
Cómo Ejecutar el Proyecto
Clonar repositorio
Crear cluster
Crear catálogo + schema
Crear Volume
Subir CSV
Ejecutar notebook
