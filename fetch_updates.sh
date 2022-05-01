git checkout target-tracker
cp -r ../getting_things_done ./
find getting_things_done -type f | xargs sed -i  's/getting_things_done/\{\{cookiecutter.project_slug\}\}/g'