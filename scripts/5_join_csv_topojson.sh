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
IFS="," read -a ARRAY_PRODUITS <<< $5

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

for produit in ${ARRAY_PRODUITS[@]}; do
   echo $produit
   value="$(tr [A-Z] [a-z] <<< "${produit//-/_}")"

    echo $value

    count_column=$(awk -F',' '{print NF}' '_temp/4_csv_type/'$value'_'$SCALE'_transposition.csv' | sort -nu | tail -n 1)
    echo $count_column

    column_list=""
    for ((i=1; i<=$count_column; i++)) {
        column_list+="field"$i" "
    }
    echo $column_list

    echo $OUTPUT_DIR/$SCALE"_"$value".json"
    cp $TEMPLATES_DIR/$SCALE"-avec-outre-mer.json" $OUTPUT_DIR/$SCALE"_"$value".json"


    (cat $SOURCE_DIR/$value'_'$SCALE'_transposition.csv'; echo) | while IFS=, read -r $column_list; do
        column_json=""
        for ((i=1; i<=$count_column; i++)) {
              test="field$i"
              column_json+=',"lien'$i'":"'${!test}'"'
        }
        sed -i 's~,\"'$STYPE'\":\"'$field1'\"~,\"'$STYPE'\":\"'$field1'\"'${column_json}'~g' $OUTPUT_DIR/$SCALE"_"$value".json"
        echo 's~,\"'$STYPE'\":\"'$field1'\"~,\"'$STYPE'\":\"'$field1'\"'${column_json}'~g' $OUTPUT_DIR/$SCALE"_"$value".json"
    done

done
