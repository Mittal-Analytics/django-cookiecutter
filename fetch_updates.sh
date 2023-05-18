# exit on error
set -e

# keep the argument same if possible
folder_path="$1"
folder_name="$(basename "$folder_path")"
echo "Fetching updates from $folder_name"

git checkout raw-target
rsync -av "$folder_path" ./ --exclude=.venv --exclude=.git --exclude=db.sqlite3 --exclude='*.pyc' --exclude="__pycache__" --exclude=".DS_Store"
find "$folder_name" -type f | xargs grep -Il "" | xargs sed -i '' "s/$folder_name/{{cookiecutter.project_slug}}/g"
mv "$folder_name/$folder_name" "$folder_name/{{cookiecutter.project_slug}}"
mv "{{cookiecutter.project_slug}}" backup_"{{cookiecutter.project_slug}}"
mv "$folder_name" "{{cookiecutter.project_slug}}"
rm -rf backup_"{{cookiecutter.project_slug}}"
git add . -A
git commit -m "Synced changes from $folder_name"


echo "triaging changes..."
git checkout target-tracker
git merge main
git merge raw-target --no-commit

echo "show upstream changes"
git checkout main
git diff target-tracker...