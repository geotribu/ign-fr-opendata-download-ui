#Permet d'extraire les liens
curl https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'  > 1_liens_ign.txt

#Création du répertoire 2_dep
mkdir 2_dep

#Permet de créer des fichiers par département
declare -a StringArray=("001" "002" "003" "004" "005" "006" "007" "008" "009" "010" "011" "012" "013" "014" "015" "016" "017" "018" "019" "02A" "02B" "002A" "002B" "021" "022" "023" "024" "025" "026" "027" "028" "029" "030" "031" "032" "033" "034" "035" "036" "037" "038" "039" "040"  "041" "042" "043" "044" "045" "046" "047" "048" "049" "050" "051" "052" "053" "054" "055" "056" "057" "058" "059" "060" "061" "062" "063" "064" "065" "066" "067" "068" "069" "070" "071" "072" "073" "074" "075" "076" "077" "078" "079" "080" "081" "082" "083" "084" "085" "086"  "087"  "088"  "089" "090" "091" "092" "093" "094" "095" "971" "972" "973" "974" "975" "976")
for val in ${StringArray[@]}; do
   echo $val
   #Erreur sur la corse
   if [ "$val" = "002A" ] || [ "$val" = "002B" ]; then
        grep -E "D$val|DEP_$val" 1_liens_ign.txt | awk '{ printf("%s,D'${val: -3}'\n", $0); }' >> '2_dep/D'${val: -3}'.csv'
      else
        grep -E "D$val|DEP_$val" 1_liens_ign.txt | awk '{ printf("%s,D'$val'\n", $0); }' > 2_dep/D$val.csv
      fi

done

#Permet de supprimer les doublons et conserve uniquement les liens avec une extension .7z
cat 2_dep/*csv | sort -u | grep -F '.7z' > 3_liens_par_dep_clean_ext.csv

#création du répertoire 4_type
mkdir 4_type

#Permet de créer des fichiers par type et de les trier par département
declare -a StringArray=("BDTOPO" "PLANIGN" "ORTHOHR" "BDFORET" "DNSB-HAIES" "PARCELLAIRE_EXPRESS" "BDPARCELLAIRE" "RGEALTI" "BDORTHO")
for val in ${StringArray[@]}; do
   echo $val
   value="$(tr [A-Z] [a-z] <<< "${val//-/_}")"
   grep -E "$val" 3_liens_par_dep_clean_ext.csv | awk '{ printf("%s,'$val'\n", $0); }' | sort -s -k2,2 -t, > 4_type/$value.csv
   awk -F',' -v OFS=',' '{if(a!=$2){printf (a!="")?"\n"$2:$2;a=$2} printf "%s%s",OFS,$1}END{print}' 4_type/$value.csv > 4_type/$value'_transposition.csv' #Transposition des tableaux


   count_column=$(head -2 4_type/$value'_transposition.csv' |tail -1 |tr '\,' '\n' |wc -l)
   column=""
   column_sql=""
   for ((i=1; i<=($count_column); i++)) {
       column+=",lien"$i
       column_sql+=",header_"$value".lien"$i" as lien"$i
   }
   #echo $column_sql
   { echo "dep""$column"; cat 4_type/$value'_transposition.csv'; } > header_$value.csv #Ajout de l'entête
   rm 5_dep_join_$value.geojson
   ogr2ogr -f "GeoJSON" -sql "select departement.DEP as dep $column_sql  from departement left join 'header_$value.csv'.header_$value on departement.DEP = header_$value.dep" 5_dep_join_$value.geojson departement.shp #Jointure entre le fichier shp et le csv
   rm header_$value.csv
   echo "var $value=" | cat - 5_dep_join_$value.geojson > temp && mv temp 5_dep_join_$value.geojson
done
