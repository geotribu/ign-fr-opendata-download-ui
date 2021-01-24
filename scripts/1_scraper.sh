# Première étape : scraping de la page de l'IGN
[ -d _temp/1_scraping_liens ] || mkdir -p _temp/1_scraping_liens

# télécharge la page HTML (stream), extrait les liens et le stockent dans un fichier texte
curl https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html |\
    grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@# /%?=~_|!:,.;]*[-A-Za-z0-9+&@# /%=~_|]'  > _temp/1_liens/liens_ign.txt
