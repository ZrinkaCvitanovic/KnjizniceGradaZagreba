@echo off
docker exec mongodb_container mongoexport --host mongodb_container --db=podaci --collection=knjiznice --out=/exports/novi_json.json --jsonArray --username=testuser --password=password --authenticationDatabase=admin
