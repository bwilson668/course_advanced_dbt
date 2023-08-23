# level 2
## update artifacts from the command line

```
WORKING_BRANCH=$(git rev-parse --abbrev-ref HEAD)
git stash
git checkout ${1:-main}
git pull
dbt compile --target ${2:-prod}
cp target/manifest.json artifacts/manifest.json
git checkout $WORKING_BRANCH
git stash pop
```