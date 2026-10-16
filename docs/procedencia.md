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

## Ajustes editoriales al procedimiento

Estos cambios mejoran la repetición, pero no se presentan como comandos históricos fotografiados:

1. Se completa la importación de la clave pública de MongoDB que faltaba en las imágenes.
2. Se añade `enable --now` para MongoDB; la captura lo mostraba activo pero no habilitado al arranque.
3. Se descargan los instaladores de Node/WebUI a un archivo antes de ejecutarlos, en lugar de una tubería `curl | bash`.
4. Se fijan los commits completos de OCUDU y srsRAN 4G. Se resolvieron a partir de los identificadores de las capturas mediante las APIs públicas de sus repositorios.
5. Se omite el checkout inicial de `release_23_11`, ya que la compilación que se usó después fue la revisión de `master` indicada en `versions.json`.
6. Se hace explícito `Release` y ZeroMQ para construir srsUE; se propone `-j2` en lugar del paralelismo ilimitado respecto de la RAM disponible.
7. No se repite la eliminación recursiva del árbol `srsRAN_4G_ocudu` que aparece antes del clon histórico. Se indica partir de un directorio nuevo o inspeccionar el existente.
8. Se usa una copia de seguridad fechada antes de instalar configuraciones del core.
9. Se usa `ip route replace` en lugar de `add` para poder repetir la ruta.
10. Se proponen pruebas iPerf3 completas y moderadas, separadas de los resultados parciales históricos.

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
