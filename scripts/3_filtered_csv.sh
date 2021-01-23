# Création du répertoire
[ -d _temp/3_filtered_csv ] || mkdir -p _temp/3_filtered_csv

# Permet de supprimer les doublons et conserve uniquement les liens avec une extension .7z
cat _temp/2_departements/*csv | sort -u | grep -F '.7z' > _temp/3_filtered_csv/3_liens_par_dep_clean_ext.csv
