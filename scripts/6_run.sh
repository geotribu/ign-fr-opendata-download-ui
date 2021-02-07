rm _temp
bash scripts/1_scraper.sh https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html _temp/1_scraping/ liens_ign.txt
bash scripts/2_departements.sh _temp/1_scraping/liens_ign.txt _temp/2_departements 001_,002_,003_,0003,004_,005_,006_,007_,008_,009_,010_,011_,012_,013_,014_,015_,016_,017_,018_,019_,02A_,02B_,002A,002B,021_,022_,023_,024_,025_,026_,027_,028_,029_,030_,031_,032_,033_,034_,035_,036_,037_,038_,039_,040_,041_,042_,043_,044_,045_,046_,047_,048_,049_,050_,051_,052_,053_,054_,055_,056_,057_,058_,059_,060_,061_,062_,063_,064_,065_,066_,067_,068_,069_,070_,071_,072_,073_,074_,075_,076_,077_,078_,079_,080_,081_,082_,083_,084_,085_,086,087_,088_,089_,090_,091_,092_,093_,094_,095_,971_,972_,973_,974_,975_,976_,977_,978_
bash scripts/2_france.sh _temp/1_scraping/liens_ign.txt _temp/2_france FR,FX
bash scripts/2_regions.sh _temp/1_scraping/liens_ign.txt _temp/2_regions R11,R24,R27,R28,R32,R44,R52,R53,R75,R76,R84,R93,R94
bash scripts/3_filtered_csv.sh _temp/3_filtered_csv
bash scripts/4_csv_type.sh departements _temp/3_filtered_csv/3_liens_par_dep_clean_ext.csv _temp/4_csv_type BDTOPO,PLANIGN,ORTHOHR,BDFORET,DNSB-HAIES,PARCELLAIRE_EXPRESS,BDPARCELLAIRE,RGEALTI,BDORTHO
bash scripts/4_csv_type.sh france _temp/3_filtered_csv/3_liens_france_clean_ext.csv _temp/4_csv_type ADMIN-EXPRESS,GEOFLA,BDPR,BDTOPO,BDALTI,CONTOURS-IRIS,GEODESIE,PARCELLAIRE_EXPRESS,PLANIGN,ROUTE500,RPG,SCAN1000,SCANREG
bash scripts/4_csv_type.sh regions _temp/3_filtered_csv/3_liens_par_regions_clean_ext.csv _temp/4_csv_type SCAN50_HISTORIQUE,SCANEM40K,RPG,BDTOPO
bash scripts/5_join_csv_topojson.sh departements _temp/4_csv_type output BDTOPO,PLANIGN,ORTHOHR,BDFORET,DNSB-HAIES,PARCELLAIRE_EXPRESS,BDPARCELLAIRE,RGEALTI,BDORTHO
bash scripts/5_join_csv_topojson.sh regions _temp/4_csv_type output SCAN50_HISTORIQUE,SCANEM40K,RPG,BDTOPO
bash scripts/5_join_csv_topojson.sh france _temp/4_csv_type output ADMIN-EXPRESS,GEOFLA,BDPR,BDTOPO,BDALTI,CONTOURS-IRIS,GEODESIE,PARCELLAIRE_EXPRESS,PLANIGN,ROUTE500,RPG,SCAN1000,SCANREG
bash scripts/6_create_html.sh departements BDTOPO,PLANIGN,ORTHOHR,BDFORET,DNSB-HAIES,PARCELLAIRE_EXPRESS,BDPARCELLAIRE,RGEALTI,BDORTHO regions SCAN50_HISTORIQUE,SCANEM40K,RPG,BDTOPO france ADMIN-EXPRESS,GEOFLA,BDPR,BDTOPO,BDALTI,CONTOURS-IRIS,GEODESIE,PARCELLAIRE_EXPRESS,PLANIGN,ROUTE500,RPG,SCAN1000,SCANREG
