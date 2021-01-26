# Création du répertoire
[ -d output ] || mkdir -p output

# Jointure du csv avec le fichier topojson
declare -a StringArray=("BDTOPO" "PLANIGN" "ORTHOHR" "BDFORET" "DNSB-HAIES" "PARCELLAIRE_EXPRESS" "BDPARCELLAIRE" "RGEALTI" "BDORTHO")
for val in ${StringArray[@]}; do
   echo $val
   value="$(tr [A-Z] [a-z] <<< "${val//-/_}")"

    # count_column=$(head -2 _temp/4_csv_type/$value'_transposition.csv'  |tail -1 |tr '\,' '\n' |wc -l)
    count_column=$(awk -F'\,' '{print NF}' _temp/4_csv_type/$value'_transposition.csv' | sort -nu | tail -n 1)
    # echo $count_column
    column_list=""
    for ((i=1; i<=($count_column); i++)) {
        column_list+="field"$i" "
    }

    cp template/departements-avec-outre-mer.json output/departement_$value.json

    while IFS=, read -r $column_list; do
        column_json=""
        for ((i=1; i<=($count_column); i++)) {
              test="field$i"
              column_json+=',"lien'$i'":"'${!test}'"'
        }
        sed -i 's~,\"DEP\":\"'$field1'\"~,\"DEP\":\"'$field1'\"'${column_json}'~g' output/departement_$value.json
    done <  _temp/4_csv_type/$value'_transposition.csv'

done
