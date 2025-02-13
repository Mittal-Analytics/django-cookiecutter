#!/bin/bash

# On git push, this script will run automatically on server

set -e  # exit if anything fails

echo "Building changes"
docker compose build

echo "Deploying image and configuration changes for all other services"
docker compose up -d

echo "Collecting Static files"
RUN="docker compose exec -T app "
$RUN python manage.py collectstatic --noinput --settings={{cookiecutter.project_slug}}.settings.production

echo "Running migrations"
$RUN python manage.py migrate --settings={{cookiecutter.project_slug}}.settings.production
