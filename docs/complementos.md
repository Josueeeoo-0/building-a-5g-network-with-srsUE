# Comandos adicionales y registro histórico

[Volver al tutorial](../README.md)

El README mantiene la secuencia de las capturas. Aquí se separan las variantes, preparaciones adicionales y pruebas que no deben confundirse con los comandos fotografiados.

<a name="inicio-automatico-de-mongodb"></a>

## Inicio automático de MongoDB

La captura usa `sudo systemctl start mongod` y muestra el servicio activo, pero deshabilitado para el arranque automático. Para habilitarlo de forma adicional:

```bash
sudo systemctl enable mongod
```

## Dependencias de OCUDU

La VM fotografiada ya tenía las dependencias necesarias. Si construyes sobre otra instalación y CMake indica que falta una biblioteca, esta preparación adicional reúne las dependencias del gNB y sus drivers:

```bash
sudo apt update
sudo apt install -y \
  git build-essential cmake pkg-config \
  libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev \
  libzmq3-dev libuhd-dev
```

No es un bloque de instalación visible en las capturas de OCUDU. Se mantiene separado para no adelantar artificialmente las dependencias de srsRAN 4G ni cambiar el orden de aquel procedimiento.

## Fijar las revisiones del ensayo

Las capturas de OCUDU clonan la rama predeterminada; las de srsRAN 4G pasan primero por `release_23_11` y después por `master`. Para repetir específicamente las revisiones registradas, en una copia sin cambios locales puedes hacer estos checkouts **antes de configurar y compilar**:

```bash
cd ~/srsran_project/ocudu
git checkout b78d09a77ab060cda752f32483e551f1e9132f66
```

```bash
cd ~/srsRAN_4G_ocudu
git checkout bef8680d5f9714f3e040e6f9cbc88d7888439b6d
```

Estos dos comandos fijan revisiones y no se presentan como parte de la transcripción histórica. Los valores se conservan también en [versions.json](../versions.json).

## Borrado en la captura original

Antes del clon srsRAN 4G, la captura 02 contiene esta secuencia:

```text
cd ~
rm -rf srsRAN_4G_ocudu
git clone https://github.com/srsran/srsRAN_4G.git srsRAN_4G_ocudu
```

Se registra como historial. El borrado elimina todo ese árbol, incluidos cambios y compilaciones previas, y no es necesario para clonar en una carpeta nueva. El README conserva el clon sin convertir esa eliminación en un paso obligatorio.

## Copiar las configuraciones entregadas

La prueba modificó AMF y NRF mediante `nano`. Como alternativa a esa edición, desde la raíz de este repositorio puedes respaldar e instalar los cuatro archivos finales:

```bash
backup_dir="/etc/open5gs/backup-zmq-$(date +%Y%m%d-%H%M%S)"
sudo mkdir -p "$backup_dir"
for file in amf nrf smf upf; do
  sudo cp -a "/etc/open5gs/$file.yaml" "$backup_dir/"
  sudo install -m 644 "config/open5gs/$file.yaml" "/etc/open5gs/$file.yaml"
done
sudo systemctl restart open5gs-nrfd open5gs-amfd open5gs-smfd open5gs-upfd
```

Para gNB y UE, el README conserva la creación con heredoc. Si prefieres copiar los archivos en vez de escribirlos:

```bash
mkdir -p ~/zmq_test
cp config/gnb_zmq.yaml ~/zmq_test/gnb_zmq.yaml
cp config/ue_zmq.conf ~/zmq_test/ue_zmq.conf
```

## Repetir una ruta existente

La captura usa `ip route add`; cuando la ruta existe, devuelve `File exists`. Para reemplazarla de manera explícita en una repetición puedes usar:

```bash
sudo ip netns exec ue1 ip route replace default via 10.45.0.1 dev tun_srsue
```

## Pruebas adicionales de iPerf3

Estos comandos son propuestas para medir de forma controlada, no una transcripción completa de la captura 29.

Servidor en el host:

```bash
iperf3 -s -B 10.45.0.1 -i 1
```

Cliente TCP durante 30 segundos:

```bash
sudo ip netns exec ue1 iperf3 -c 10.45.0.1 -t 30 -i 1
```

Después, repetir en sentido inverso:

```bash
sudo ip netns exec ue1 iperf3 -c 10.45.0.1 -t 30 -i 1 -R
```

Prueba UDP de carga moderada:

```bash
sudo ip netns exec ue1 iperf3 -c 10.45.0.1 -u -b 300K -t 30 -i 1
```

Guarda los resúmenes del emisor y receptor. En UDP, revisa la tasa recibida, jitter y pérdida; en TCP, la tasa recibida y retransmisiones.
