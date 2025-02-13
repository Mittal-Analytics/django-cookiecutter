#!/bin/bash

# copy stylesheets
curl -s "https://raw.githubusercontent.com/pratyushmittal/snippets/refs/heads/main/css/style.css" > "www/css/style.css"
curl -s "https://raw.githubusercontent.com/pratyushmittal/snippets/refs/heads/main/css/django-forms.css" >> "www/css/style.css"
curl -s "https://raw.githubusercontent.com/pratyushmittal/snippets/refs/heads/main/css/breadcrumbs.css" >> "www/css/style.css"


echo "Project setup compalete"
echo "run these commands"
echo "cd {{cookiecutter.project_slug}}"
echo "direnv allow"
echo "git init ."
echo "cp .env.sample .env"
echo "python3 -m venv .venv"
echo "source .venv/bin/activate"
echo "uv pip install -r requirements/requirements-dev.txt"
echo "pre-commit install"
echo "git add . -A"
echo "git commit -m 'Initial commit'"
