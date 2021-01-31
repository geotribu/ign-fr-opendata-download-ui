# Script de génération d'une carte par départements des liens OpenData de l'IGN France

## Configuration (En cours)

Copier le fichier `example.env` en `.env` et adapter les paramètres si besoin.

```bash
mv example.env .env
```

## Usage

Lancer le script :

```bash
bash ignfr2map.sh
```

Placer les fichiers sur un serveur web et ouvrir le fichier `index.html` dans un navigateur internet.

## Etapes

1. Scraping du site de l'IGN
2. Extraction des fichiers par département, région et pour la France
3. Nettoyage des liens (format, doublons)
4. Mise en forme des données avant jointure
5. Jointure avec les topojson 
6. A VENIR : Création automatique du fichier index.html

## Crédits

- [Florian Boret](https://static.geotribu.fr/team/fbor/) & [Julien Moura](https://static.geotribu.fr/team/jmou/), [Geotribu](https://static.geotribu.fr)
- [ouverture des données de l'IGN](https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html)
- contours (métropole et outre-mer) : ADMIN-EXPRESS convertis en topojson avec [https://mapshaper.org](https://mapshaper.org)
