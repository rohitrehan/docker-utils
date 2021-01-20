#!/bin/bash

# to host wordpress locally

if [ ! -d "wordpress_data/db" ]; then
    echo "creating db directory..."
    mkdir -p wordpress_data/db
fi
if [ ! -d "wordpress_data/content" ]; then
    echo "creating wp content directory..."
    mkdir -p wordpress_data/content
fi
echo "starting wordpress containers..."
docker-compose up -d
