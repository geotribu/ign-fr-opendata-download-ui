# Deuxième étape : extraction des liens pour les régions dans des fichiers CSV

# Le petit manuel
if [ "$1" == "-h" ] ; then
    echo "Usage: ./`basename $0` _temp/1_scraping/1_liens.txt _temp/2_regions \"R11,R24,R27,R28,R32,R44,R52,R53,R75,R76,R84,R93,R94\""
    echo "Show this help: ./`basename $0` -h"
    exit 0
fi


# Arguments
SOURCE_FILE=$1
OUTPUT_DIR=$2
IFS="," read -a ARRAY_REGIONS <<< $3

# Création du répertoire parent
[ -d $OUTPUT_DIR ] || mkdir -p $OUTPUT_DIR

# Permet de créer les fichiers pour les régions
for val in ${ARRAY_REGIONS[@]}; do
  echo "Extraction région : $val"
  grep -E "$val" $SOURCE_FILE | awk '{ printf("%s,'$val'\n", $0); }' > "$OUTPUT_DIR/$val.csv"
done
