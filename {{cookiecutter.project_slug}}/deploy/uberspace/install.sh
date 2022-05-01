# copy the code directory to remote
# the run following commands
echo "run on local\n$ scp -r deploy {{cookiecutter.project_slug}}:"
cd deploy/uberspace

set -e

# create folders
mkdir ~/repos
git init --bare ~/repos/{{cookiecutter.project_slug}}.git
cp ../post-receive ~/repos/{{cookiecutter.project_slug}}.git/hooks/post-receive
chmod +x ~/repos/{{cookiecutter.project_slug}}.git/hooks/post-receive
mkdir ~/webapps

# https://lab.uberspace.de/guide_django.html
# install uwsgi
pip3.9 install uwsgi --user
cp uwsgi.ini ~/etc/services.d/uwsgi.ini
mkdir -p ~/uwsgi/apps-enabled
touch ~/uwsgi/err.log
touch ~/uwsgi/out.log

supervisorctl reread
supervisorctl update
supervisorctl status

# configure web server
uberspace web domain add {{cookiecutter.domain_name}}
uberspace web backend set {{cookiecutter.domain_name}} --http --port 8000

# create deamon
mkdir -p ~/uwsgi/apps-enabled/
cp django-app.ini ~/uwsgi/apps-enabled/

# configure static servers
uberspace web backend set {{cookiecutter.domain_name}}/static --apache
uberspace web backend set {{cookiecutter.domain_name}}/media --apache

# add nginx headers
uberspace web header set {{cookiecutter.domain_name}}/static/ expires 7d
uberspace web header set {{cookiecutter.domain_name}}/favicon.ico root /var/www/virtual/{{cookiecutter.uberspace_login}}/html/static/favicons
uberspace web header set {{cookiecutter.domain_name}}/favicon.ico expires 7d

uberspace web header set {{cookiecutter.domain_name}}/static gzip on
uberspace web header set {{cookiecutter.domain_name}}/static gzip_comp_level 6
uberspace web header set {{cookiecutter.domain_name}}/static gzip_types text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml
uberspace web header set {{cookiecutter.domain_name}}/static gzip_types "text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml"


# import content
python3.9 manage.py migrate --settings={{cookiecutter.project_slug}}.settings.production
python3.9 manage.py createsuperuser --settings={{cookiecutter.project_slug}}.settings.production
