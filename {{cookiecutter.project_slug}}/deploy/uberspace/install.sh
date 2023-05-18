# run these commands on local
# scp -r deploy {{cookiecutter.uberspace_login}}:
# ssh {{cookiecutter.uberspace_login}} 'bash deploy/uberspace/install.sh'

cd deploy/uberspace

set -e

# create folders
mkdir -p ~/repos
git init --bare ~/repos/{{cookiecutter.project_slug}}.git
cp post-receive ~/repos/{{cookiecutter.project_slug}}.git/hooks/post-receive
chmod +x ~/repos/{{cookiecutter.project_slug}}.git/hooks/post-receive
mkdir -p ~/webapps/{{cookiecutter.project_slug}}
touch ~/ENV
ln -s /home/{{cookiecutter.uberspace_login}}/ENV ~/webapps/{{cookiecutter.project_slug}}/.env

# https://lab.uberspace.de/guide_django.html
# install uwsgi
pip3.11 install uwsgi --user
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
uberspace web header set {{cookiecutter.domain_name}}/static gzip_types "text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml"

# instructions to setup git push
echo "Remote setup done"
echo "Run these on local"
echo "git remote add live {{cookiecutter.uberspace_login}}:repos/{{cookiecutter.project_slug}}.git"
echo "git push live"
echo "ssh {{cookiecutter.uberspace_login}}"
echo "vi ENV"
echo "python3.11 manage.py createsuperuser --settings={{cookiecutter.project_slug}}.settings.production"
