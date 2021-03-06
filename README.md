# Script de génération d'une carte des liens OpenData de l'IGN France

![Run and publish](https://github.com/geotribu/ign-fr-opendata-download-ui/workflows/Run%20and%20publish/badge.svg)

Consulter les 2 articles détaillant la démarche de ce projet sur Geotribu : 

- [Du site à la carte en 7 étapes](https://static.geotribu.fr/articles/2021/2021-02-15_ignfr2map_carte_liens_IGN_open-data_7_etapes/)
- [Automatisation des scripts et déploiement de la carte](https://static.geotribu.fr/articles/2021/2021-02-19_ignfr2map_automatisation_deploiement/).

## Configuration

Copier le fichier `example.env` en `.env` et adapter les paramètres si besoin.

```bash
mv example.env .env
```

## Usage

### Local

Lancer le script :

```bash
bash ignfr2map.sh
```

Placer les fichiers sur un serveur web et ouvrir le fichier `index.html` dans un navigateur internet.

### Déploiement automatisé sur GitHub Pages avec GitHub Actions

Le script est configuré pour être automatiquement exécuté le premier jour de chaque mois et déployer la carte sur GitHub Pages. Voir la carte en ligne [ici](https://geotribu.github.io/ign-fr-opendata-download-ui/index.html).  
Il est également possible de le déclencher manuellement :

1. Se rendre sur [la page de l'Action correspondante](https://github.com/geotribu/ign-fr-opendata-download-ui/actions?query=workflten%20as%20besoinow%3A%22Run+and+publish%22)
2. Dans la liste de gauche des *workflows*, sélectionner `Run and publish`
3. En regard, dérouler la liste déroulante et sélectionner `Run workflow`

![github action manual trigger](https://cdn.geotribu.fr/img/articles-blog-rdp/articles/ign_opendata_map/github_action_workflow_manual_trigger.png "Déclencher manuellement l'exécution par GitHub Actions")

----

## Etapes

1. Scraping du site de l'IGN
2. Extraction des fichiers par département, région et pour la France
3. Nettoyage des liens (format, doublons)
4. Mise en forme des données avant jointure
5. Jointure avec les TopoJSON
6. Création automatique du fichier index.html

## Crédits

- [Florian Boret](https://static.geotribu.fr/team/fbor/) & [Julien Moura](https://static.geotribu.fr/team/jmou/), [Geotribu](https://static.geotribu.fr)
- [Ouverture des données de l'IGN](https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html)
- Contours (métropole et outre-mer) :
  - Source : [ADMIN-EXPRESS](https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html#admin-express) complété par l'ajout du [découpage administratif des COM](https://www.data.gouv.fr/fr/datasets/decoupage-administratif-des-com-st-martin-et-st-barthelemy-format-admin-express/) 
  - Conversion en topojson avec [https://mapshaper.org](https://mapshaper.org)

![Carte IGN Geotribu](https://cdn.geotribu.fr/img/articles-blog-rdp/articles/ign_opendata_map/ign_opendata_map_html_rendu.png "Capture d'écran de la carte déployée sur GitHub Pages")
