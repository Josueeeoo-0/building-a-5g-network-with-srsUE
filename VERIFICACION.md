# Verificación de esta edición

Fecha: 16/10/2026.

- Sintaxis de los cinco YAML y del archivo INI: válida.
- Perfil final coherente: 5 MHz, 25 PRB, 5,76 MS/s, puertos cruzados, CORESET 0 y qam64.
- Identidad PLMN/TAC y endpoints AMF, SCP, PFCP, UPF, gateway y namespace coherentes entre archivos.
- Integridad SHA-256: 80 imágenes; los seis archivos finales son idénticos a los originales.
- Todas las opciones del UE existen en el parser del commit fijado; las tres opciones SSB del chat no se incorporaron.
- Los heredocs completos de gNB y UE reproducen los archivos entregados.
- README sin imágenes insertadas, espacio JPG reservado y orden MongoDB → Node.js → Open5GS → WebUI; comandos históricos restaurados.
- Enlaces y anclas locales: 129 destinos válidos, incluidas las 80 imágenes de la galería.
- Script de diagnóstico: bash -n sin errores y saltos de línea LF.
- Sintaxis Bash: 41 bloques del README válidos; solo analizados, no ejecutados.
- Figura: una página vectorial con UPF 127.0.0.7; PNG revisado visualmente.

## Integridad de archivos originales

El comentario de la línea 43 del UPF original contiene un espacio final. Se conserva para mantener el archivo idéntico al entregado; el atributo Git de ese archivo excluye ese tipo de aviso de formato. No cambia su contenido activo.

## Límites

No se ejecutó una reinstalación del laboratorio, no se compilaron los binarios en esta revisión y no se ejecutó el script de diagnóstico contra la VM. La verificación Bash comprueba sintaxis. Las pruebas reales de conexión y compilación son las documentadas por el autor. Los repositorios APT y los instaladores remotos siguen siendo fuentes mutables.
