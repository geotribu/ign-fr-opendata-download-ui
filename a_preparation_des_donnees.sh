#Récupère la page web
curl https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html > page_ign.txt

#Permet d'extraire les liens
cat page_ign.txt | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'  > liens_ign.txt

#création du répertoire dep
mkdir dep

#Permet de créer des fichiers par département
declare -a StringArray=("001" "002" "003" "004" "005" "006" "007" "008" "009" "010" "011" "012" "013" "014" "015" "016" "017" "018" "019" "02A" "02B" "021" "022" "023" "024" "025" "026" "027" "028" "029" "030" "031" "032" "033" "034" "035" "036" "037" "038" "039" "040"  "041" "042" "043" "044" "045" "046" "047" "048" "049" "050" "051" "052" "053" "054" "055" "056" "057" "058" "059" "060" "061" "062" "063" "064" "065" "066" "067" "068" "069" "070" "071" "072" "073" "074" "075" "076" "077" "078" "079" "080" "081" "082" "083" "084" "085" "086"  "087"  "088"  "089" "090" "091" "092" "093" "094" "095" "971" "972" "973" "974" "975" "976")
for val in ${StringArray[@]}; do
   echo $val
   grep -E "D$val|DEP_$val" liens_ign.txt | awk '{ printf("%s,D'$val'\n", $0); }' > dep/D$val.csv
done

#Fusion des fichiers csv
cat dep/*csv > liens_par_dep.csv
#Permet de supprimer les doublons
sort -u liens_par_dep.csv -o liens_par_dep_clean.csv

#Conserve uniquement les liens avec une extension .7z
grep -F '.7z' liens_par_dep_clean.csv > liens_par_dep_clean_ext.csv

#création du répertoire type
mkdir type

#Permet de créer des fichiers par type et de les trier par département
declare -a StringArray=("BDTOPO_3-0_TOUSTHEMES" "PLANIGN__TIF_LAMB93" "ORTHOHR_1-0_RVB-0M20_JP2-E080_LAMB93" "BDFORET_V2")
for val in ${StringArray[@]}; do
   echo $val
   grep -E "$val" liens_par_dep_clean_ext.csv | awk '{ printf("%s,'$val'\n", $0); }' | sort -s -k2,2 -t, > type/$val.csv 
   awk -F',' -v OFS=',' '{if(a!=$2){printf (a!="")?"\n"$2:$2;a=$2} printf "%s%s",OFS,$1}END{print}' type/$val.csv > type/$val'_transpos.csv' #Transposition des tableaux
   { echo "dep,lien1,lien2,lien3,lien4,lien5,lien6,lien7,lien8,lien9,lien10,lien11,lien12,lien13,lien14,lien15,lien16,lien17,lien18,lien19,lien20"; cat type/$val'_transpos.csv'; } > type/$val'_transpos_head.csv' #Ajoute l'entête
done

#Fusion des fichiers csv
#cat type/*csv > liens_par_type.csv
