# CookieCutter template for our Django projects

CookieCutter allows us to create project templates. It is useful to automate the setup.


## Problem

Starting new projects
is a problem for me
because it requires a lot of copy-pasting from exiting projects.

It leads to lot of code-duplication. The best practices are spread all over the projects. Typically, a good change should flow to other projects as well.


### There are other CookieCutter templates. Why create another one?

To focus on:
- Editorconfig
- Editor defaults
- Better READMEs
- Deployment automation

#### Specifically

These are the specifics.

- [x] README.md
- [x] Django split settings
- [x] Split requirements
- [x] Pre-commit hooks
- [x] django-envoiron
- [x] editorconfig
- [x] remote-setup
- [x] git push deployment
- [x] github actions for tests

## How to use this?

```
pip install --upgrade cookiecutter
cookiecutter https://github.com/Mittal-Analytics/django-cookiecutter
```

## How to contribute?

Setup the local env:

```bash
python3 -m venv .venv
uv pip install -r requirements.txt
source .venv/bin/activate
```

Create a new project using this package:
```
cookiecutter https://github.com/Mittal-Analytics/django-cookiecutter
```

Make changes in that project. Then fetch changes from that repo:
```
bash fetch_updates.sh
```
