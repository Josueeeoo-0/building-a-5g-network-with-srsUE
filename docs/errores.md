# Errores encontrados y correcciones

[Volver al tutorial](../README.md)

## APT, PPA y DNS

Los problemas de descarga fueron distintos. Un error de resolución de nombres no se corrige necesariamente igual que una conexión rechazada por un servidor.

| Evidencia | Síntoma | Qué se hizo / cómo interpretarlo |
|---|---|---|
| Open5GS 01 y 26 | `archive.ubuntu.com:80` rechaza conexiones; APT conserva índices antiguos | Las capturas no prueban una reparación completa de esos índices. Verificar `apt update` antes de nuevas instalaciones. |
| Open5GS 09 | `add-apt-repository ppa:open5gs/latest` termina con `ConnectionRefusedError` | Se usó OBS para Jammy en los pasos siguientes; no se insiste en el PPA ni se añaden ambos repositorios a ciegas. |
| Open5GS 21–25 | `curl: (6) Could not resolve host: open5gs.org` | Se revisó `systemd-resolved` y se configuró DNS temporal en `enp0s3`. |

Comandos de inspección que aparecen en el diagnóstico de DNS:

```bash
resolvectl status
cat /etc/resolv.conf
nmcli device show | grep -E 'GENERAL.DEVICE|IP4.DNS'
```

En la captura, `/etc/resolv.conf` usa el stub `127.0.0.53`; NetworkManager mostraba DNS `10.0.2.3`, pero `resolvectl` no tenía ámbitos DNS activos para la interfaz. El arreglo temporal utilizado fue:

```bash
sudo resolvectl dns enp0s3 8.8.8.8 1.1.1.1
sudo resolvectl domain enp0s3 '~.'
sudo resolvectl flush-caches
getent hosts google.com
getent hosts open5gs.org
curl -I --connect-timeout 10 https://open5gs.org
```

Sustituye `enp0s3` si tu interfaz es otra. Este cambio es temporal; no prueba persistencia tras reiniciar. La salida posterior contiene resolución correcta y HTTP/2 200 para Open5GS. No demuestra que el acceso HTTP a todos los repositorios Ubuntu se haya restablecido.

## El programa sigue diciendo 23.4.0

Compilar srsRAN 4G no reemplazó `/usr/local/bin/srsue`. Comprueba:

```bash
command -v srsue
srsue --version
~/srsRAN_4G_ocudu/build/srsue/src/srsue --version
```

La última ruta es la compilación 25.10.0 utilizada. Eliminar la instalación de DragonOS no fue necesario.

La consulta `srsepc --version` de una captura llegó a inicializar partes de EPC y produjo errores de archivos SGi/SPGW. Ese programa no participa en este tutorial: el core es Open5GS. No se presentan esos errores como un fallo del gNB ni de la actualización de srsUE.

## Muestreo, PRB y CORESET#0

Los intentos intermedios mezclaron perfiles:

| Intento | Error / corrección |
|---|---|
| 20 MHz con tasa de 11,52 MS/s | El gNB rechazó una tasa demasiado baja para el ancho de banda. |
| 10 MHz con 52 PRB y CORESET#0 12 | No se pudo derivar la combinación SSB/Point A; se probó índice 6. |
| DCI fallback con tabla 256QAM | Se configuró `mcs_table: qam64` en PDSCH y PUSCH. |
| Perfil final guardado | 5 MHz, 25 PRB, 5,76 MS/s y CORESET#0 0 en los archivos entregados. |

No se afirma que cada índice CORESET sea exclusivo de un solo ancho. Lo que está acreditado es la combinación usada. La tasa base y los PRB se cambian en **ambos extremos**, conservando los puertos cruzados.

## SSB y el chat de asistencia

El texto de asistencia recibido afirma que se añadieron estas líneas al UE:

```ini
dl_nr_arfcn = 368500
ssb_nr_arfcn = 368410
ssb_nr_scs = 15
ssb_nr_pattern = A
ssb_nr_duplex_mode = FDD
```

**No están en el `ue_zmq.conf` final que se entregó desde la VM.** Ese archivo contiene 25 PRB y la tasa de 5,76 MS/s. Por eso no se añadieron al archivo publicado.

Además, se consultó [main.cc del mismo commit de srsUE](https://github.com/srsran/srsRAN_4G/blob/bef8680d5f9714f3e040e6f9cbc88d7888439b6d/srsue/src/main.cc):

| Opción de `[rat.nr]` | Reconocida | Valor por defecto en ese código |
|---|---|---|
| `dl_nr_arfcn` | Sí | 368500 |
| `ssb_nr_arfcn` | Sí | 368410 |
| `scs` | Sí | 15 |
| `ssb_scs` | Sí | 15 |
| `ssb_nr_scs` | No aparece | — |
| `ssb_nr_pattern` | No aparece | — |
| `ssb_nr_duplex_mode` | No aparece | — |

Las dos frecuencias del chat coinciden con los valores por defecto del código. No hay base para atribuirles por sí solas el éxito de esta ejecución. Tampoco se trasladan al tutorial nombres de opción que el parser no reconoce.

El chat se contradice acerca de 5 y 10 MHz. Para esta edición prevalecen los dos archivos finales y la captura del gNB con `bw=5 MHz`. No se deduce el ancho de banda exclusivamente de `base_srate`.

## Recursos y orden de arranque

Se asignaron 5 vCPU y 10 GB RAM a la VM y se cerraron aplicaciones sobrantes. Reducir la tasa a la mitad reduce las muestras por segundo, pero no implica reducir a la mitad todo el uso de CPU/RAM ni demuestra qué cambio aislado resolvió el fallo.

Orden usado: core → namespace disponible → gNB → srsUE → ruta → pruebas. La VM mostró RTT altos y variables. Eso es compatible con limitaciones de procesamiento, sin constituir una prueba causal de que toda la degradación proceda de VirtualBox.

## Namespace inexistente, interfaz GW y ruta repetida

```bash
sudo ip netns list
sudo ip netns exec ue1 ip addr show tun_srsue
sudo ip netns exec ue1 ip route
```

- Si no existe `ue1`, créalo antes de arrancar srsUE.
- Si aparece `Failed to setup/configure GW interface`, comprueba que el namespace existe, que ejecutaste srsUE con privilegios y que TUN está disponible. RRC conectado por sí solo no demuestra una interfaz de datos funcional.
- Si la interfaz existe y la ruta ya está, `File exists` al repetir `ip route add` no significa que la ruta falló. El README conserva `add`, tal como en la captura; la alternativa `replace` está en los complementos.
- `ping 10.45.0.2` no comprueba al UE de la sesión que recibió `10.45.0.3`. Relee la dirección actual.

La captura de conexión 26 contiene un aviso GW; la 22 muestra una sesión PDU y la 28 contiene ping correcto. Son momentos distintos. No existe una transcripción completa que permita inventar el comando específico que reparó aquel aviso.

## Qué significa el resultado iPerf3

La captura 29 está cortada y no incluye el resumen final. Hay intervalos con diferencias fuertes entre emisor y receptor. El chat describe otra prueba a 3 Mbit/s con pérdidas altas, pero no se recibió su salida completa. Por ello no se publica ni el valor solicitado ni intervalos sueltos como capacidad máxima de la red.

Repite las pruebas de [iPerf3](../README.md#12-medir-con-iperf3), guarda los dos extremos y compara el resumen del receptor. Si UDP a 300 Kbit/s también pierde paquetes, recoge estado, carga del sistema y logs antes de concluir la causa.
