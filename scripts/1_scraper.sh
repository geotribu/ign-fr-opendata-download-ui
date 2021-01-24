# Première étape : scraping de la page de l'IGN

# Arguments
SOURCE_URL=$1
OUTPUT_FILE=$2

# si le dossier n'existe pas, on le crée
[ -d $OUTPUT_FILE ] || mkdir -p $OUTPUT_FILE

# télécharge la page HTML (stream), extrait les liens et le stockent dans un fichier texte
curl  |\
    grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@# /%?=~_|!:,.;]*[-A-Za-z0-9+&@# /%=~_|]'  > $OUTPUT_FILE
