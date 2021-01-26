# Création du répertoire
[ -d _temp/4_csv_type ] || mkdir -p _temp/4_csv_type

# Permet de créer des fichiers par type
declare -a StringArray=("BDTOPO" "PLANIGN" "ORTHOHR" "BDFORET" "DNSB-HAIES" "PARCELLAIRE_EXPRESS" "BDPARCELLAIRE" "RGEALTI" "BDORTHO")
for val in ${StringArray[@]}; do
   echo $val
   value="$(tr [A-Z] [a-z] <<< "${val//-/_}")"
   grep -E "$val" _temp/3_filtered_csv/3_liens_par_dep_clean_ext.csv | awk '{ printf("%s,'$val'\n", $0); }' | sort -s -k2,2 -t, > _temp/4_csv_type/$value.csv
   awk -F',' -v OFS=',' '{if(a!=$2){printf (a!="")?"\n"$2:$2;a=$2} printf "%s%s",OFS,$1}END{}' _temp/4_csv_type/$value.csv > _temp/4_csv_type/$value'_transposition.csv' # Transposition des tableaux


   count_column=$(head -2 _temp/4_csv_type/$value'_transposition.csv' |tail -1 |tr '\,' '\n' |wc -l)
   column=""
   column_sql=""
   for ((i=1; i<=($count_column); i++)) {
       column+=",lien"$i
       column_sql+=",header_"$value".lien"$i" as lien"$i
   }
done
