# Dónde colocar la figura oficial

[Volver al tutorial](../README.md)

El README está preparado sin imágenes insertadas. Las 80 capturas originales siguen en `images/` y se pueden consultar en la [galería](evidencias.md).

## Archivo para la portada

Guarda la figura de la sección **ZeroMQ-based Setup** del [tutorial oficial de OCUDU](https://docs.ocudu.org/tutorials/srsue/) con esta ruta relativa a la raíz del repositorio:

```text
assets/ocudu-zmq.jpg
```

El nombre exacto es **ocudu-zmq.jpg**. Usa una imagen realmente guardada o exportada como JPEG; cambiar solamente la extensión de un PNG no lo convierte a JPG.

## Espacio reservado en el README

Al principio del README hay un comentario que dice `FIGURA PRINCIPAL RESERVADA`. Cuando hayas añadido el JPG, reemplaza ese comentario y el párrafo del espacio reservado por estas líneas:

```markdown
![Arquitectura ZeroMQ de referencia de OCUDU](assets/ocudu-zmq.jpg)

Fuente: [tutorial oficial de OCUDU](https://docs.ocudu.org/tutorials/srsue/).
```

Ese bloque es una instrucción para editar el README en el futuro; el JPG aún no se incluye ni se intenta mostrar ahora. La figura oficial resume la arquitectura general: los valores específicos de esta VM se explican en el texto y las configuraciones.

Los diagramas de la edición anterior permanecen en `assets/arquitectura.png` y `assets/arquitectura.pdf` como archivos separados, sin aparecer en el README.
