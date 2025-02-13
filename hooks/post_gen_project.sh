#!/bin/bash

# copy stylesheets
echo "updating css"
curl -s "https://raw.githubusercontent.com/pratyushmittal/snippets/refs/heads/main/css/style.css" > "www/css/style.css"
curl -s "https://raw.githubusercontent.com/pratyushmittal/snippets/refs/heads/main/css/django-forms.css" >> "www/css/style.css"
curl -s "https://raw.githubusercontent.com/pratyushmittal/snippets/refs/heads/main/css/breadcrumbs.css" >> "www/css/style.css"


echo "Project setup compalete"
echo "run these commands"
echo "cd {{cookiecutter.project_slug}}"
echo "direnv allow"
echo "git init ."
echo "cp .env.sample .env"
echo "uv venv --python=python3.13"
echo "source .venv/bin/activate"
echo "uv pip compile requirements/requirements.in --upgrade -o requirements/requirements.txt"
echo "uv pip install -r requirements/requirements-dev.txt"
echo "pre-commit install"
echo "pre-commit autoupdate"
echo "git add . -A"
echo "git commit -m 'Initial commit'"
