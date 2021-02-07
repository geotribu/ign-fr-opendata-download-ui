#!/bin/bash
# cinquième étape : Jointure du csv avec le fichier topojson

# Le petit manuel
if [ "$1" == "-h" ] ; then
    echo "Usage: ./`basename $0` departements _temp/4_csv_type output \"BDTOPO,PLANIGN,ORTHOHR,BDFORET,DNSB-HAIES,PARCELLAIRE_EXPRESS,BDPARCELLAIRE,RGEALTI,BDORTHO\""
    echo "Show this help: ./`basename $0` -h"
    exit 0
fi

# Arguments
SCALE=$1
SOURCE_DIR=$2
TEMPLATES_DIR=$3
OUTPUT_DIR=$4
IFS="," read -a ARRAY <<< $5

if [ "$SCALE" == "departements" ] ; then
STYPE="DEP"
elif [ "$SCALE" == "regions" ] ; then
STYPE="REG"
elif [ "$SCALE" == "france" ] ; then
STYPE="FR"
fi

# Création du répertoire parent
[ -d $OUTPUT_DIR ] || mkdir -p $OUTPUT_DIR


echo "$SCALE $STYPE $SOURCE_DIR $TEMPLATES_DIR $OUTPUT_DIR"

for val in ${ARRAY[@]}; do
   echo $val
   value="$(tr [A-Z] [a-z] <<< "${val//-/_}")"

    count_column=$(awk -F'\,' '{print NF}' '_temp/4_csv_type/'$value'_'$SCALE'_transposition.csv' | sort -nu | tail -n 1)
    echo $count_column

    column_list=""
    for ((i=1; i<=($count_column); i++)) {
        column_list+="field"$i" "
    }
    echo $column_list

    cp "$TEMPLATES_DIR/$SCALE-avec-outre-mer.json" "$OUTPUT_DIR/$SCALE_$value.json"

    (cat $SOURCE_DIR/$value'_'$SCALE'_transposition.csv'; echo) | while IFS=, read -r $column_list; do
        column_json=""
        for ((i=1; i<=($count_column); i++)) {
              test="field$i"
              column_json+=',"lien'$i'":"'${!test}'"'
        }
        sed -i 's~,\"DEP\":\"'$field1'\"~,\"DEP\":\"'$field1'\"'${column_json}'~g' $OUTPUT_DIR/departement_$value.json
    done <  _temp/4_csv_type/$value'_transposition.csv'

done
