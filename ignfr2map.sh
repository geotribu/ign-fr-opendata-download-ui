#!/bin/bash

# Le petit manuel
if [ "$1" = "-h" ] ; then
    echo "Créer un fichier .env avec les paramètres de configuration puis ./$(basename $0)"
    echo "Show this help: ./$(basename $0) -h"
    exit 0
fi

# on lit le fichier de configuration
. ./.env

# on construit nos variables
LOG_FILE_ABS="$(realpath "$LOG_FILE")"
FINAL_FOLDER_ABS="$(realpath "$RESULT_FOLDER")"
TEMP_FOLDER_ABS="$(realpath "$TEMP_FOLDER")"
TEMPLATES_FOLDER_ABS="$(realpath "$TEMPLATES_FOLDER")"
IFS="," read -a ARRAY_PRODUITS_DEPARTEMENTS <<< $LI_PRODUITS_DEPARTEMENTS
IFS="," read -a ARRAY_PRODUITS_REGIONS <<< $LI_PRODUITS_REGIONS
IFS="," read -a ARRAY_PRODUITS_FRANCE <<< $LI_PRODUITS_FRANCE
IFS="," read -a ARRAY_DEPARTEMENTS <<< $LI_DEPARTEMENTS
IFS="," read -a ARRAY_REGIONS <<< $LI_REGIONS

# on informe l'utilisateur
echo "---------- Configuration ----------" >> "$LOG_FILE_ABS"
echo "Les fichiers finaux seront stockés dans : $FINAL_FOLDER_ABS" >> "$LOG_FILE_ABS"
echo "Les fichiers intermédiaires seront stockés dans : $TEMP_FOLDER_ABS" >> "$LOG_FILE_ABS"
echo "Nombre de départements configurés : ${#ARRAY_DEPARTEMENTS[@]}" >> "$LOG_FILE_ABS"
echo "Nombre de produits configurés pour les départements : ${#ARRAY_PRODUITS_DEPARTEMENTS[@]}" >> "$LOG_FILE_ABS"
echo "Nombre de régions configurées : ${#ARRAY_REGIONS[@]}" >> "$LOG_FILE_ABS"
echo "Nombre de produits configurés pour les régions : ${#ARRAY_PRODUITS_REGIONS[@]}" >> "$LOG_FILE_ABS"
echo "Nombre de produits configurés pour la France entière : ${#ARRAY_PRODUITS_FRANCE[@]}" >> "$LOG_FILE_ABS"
echo "Fichier de journalisation (log) : $LOG_FILE_ABS"

# c'est partiiiiiiiii
echo -e "\n\n---------- Démarrage du script ----------" >> "$LOG_FILE_ABS"
echo "Scraping du site de l'IGN pour extraire tous les liens"
source scripts/1_scraper.sh $SOURCE_URL "$TEMP_FOLDER_ABS/1_scraping/1_liens.txt" >> "$LOG_FILE_ABS"

echo -e "\n\n---------- Extraction de liens par départements ----------"  >> "$LOG_FILE_ABS"
source scripts/2_departements.sh "$TEMP_FOLDER_ABS/1_scraping/1_liens.txt" $TEMP_FOLDER_ABS/2_departements $LI_DEPARTEMENTS >> "$LOG_FILE_ABS"

echo -e "\n\n---------- Extraction de liens par régions ----------"  >> "$LOG_FILE_ABS"
source scripts/2_regions.sh "$TEMP_FOLDER_ABS/1_scraping/1_liens.txt" $TEMP_FOLDER_ABS/2_regions $LI_REGIONS >> "$LOG_FILE_ABS"

echo -e "\n\n---------- Extraction de liens pour la France ----------"  >> "$LOG_FILE_ABS"
source scripts/2_france.sh "$TEMP_FOLDER_ABS/1_scraping/1_liens.txt" $TEMP_FOLDER_ABS/2_france $LI_FRANCE >> "$LOG_FILE_ABS"

echo -e "\n\n---------- Filtrage des liens (doublons...) ----------"  >> "$LOG_FILE_ABS"
source scripts/3_filtered_csv.sh "$TEMP_FOLDER_ABS" $TEMP_FOLDER_ABS/3_filtered_csv >> "$LOG_FILE_ABS"

echo -e "\n\n---------- Création de fichiers par produit (BD ORTHO, PLAN...) ----------"  >> "$LOG_FILE_ABS"
source scripts/4_csv_type.sh "departements" $TEMP_FOLDER_ABS/3_filtered_csv/3_liens_par_dep_clean_ext.csv $TEMP_FOLDER_ABS/4_csv_type $LI_PRODUITS_DEPARTEMENTS >> "$LOG_FILE_ABS"
source scripts/4_csv_type.sh "regions" $TEMP_FOLDER_ABS/3_filtered_csv/3_liens_par_regions_clean_ext.csv $TEMP_FOLDER_ABS/4_csv_type $LI_PRODUITS_REGIONS >> "$LOG_FILE_ABS"
source scripts/4_csv_type.sh "france" $TEMP_FOLDER_ABS/3_filtered_csv/3_liens_france_clean_ext.csv $TEMP_FOLDER_ABS/4_csv_type $LI_PRODUITS_FRANCE >> "$LOG_FILE_ABS"

echo -e "\n\n---------- Jointure des CSV avec les TopoJSON ----------"  >> "$LOG_FILE_ABS"
source scripts/5_join_csv_topojson.sh "departements" $TEMP_FOLDER_ABS/4_csv_type $TEMPLATES_FOLDER_ABS $FINAL_FOLDER_ABS/json $LI_PRODUITS_DEPARTEMENTS >> "$LOG_FILE_ABS"
source scripts/5_join_csv_topojson.sh "regions" $TEMP_FOLDER_ABS/4_csv_type $TEMPLATES_FOLDER_ABS $FINAL_FOLDER_ABS/json $LI_PRODUITS_REGIONS >> "$LOG_FILE_ABS"
source scripts/5_join_csv_topojson.sh "france" $TEMP_FOLDER_ABS/4_csv_type $TEMPLATES_FOLDER_ABS $FINAL_FOLDER_ABS/json $LI_PRODUITS_FRANCE >> "$LOG_FILE_ABS"

echo -e "\n\n---------- Jointure avec index.html ----------"  >> "$LOG_FILE_ABS"
bash scripts/6_create_html.sh departements $LI_PRODUITS_DEPARTEMENTS regions $LI_PRODUITS_REGIONS france $LI_PRODUITS_FRANCE $RESULT_FOLDER

echo -e "Copying favicon"
cp $TEMPLATES_FOLDER_ABS/favicon.png $FINAL_FOLDER_ABS/favicon.png
