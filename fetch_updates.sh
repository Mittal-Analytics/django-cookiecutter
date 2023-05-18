# exit on error
set -e

folder_path="$1"
folder_name="$(basename "$folder_path")"

echo "Checking if raw-$folder_name branch exists"
branch_name="raw-$folder_name"
if git rev-parse --verify "$branch_name" >/dev/null 2>&1; then
    echo "Good! Branch already exists"
else
    echo "Createing new tracking branch $branch_name"
    git checkout -b "raw-$folder_name"

    # move everything to a new folder
    mkdir -p cookie-template
    rsync -a ./ cookie-template --exclude=.venv --exclude=.git
    # remove everything from current folder
    find . -mindepth 1 -maxdepth 1 ! -name ".git" ! -name ".venv" ! -name "cookie-template" | xargs rm -rf
 
    echo "Deploying base project. Provide same inputs you used there."
    cookiecutter -o cookie-project cookie-template
    mv cookie-project/* .
    rm -rf cookie-project cookie-template

    # commit changes
    git add . -A
    git commit -m "Deployed base project"
fi

echo "fetching new changes"
rsync -av "$folder_path/" ./ --exclude=.venv --exclude=.git
git add . -A
git commit -m "Synced changes from $folder_name"


echo "staging changes..."
git checkout main
change_hash=git log -1 --pretty=format:%H "$branch_name"
git cherry-pick --no-commit "$change_hash"
