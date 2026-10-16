#!/usr/bin/env bash
# Ejecutar como el usuario normal de la VM: bash scripts/recoger-estado.sh
# Solo consulta estado; no reinicia servicios ni modifica la red.
set -eu
umask 077

output_dir="$(mktemp -d "$PWD/estado-vm-$(date +%Y%m%d-%H%M%S)-XXXXXX")"
mkdir -p "$output_dir/config/open5gs"

capture() {
  local output_name="$1"
  shift
  if "$@" >"$output_dir/$output_name.txt" 2>&1; then
    :
  else
    local code="$?"
    printf '\nConsulta terminada con codigo %s\n' "$code" >>"$output_dir/$output_name.txt"
  fi
}

capture os-release cat /etc/os-release
capture distro lsb_release -a
capture kernel uname -a
capture memoria free -h
capture cpu nproc
capture paquetes dpkg-query -W 'open5gs*' 'mongodb*' nodejs
capture servicios systemctl list-units --type=service --all 'open5gs-*' --no-pager
capture mongod systemctl is-active mongod
capture interfaces ip -br addr
capture rutas ip route show
capture namespaces sudo ip netns list
capture ue-ip sudo ip netns exec ue1 ip addr show tun_srsue
capture ue-rutas sudo ip netns exec ue1 ip route show
capture sockets-sctp sudo ss -lnp -A sctp
capture sockets-udp sudo ss -lunp
capture srsue-path command -v srsue
capture gnb-version "$HOME/srsran_project/ocudu/build/apps/gnb/gnb" --version
capture srsue-version "$HOME/srsRAN_4G_ocudu/build/srsue/src/srsue" --version

for repository in ocudu srsran4g; do
  if [ "$repository" = ocudu ]; then
    repository_dir="$HOME/srsran_project/ocudu"
  else
    repository_dir="$HOME/srsRAN_4G_ocudu"
  fi
  capture "$repository-commit" git -C "$repository_dir" rev-parse HEAD
  capture "$repository-describe" git -C "$repository_dir" describe --tags --always
  capture "$repository-status" git -C "$repository_dir" status --short
done

for file in amf nrf smf upf; do
  if sudo cat "/etc/open5gs/$file.yaml" >"$output_dir/config/open5gs/$file.yaml"; then
    :
  else
    printf 'No se pudo leer %s.yaml\n' "$file" >>"$output_dir/errores-copia.txt"
  fi
done

for file in gnb_zmq.yaml ue_zmq.conf; do
  if [ -r "$HOME/zmq_test/$file" ]; then
    cp "$HOME/zmq_test/$file" "$output_dir/config/$file"
  else
    printf 'No se pudo leer %s\n' "$file" >>"$output_dir/errores-copia.txt"
  fi
done

printf 'Estado guardado en: %s\n' "$output_dir"
