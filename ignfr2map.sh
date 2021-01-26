#!/bin/sh

# on lit le fichier de configuration
. ./.env

# on construit nos variables
export LOG_FILE_ABS="$(realpath "$LOG_FILE")"
export SOURCE_URL=$SOURCE_URL
export TEMP_FOLDER_ABS="$(realpath "$TEMP_FOLDER")"
IFS="," read -a ARRAY_DEPARTEMENTS <<< $LI_DEPARTEMENTS

# on informe l'utilisateur
echo "---------- Configuration ---------------" >> $LOG_FILE_ABS
echo "Les fichiers intermédiaires seront stockés dans : $TEMP_FOLDER_ABS" >> $LOG_FILE_ABS
echo "Nombre de départements configurés : ${#ARRAY_DEPARTEMENTS[@]}" >> $LOG_FILE_ABS
echo "Fichier de journalisation (log) : $LOG_FILE_ABS" >> $LOG_FILE_ABS

# c'est partiiiiiiiii
echo -e "\n\n---------- Démarrage du script ---------------" >> $LOG_FILE_ABS
echo "Scraping du site de l'IGN pour extraire tous les liens"
source scripts/1_scraper.sh $SOURCE_URL "$TEMP_FOLDER_ABS/1_scraping/1_liens.txt" >> $LOG_FILE_ABS

# echo "Extraction de liens par départements"
# source scripts/2_departements.sh >> $LOG_FILE_ABS
