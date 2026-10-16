# Subir el tutorial a tu GitHub

[Volver al tutorial](../README.md)

La carpeta `dragonos-5g-sa-zmq` contiene los archivos que deben quedar en la raíz de tu repositorio. No subas la carpeta contenedora `output`, la carpeta temporal de trabajo ni la carpeta oculta `.git` usando el navegador.

## Opción A: navegador

1. Crea un repositorio vacío en tu cuenta. Nombre sugerido: **dragonos-5g-sa-zmq**.
2. Descripción sugerida: **Tutorial de red 5G SA en DragonOS con Open5GS nativo, OCUDU y srsUE sobre ZeroMQ, a 5 MHz.**
3. Elige la visibilidad que prefieras y crea el repositorio sin README inicial.
4. Pulsa **uploading an existing file** o **Add file → Upload files**.
5. Arrastra el contenido de la carpeta del tutorial, manteniendo subcarpetas. Incluye `README.md`, `config`, `docs`, `images`, `assets`, `scripts`, `versions.json`, `evidence-manifest.json` y `VERIFICACION.md`.
6. Añade un mensaje, por ejemplo `Documentar laboratorio 5G SA con ZeroMQ`, y confirma la carga.
7. Abre el README en GitHub y comprueba la figura, los archivos de configuración y algunos enlaces de la galería.

Si tu navegador no conserva carpetas al arrastrarlas, usa Git o GitHub Desktop. Son menos propensos a perder la estructura de las 80 imágenes.

## Opción B: Git

Los comandos siguientes son ejemplos para Bash con Git instalado. Ejecútalos dentro de la carpeta **del tutorial**, no en otra carpeta de proyectos:

```bash
git init -b main
git add .
git diff --cached --stat
git status
git commit -m "Documentar laboratorio 5G SA con ZeroMQ"
```

Si la carpeta ya está inicializada, omite `git init`. No se han creado commits ni publicado un remoto como parte de la preparación de estos archivos.

Crea el repositorio vacío en GitHub y copia su URL HTTPS. Sustituye el ejemplo con **tu usuario y el nombre real**:

```bash
git remote add origin https://github.com/TU_USUARIO/dragonos-5g-sa-zmq.git
git push -u origin main
```

GitHub puede pedir autenticación mediante el gestor de credenciales o tu configuración de acceso. No escribas tokens dentro del README ni de la URL del remoto.

## Estructura esperada

```text
dragonos-5g-sa-zmq/
├── README.md
├── VERIFICACION.md
├── versions.json
├── evidence-manifest.json
├── .gitattributes
├── .gitignore
├── assets/
│   ├── arquitectura.png
│   └── arquitectura.pdf
├── config/
│   ├── gnb_zmq.yaml
│   ├── ue_zmq.conf
│   └── open5gs/
│       ├── amf.yaml
│       ├── nrf.yaml
│       ├── smf.yaml
│       └── upf.yaml
├── docs/
│   ├── evidencias.md
│   ├── errores.md
│   ├── procedencia.md
│   ├── pendientes.md
│   └── publicar-github.md
├── images/
│   ├── install/{open5gs,ocudu,srsran4g}/
│   └── connection/
└── scripts/
    └── recoger-estado.sh
```

El ZIP entregado contiene esta estructura sin metadatos `.git`. Se puede usar como copia descargable del tutorial.

## Detalles opcionales de publicación

Puedes añadir temas como `5g`, `open5gs`, `ocudu`, `srsran`, `zeromq` y `dragonos`. Si deseas conceder una licencia de reutilización a tu documentación e imágenes, elige la licencia que prefieras antes de añadir `LICENSE`; no se asignó una licencia de tus materiales sin tu elección.

Los paquetes Linux se instalan en la VM cuando se sigue el tutorial; no hay que subir binarios `gnb`, `srsue`, bases MongoDB ni árboles de código de terceros al repositorio.
