# About {{cookiecutter.project_name}}

<< What does this project do >>

## Problem statement

- << ______ >>
- is a problem for << ------ >>
- because << --------- >>.


## Getting the local server running

{%- if cookiecutter.database == "postgres" -%}
- Install `postgresql`: https://www.postgresql.org/download/
{%- else -%}
- Install `mysql`: https://dev.mysql.com/doc/refman/8.4/en/installing.html
{% endif %}

```bash
# Clone repository
git clone <repo-link>
cd {{cookiecutter.project_slug}}

# creating virtual env
uv venv --python=python3.13
source .venv/bin/activate

# create a new database
{%- if cookiecutter.database == "postgres" -%}
# check if we can login to shell
psql -d postgres  # psql -d postgres -U postgres
exit

# create new user
psql -d postgres -c "CREATE USER \"py-user\" WITH PASSWORD 'p@@sWord';"
psql -d postgres -c "ALTER ROLE \"py-user\" CREATEDB;"

# login to shell as user
psql -d postgres -U "py-user"
CREATE DATABASE {{cookiecutter.project_slug}}_db;
CREATE DATABASE test_{{cookiecutter.project_slug}}_db;

# Create PostgreSQL users
GRANT ALL PRIVILEGES ON DATABASE {{cookiecutter.project_slug}}_db TO "py-user";
GRANT ALL PRIVILEGES ON DATABASE test_{{cookiecutter.project_slug}}_db TO "py-user";
\q
{%- else -%}
mysql -u root -p --default-character-set=utf8mb4
CREATE DATABASE {{cookiecutter.project_slug}}_db CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE DATABASE test_{{cookiecutter.project_slug}}_db CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

# Create MySQL users
create user 'py-user' identified by 'p@@sWord';
grant all privileges on {{cookiecutter.project_slug}}_db.* to 'py-user';
grant all privileges on test_{{cookiecutter.project_slug}}_db.* to 'py-user';
flush privileges;
exit
{% endif %}

# install dependencies
uv pip install -r requirements/requirements-dev.txt

# install pre-commit hooks
pre-commit install

# Provide database authentications
cp .env.sample .env
# update the .env file with mysql username, password and database name
vi .env

# Create database and tables
python manage.py migrate

# Start development server
python manage.py runserver
```


## Deployment

```bash
git push live
```
