#!/bin/sh
# Première étape : scraping de la page de l'IGN

# Le petit manuel
if [ "$1" = "-h" ] ; then
    echo "Usage: ./$(basename $0) https://geoservices.ign.fr/planign,https://geoservices.ign.fr/bdortho,https://geoservices.ign.fr/bdtopo,https://geoservices.ign.fr/bdforet,https://geoservices.ign.fr/rgealti,https://geoservices.ign.fr/parcellaire-express-pci,https://geoservices.ign.fr/rpg,https://geoservices.ign.fr/scan50,https://geoservices.ign.fr/scanhisto,https://geoservices.ign.fr/bdhaie,https://geoservices.ign.fr/ocsge,https://geoservices.ign.fr/bdalti,https://geoservices.ign.fr/bdcarto,https://geoservices.ign.fr/bdparcellaire,https://geoservices.ign.fr/route500,https://geoservices.ign.fr/scan1000 liens_ign.txt"
    echo "Show this help: ./$(basename $0) -h"
    exit 0
fi

# Arguments
SOURCE_URL=$1
OUTPUT_FILE=$2

# si le dossier parent n'existe pas, on le crée    
[ -d "$OUTPUT_FILE" ] || mkdir -p "$(dirname "$OUTPUT_FILE")"
# on supprime d'abord les anciens fichiers
rm --force "$OUTPUT_FILE"

IFS="," read -a ARRAY_URL <<< $SOURCE_URL
for val in ${ARRAY_URL[@]}; do
echo "Téléchargement de la page : $val"
# télécharge la page HTML (stream), extrait les liens et le stockent dans un fichier texte
curl -k "$val" | \
    grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@# /%?=~_|!:,.;]*[-A-Za-z0-9+&@# /%=~_|]' >> "$OUTPUT_FILE"

done
