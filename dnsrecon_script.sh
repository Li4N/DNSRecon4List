#!/bin/bash
# Autor: Li4N
# Uso: ./dnsrecon_script.sh rangos.txt

# Verifica que se proporcionó un argumento
if [ "$#" -ne 1 ]; then
  echo "Error: Debes proporcionar un archivo con rangos de IP como argumento."
  echo "Uso: ./dnsrecon_script.sh rangos.txt"
  exit 1
fi

# Verifica que el archivo exista
if [ ! -f "$1" ]; then
  echo "Error: El archivo $1 no existe."
  exit 1
fi

# Elimina el archivo de salida si ya existe
if [ -f "output_dnsrecon" ]; then
  rm -rf output_dnsrecon
fi

# Itera sobre los rangos de IP en el archivo
while read -r rango; do
  # Ejecuta dnsrecon y guarda la salida en el archivo output_dnsrecon, además de mostrarla en la terminal
  echo "Procesando rango: $rango"
  dnsrecon -r "$rango" -n 8.8.8.8 2>&1 | tee -a output_dnsrecon
  
  # Muestra un mensaje indicando que el rango ha sido procesado
  echo "Rango procesado: $rango"
  
  # Agrega una pausa de 5 segundos
  sleep 5
done < "$1"

echo "Finalizado. Resultados guardados en output_dnsrecon."
