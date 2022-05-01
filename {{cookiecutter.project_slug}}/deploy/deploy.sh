#!/bin/bash

# On git push, this script will run automatically on server

set -e  # exit if anything fails

echo "Installing requirements"
pip3.9 install --upgrade pip
pip3.9 install -r requirements/requirements.txt --user

echo "Collecting Static files"
python3.9 manage.py collectstatic --noinput --settings={{cookiecutter.project_slug}}.settings.production

echo "Running migrations"
python3.9 manage.py migrate --settings={{cookiecutter.project_slug}}.settings.production

echo "Restarting uwsgi"
touch {{cookiecutter.project_slug}}/wsgi.py

echo "Updating crons"
crontab < deploy/crons.crontab

echo "Successfully Deployed. Woohoo!"
