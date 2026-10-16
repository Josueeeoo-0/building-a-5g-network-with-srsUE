# Qué falta y qué ya está resuelto

[Volver al tutorial](../README.md)

## Archivos de configuración recibidos

Ya se entregaron los seis archivos finales y se incorporaron sin reconstruirlos: gNB, UE, AMF, NRF, SMF y UPF. No hace falta volver a proporcionarlos para publicar esta edición.

## Material adicional útil, sin bloquear la publicación

1. **Salida de `cat /etc/os-release` y `lsb_release -a`.** Permitiría precisar el nombre exacto de DragonOS y su base en lugar de apoyarse en los repositorios Jammy visibles.
2. **Salida completa de iPerf3 de ambos extremos**, incluyendo su resumen final y comando. Haría posible añadir un benchmark. La prueba existente solo justifica conectividad y tráfico parcial.
3. **Salida de `ss` para N2/N3/N4 y `ip -br addr`.** Complementaría los endpoints configurados con sockets activos de esa ejecución.

La guía es publicable como documentación de una ejecución con capturas y configuraciones. No se presenta como reinstalación limpia certificada ni como prueba de Internet externo.

Para recopilar versiones e interfaces puedes ejecutar en la VM, desde este repositorio:

```bash
bash scripts/recoger-estado.sh
```

El script solo consulta estado y copia los archivos conocidos a una carpeta de diagnóstico ignorada por Git. Sus errores de consulta se conservan en los archivos de salida; no cambia servicios, rutas ni el namespace.
