# Python support can be specified down to the minor or micro version
# (e.g. 3.6 or 3.6.3).
# OS Support also exists for jessie & stretch (slim and full).
# See https://hub.docker.com/r/library/python/ for all supported Python
# tags from Docker Hub.
FROM ghcr.io/astral-sh/uv:python3.13-bookworm
ENV PYTHONUNBUFFERED 1

# Install Libraries
# libpoppler-cpp-dev for pdftotext
RUN apt update && apt install -y \
	cron \
	unzip \
	vim \
	libpoppler-cpp-dev

# Pip install
WORKDIR /app
ADD ./requirements/ /app/requirements/
RUN uv pip install -r requirements/requirements.txt

# Add rest of the code
ADD . /app/

# Not root
USER www-data

EXPOSE 8000
CMD daphne -b 0.0.0.0 -p 8000 {{cookiecutter.project_slug}}.asgi:application
