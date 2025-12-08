#!/bin/bash 
export GOOGLE_MAPS_API_KEY=$(grep GOOGLE_MAPS_API_KEY .env | cut -d '=' -f2) 

cp web/index.template.html web/index.html sed -i "s|__GOOGLE_MAPS_API_KEY__|$GOOGLE_MAPS_API_KEY|g" web/index.html