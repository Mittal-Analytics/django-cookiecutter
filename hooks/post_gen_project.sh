#!/bin/bash

echo "Project setup compalete"
echo "run these commands"
echo "cd {{cookiecutter.project_slug}}"
echo "git init ."
echo "python3 -m venv .venv"
echo "source .venv/bin/activate"
echo "pip install -r requirements/requirements-dev.txt"
echo "pre-commit install"
echo "git add . -A"
echo "git commit -m 'Initial commit'"