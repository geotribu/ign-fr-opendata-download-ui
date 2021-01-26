rm _temp
sh scripts/1_scraper.sh
sh scripts/2_departements.sh
sh scripts/3_filtered_csv.sh
sh scripts/4_csv_type.sh
sh scripts/5_join_csv_topojson.sh
