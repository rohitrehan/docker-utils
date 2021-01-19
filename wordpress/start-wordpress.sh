#!/bin/bash

# to host wordpress locally

mkdir -p wordpress_data/db
mkdir -p wordpress_data/content

docker-compose -f docker-compose.wordpress.yml up -d
