# setup

you need to have:  
- a dbt project
- the dbt CLI installed
- the git initialized

## assumptions:  
- you are executing this command from the root folder of the dbt project
- you have the default "target" directory for dbt assets

## housekeeping:  
- create a folder for dbt run artifacts that is not in the target folder
- update the `.gitignore` to keep other files in the artifacts directory out of version control
- update the `profiles.yml` and `.env`/`.env.sample` to have a "prod" target
