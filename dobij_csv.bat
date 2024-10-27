@echo off
docker exec mongodb_container mongoexport --db=podaci --collection=knjiznice --out=/exports/novi_csv.csv --type=csv --fields=[_id,Naziv,Adresa,Kontakt_telefon,Kontakt_mail,Voditelj,radno_vrijeme[0].dani,radno_vrijeme[1].dani,radno_vrijeme[0].sati,radno_vrijeme[1].sati,Nudi_wifi,Nudi_računalo,Nudi_tople_napitke] --username=testuser --password=password --authenticationDatabase=admin
