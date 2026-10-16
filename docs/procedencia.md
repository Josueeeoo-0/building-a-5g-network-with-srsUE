# Procedencia y verificación

[Volver al tutorial](../README.md)

## Material recibido

- 29 capturas de instalación de Open5GS, 15 de OCUDU y 7 de srsRAN 4G: **51** en total, revisadas en orden numérico.
- 29 capturas anteriores del mapa mental, configuración y pruebas de conexión.
- Seis archivos finales desde la VM: `amf.yaml`, `nrf.yaml`, `smf.yaml`, `upf.yaml`, `gnb_zmq.yaml` y `ue_zmq.conf`.
- Texto de asistencia compartido por el autor, usado como contexto y contrastado con los archivos. No se distribuye el chat privado en el repositorio.

La [galería](evidencias.md) conserva el orden de cada carpeta. `evidence-manifest.json` registra los nombres originales y SHA-256 de las imágenes y de las configuraciones. Los archivos de `config/` conservan los bytes entregados; `.gitattributes` evita que Git transforme sus saltos de línea.

## Datos consolidados

| Cuestión | Fuente que resuelve la duda |
|---|---|
| ¿5 o 10 MHz? | `config/gnb_zmq.yaml`: 5 MHz; `config/ue_zmq.conf`: 25 PRB; captura de conexión 26: `bw=5 MHz`. |
| ¿Se añadieron las opciones SSB del chat? | No aparecen en el archivo final. Se comprobaron las opciones reconocidas en el código del commit de srsUE. |
| ¿IP N3 del UPF? | `config/open5gs/upf.yaml`: GTP-U en 127.0.0.7. |
| ¿N4 SMF/UPF? | `smf.yaml`: servidor PFCP 127.0.0.4, cliente UPF 127.0.0.7; `upf.yaml`: servidor PFCP 127.0.0.7. |
| ¿NRF directo o SCP? | AMF y SMF tienen SCP activo en 127.0.0.200:7777; NRF directo está comentado. |
| ¿Qué binario UE? | Capturas de instalación: antiguo 23.4.0 en PATH; nuevo 25.10.0 en el árbol de compilación. |
| ¿DragonOS equivale a Ubuntu Focal? | No se asume: APT muestra Jammy. Falta una captura de `/etc/os-release`, por eso la guía exige comprobarlo antes de añadir repositorios. |

## Orden y fidelidad de los comandos

El README corregido respeta la secuencia de las carpetas recibidas. Para el core: **MongoDB → Node.js → Open5GS → WebUI**. Después continúa con OCUDU, la actualización srsRAN 4G y los pasos de conexión.

Se restauran los comandos fotografiados: `apt-get` donde así aparece, `start` y `status` para MongoDB, los instaladores `curl | sudo -E bash -`, la comprobación inicial de `release_23_11` y el cambio a `master`, `cmake ..`, `cmake --build . -j"$(nproc)"`, edición del core con `nano` e `ip route add`.

Los intentos fallidos de PPA y DNS se identifican en su lugar cronológico. No se presentan como pasos exitosos ni se ejecutan aquí. Las consultas decorativas con `echo` no son necesarias para reproducir los comandos de inspección.

## Complementos separados

1. La importación de la clave MongoDB, ausente de las capturas, se identifica como complemento previo necesario si falta el keyring.
2. La consulta adicional de la base del sistema se etiqueta antes de añadir repositorios.
3. Los checkouts por SHA, la preparación adicional de dependencias, el inicio automático MongoDB, la copia automatizada de YAML, `ip route replace` y las pruebas iPerf3 propuestas están separados en [complementos](complementos.md).
4. La eliminación recursiva previa al clon srsRAN se registra como historial, no como un requisito de instalación sobre una carpeta existente.
5. Los heredocs del README crean los archivos con sus **valores finales** de 5 MHz; no reproducen como configuración definitiva los valores iniciales fallidos de 20 o 10 MHz.
6. Los argumentos completos del cliente iPerf3 no son visibles. El README lo indica y ofrece un comando mínimo de ejemplo, sin atribuirle una transcripción inexistente.

Las capturas se conservan en la galería separada. El README es un tutorial práctico sin referencias a su numeración y muestra únicamente la figura oficial, incluida como `assets/ocudu-zmq.jpg`. La ubicación e inserción se describen en [imágenes](imagenes.md).

## Alcance de la comprobación

La edición se revisó con herramientas deterministas para comprobar sintaxis YAML/INI, coherencia de tasas/puertos/PLMN/TAC/pool, integridad de los seis archivos, enlaces y recursos locales, opciones del parser de srsUE y sintaxis del script Bash. El informe está en [VERIFICACION.md](../VERIFICACION.md).

No se compiló OCUDU/srsUE en Windows ni se ejecutaron los servicios de la VM durante esta preparación. Las evidencias de compilación y conexión pertenecen a la ejecución del autor. Las imágenes no prueban una instalación limpia automatizada ni un benchmark prolongado.

## Fuentes externas

- [Tutorial oficial de OCUDU](https://docs.ocudu.org/tutorials/srsue/).
- [Instalación de OCUDU](https://docs.ocudu.org/user_manual/installation/).
- [Open5GS Quickstart](https://open5gs.org/open5gs/docs/guide/01-quickstart/).
- [Opciones de srsUE en la revisión fijada](https://github.com/srsran/srsRAN_4G/blob/bef8680d5f9714f3e040e6f9cbc88d7888439b6d/srsue/src/main.cc).
- [Commit OCUDU fijado](https://gitlab.com/ocudu/ocudu/-/commit/b78d09a77ab060cda752f32483e551f1e9132f66).
- [Node.js: estado de ramas](https://nodejs.org/en/about/previous-releases).
- [Repositorio de referencia editorial](https://github.com/devopsjourney23/my-srsproject-demo).

Los comentarios y ejemplos que acompañan los YAML de Open5GS proceden de sus plantillas. Cada software externo mantiene su licencia propia; no se redistribuye su implementación en este repositorio.
