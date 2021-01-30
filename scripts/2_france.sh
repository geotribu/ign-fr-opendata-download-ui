# Deuxième étape : extraction des liens pour la France dans des fichiers CSV

# Le petit manuel
if [ "$1" == "-h" ] ; then
    echo "Usage: ./`basename $0` _temp/1_scraping/1_liens.txt _temp/2_france \"FR,FX\""
    echo "Show this help: ./`basename $0` -h"
    exit 0
fi


# Arguments
SOURCE_FILE=$1
OUTPUT_DIR=$2
IFS="," read -a ARRAY_FRANCE <<< $3

# Création du répertoire parent
[ -d $OUTPUT_FILE ] || mkdir -p $OUTPUT_DIR

# Permet de créer des fichiers par département
for val in ${ARRAY_FRANCE[@]}; do
  val_t=$(echo $val | head -c 3)
  echo "Extraction France : $val_t"
  grep -E "FR|FX" $SOURCE_FILE | awk '{ printf("%s,FR\n", $0); }' >> $OUTPUT_DIR'/FR.csv'
done
