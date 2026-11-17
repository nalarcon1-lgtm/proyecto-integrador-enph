# proyecto-integrador-enph
Software para el registro y procesamiento del Cuadernillo 2 de la ENPH - Proyecto Integrador IV

## Contenido

| Carpeta / archivo | Descripción |
|-------------------|-------------|
| `SistemaEncuestas/` | Código fuente del programa (Java Swing + Oracle, proyecto de Apache NetBeans) |
| `SistemaEncuestas.zip` | El mismo proyecto comprimido |
| `base_datos/` | Scripts de Oracle: perfiles, tablas, vistas, procedimientos, disparadores, datos, roles y reportes ([README](base_datos/README.md)) |
| `documentacion/` | Tabla de base de datos del tercer entregable y guía para el documento |
| `diagramas_enph.asta` | Diagramas en Astah |
| `Segundo_Avance_ENPH.docx.pdf` | Documento del segundo avance |

## Ejecución rápida

1. Crear la base de datos con los scripts `base_datos/01` a `07`.
2. Ajustar `SistemaEncuestas/bd.properties` (URL del servidor Oracle).
3. Abrir `SistemaEncuestas` en NetBeans (librería `ojdbc8.jar`) y ejecutar.
4. Usuarios de prueba: `admin / Admin123`, `supervisor1 / Super123`, `encuestador1 / Encu123`.
