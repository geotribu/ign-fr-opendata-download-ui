# cinquième étape : Jointure du csv avec le fichier topojson

# Le petit manuel
if [ "$1" == "-h" ] ; then
    echo "Usage: ./`basename $0` departements _temp/4_csv_type output \"BDTOPO,PLANIGN,ORTHOHR,BDFORET,DNSB-HAIES,PARCELLAIRE_EXPRESS,BDPARCELLAIRE,RGEALTI,BDORTHO\""
    echo "Show this help: ./`basename $0` -h"
    exit 0
fi

# Arguments
TYPE=$1
SOURCE_FILE=$2
OUTPUT_DIR=$3
IFS="," read -a ARRAY <<< $4

if [ "$TYPE" == "departements" ] ; then
STYPE="DEP"
elif [ "$TYPE" == "regions" ] ; then
STYPE="REG"
elif [ "$TYPE" == "france" ] ; then
STYPE="FR"
fi

# Création du répertoire parent
[ -d $OUTPUT_DIR ] || mkdir -p $OUTPUT_DIR


for val in ${ARRAY[@]}; do
   echo $val
   value="$(tr [A-Z] [a-z] <<< "${val//-/_}")"

    count_column=$(awk -F'\,' '{print NF}' _temp/4_csv_type/$value'_'$TYPE'_transposition.csv' | sort -nu | tail -n 1)

    column_list=""
    for ((i=1; i<=($count_column); i++)) {
        column_list+="field"$i" "
    }

    cp templates/$TYPE'-avec-outre-mer.json' $OUTPUT_DIR/$TYPE"_"$value'.json'

    (cat $SOURCE_FILE/$value'_'$TYPE'_transposition.csv'; echo) | while IFS=, read -r $column_list; do
        column_json=""
        for ((i=1; i<=($count_column); i++)) {
              test="field$i"
              column_json+=',"lien'$i'":"'${!test}'"'
        }
        sed -i '' 's~,\"'$STYPE'\":\"'$field1'\"~,\"'$STYPE'\":\"'$field1'\"'${column_json}'~g' $OUTPUT_DIR/$TYPE"_"$value'.json'
        #echo 's~,\"'$STYPE'\":\"'$field1'\"~,\"'$STYPE'\":\"'$field1'\"'${column_json}'~g' $OUTPUT_DIR/$TYPE"_"$value'.json'
    done

done
