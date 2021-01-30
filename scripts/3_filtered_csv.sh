# Troisième étape : Permet de supprimer les doublons et conserve uniquement les liens avec une extension .7z

# Le petit manuel
if [ "$1" == "-h" ] ; then
    echo "Usage: ./`basename $0` _temp/3_filtered_csv"
    echo "Show this help: ./`basename $0` -h"
    exit 0
fi

OUTPUT_DIR=$1

# Création du répertoire parent
[ -d $OUTPUT_DIR ] || mkdir -p $OUTPUT_DIR

# Permet de supprimer les doublons et conserve uniquement les liens avec une extension .7z
cat _temp/2_departements/*csv | sort -u | grep -F '.7z' > "$OUTPUT_DIR/3_liens_par_dep_clean_ext.csv"
cat _temp/2_france/*csv | sort -u | grep -F '.7z' > "$OUTPUT_DIR/3_liens_france_clean_ext.csv"
cat _temp/2_regions/*csv | sort -u | grep -F '.7z' > "$OUTPUT_DIR/3_liens_par_region_clean_ext.csv"
