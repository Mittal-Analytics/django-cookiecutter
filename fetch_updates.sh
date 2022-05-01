echo "Fetching updates..."
git checkout raw-target
rsync -av ../getting_things_done ./ --exclude=.venv --exclude=.git --exclude=db.sqlite3 --exclude='*.pyc' --exclude="__pycache__"
find getting_things_done -type f | xargs sed -i '' 's/getting_things_done/{{cookiecutter.project_slug}}/g'
mv getting_things_done/getting_things_done getting_things_done/"{{cookiecutter.project_slug}}"
mv "{{cookiecutter.project_slug}}" backup_"{{cookiecutter.project_slug}}"
mv getting_things_done "{{cookiecutter.project_slug}}"
rm backup_"{{cookiecutter.project_slug}}"
git add . -A
git commit -m "Synced changes from getting_things_done"


echo "triaging changes..."
git checkout target-tracker
git merge main
git merge raw-target --no-commit
git diff main