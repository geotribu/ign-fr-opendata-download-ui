# quatrième étape : Permet de créer des fichiers par catégrorie

# Le petit manuel
if [ "$1" == "-h" ] ; then
    echo "Usage: ./`basename $0` departement _temp/3_filtered_csv/3_liens_par_dep_clean_ext.csv _temp/4_csv_type \"BDTOPO,PLANIGN,ORTHOHR,BDFORET,DNSB-HAIES,PARCELLAIRE_EXPRESS,BDPARCELLAIRE,RGEALTI,BDORTHO\""
    echo "Show this help: ./`basename $0` -h"
    exit 0
fi

# Arguments
TYPE=$1
SOURCE_FILE=$2
OUTPUT_DIR=$3
IFS="," read -a ARRAY_DEPARTEMENTS <<< $4

# Création du répertoire parent
[ -d $OUTPUT_DIR ] || mkdir -p $OUTPUT_DIR


# Permet de créer des fichiers par catégorie
for val in ${ARRAY_DEPARTEMENTS[@]}; do
   echo $val
   value="$(tr [A-Z] [a-z] <<< "${val//-/_}")"
   grep -E "$val" $SOURCE_FILE | awk '{ printf("%s,'$val'\n", $0); }' | sort -s -k2,2 -t, > $OUTPUT_DIR/$value'_'$TYPE'.csv'
   awk -F',' -v OFS=',' '{if(a!=$2){printf (a!="")?"\n"$2:$2;a=$2} printf "%s%s",OFS,$1}END{}' $OUTPUT_DIR/$value'_'$TYPE'.csv' > $OUTPUT_DIR/$value'_'$TYPE'_transposition.csv' # Transposition des tableaux


   count_column=$(head -2 $OUTPUT_DIR/$value'_'$TYPE'_transposition.csv' | tail -1 |tr '\,' '\n' |wc -l)
   column=""
   column_sql=""
   for ((i=1; i<=($count_column); i++)) {
       column+=",lien"$i
       column_sql+=",header_"$value".lien"$i" as lien"$i
   }
done
