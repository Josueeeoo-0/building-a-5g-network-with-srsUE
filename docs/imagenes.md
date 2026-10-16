# Dónde colocar la figura oficial

[Volver al tutorial](../README.md)

El README muestra únicamente la figura oficial de arquitectura. Las 80 imágenes originales siguen en `images/` y se pueden consultar en la [galería](evidencias.md), sin insertarse en el tutorial principal.

## Archivo para la portada

La figura de la sección **ZeroMQ-based Setup** del [tutorial oficial de OCUDU](https://docs.ocudu.org/tutorials/srsue/) está incluida con esta ruta relativa a la raíz del repositorio:

```text
assets/ocudu-zmq.jpg
```

El nombre exacto es **ocudu-zmq.jpg**. Usa una imagen realmente guardada o exportada como JPEG; cambiar solamente la extensión de un PNG no lo convierte a JPG.

## Inserción activa en el README

El README ya contiene estas líneas activas:

```markdown
![Arquitectura ZeroMQ de OCUDU](assets/ocudu-zmq.jpg)

Fuente de la figura: [tutorial oficial de OCUDU](https://docs.ocudu.org/tutorials/srsue/).
```

La versión anterior tenía solo un comentario con el espacio reservado: copiar el JPG no activaba su visualización. Esta edición incluye tanto el archivo como la inserción Markdown, por lo que no necesitas editar el README para que aparezca.

Al subir el tutorial, conserva `README.md` en la raíz y `ocudu-zmq.jpg` dentro de `assets/`. Comprueba que Git incluya ambos con `git status`; en GitHub las mayúsculas y minúsculas del nombre deben coincidir.

La figura resume la arquitectura general. Los valores de esta VM se explican en el texto y en los archivos de configuración.

Los diagramas de la edición anterior permanecen en `assets/arquitectura.png` y `assets/arquitectura.pdf` como archivos separados, sin aparecer en el README.
