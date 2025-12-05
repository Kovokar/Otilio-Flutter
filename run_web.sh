#!/bin/bash

# Atualiza o index.html com a chave do .env
echo "Atualizando index.html com a chave do Google Maps..."
./update_index.sh

# Roda o Flutter Web no Chrome
echo "Iniciando o Flutter Web..."
flutter run -d chrome
