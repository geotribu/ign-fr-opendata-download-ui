rm _temp
bash scripts/1_scraper.sh
bash scripts/2_departements.sh
bash scripts/3_filtered_csv.sh
bash scripts/4_csv_type.sh
bash scripts/5_join_csv_topojson.sh
