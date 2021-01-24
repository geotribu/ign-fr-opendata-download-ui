# Deuxième étape : extraction des liens

# Arguments
INPUT_FOLDER=$1
OUTPUT_FOLDER=$2
DPTS_ARRAY=$3

# si le dossier n'existe pas, on le crée
[ -d $OUTPUT_FOLDER ] || mkdir -p $OUTPUT_FOLDER

# Permet de créer des fichiers par département
for val in ${DPTS_ARRAY[@]}; do
   echo $val
   # Erreur sur la corse
   if [ "$val" = "002A" ] || [ "$val" = "002B" ]; then
        grep -E "D$val|DEP_$val" $TEMP_FOLDER/1_scraping_liens/liens_ign.txt | awk '{ printf("%s,D'${val: -3}'\n", $0); }' >> '2_dep/D'${val: -3}'.csv'
      else
        grep -E "D$val|DEP_$val" $TEMP_FOLDER/1_scraping_liens/liens_ign.txt | awk '{ printf("%s,D'$val'\n", $0); }' > $OUTPUT_FOLDER/D$val.csv
      fi
done
