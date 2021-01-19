#Récupère la page web
curl https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html > page_ign.txt

#Permet d'extraire les liens
cat page_ign.txt | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'  > liens_ign.txt

#création du répertoire dep
mkdir dep

#Permet de créer des fichiers par département
declare -a StringArray=("001" "002" "003" "004" "005" )
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
