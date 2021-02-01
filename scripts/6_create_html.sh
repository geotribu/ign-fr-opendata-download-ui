# sixième étape : Permet de créer l'index.html

# Le petit manuel
if [ "$1" == "-h" ] ; then
    echo "Usage: ./`basename $0` departements \"BDTOPO,PLANIGN,ORTHOHR,BDFORET,DNSB-HAIES,PARCELLAIRE_EXPRESS,BDPARCELLAIRE,RGEALTI,BDORTHO\" regions \"SCAN50_HISTORIQUE,SCANEM40K,RPG,BDTOPO\" france \" ADMIN-EXPRESS,GEOFLA,BDPR,BDTOPO,BDALTI,CONTOURS-IRIS,GEODESIE,PARCELLAIRE_EXPRESS,PLANIGN,ROUTE500,RPG,SCAN1000,SCANREG\""
    echo "Show this help: ./`basename $0` -h"
    exit 0
fi
################################################################################################################################################################
# Arguments
TYPE_DEP=$1
IFS="," read -a ARRAY_INDEX_DEP <<< $2

VAR1_DEP=""
VAR2_DEP=""
VAR3_DEP=""
for val_dep in ${ARRAY_INDEX_DEP[@]}; do
   echo $val_dep
   value_dep="$(tr [A-Z] [a-z] <<< "${val_dep//-/_}")"

VAR3_DEP+=${DEP}

VAR1_DEP+=$(echo "var ign_"$value_dep"=omnivore.topojson(\'output/departements_"$value_dep".json\').on(\"ready\", function() {attachPopups_ign_"$value_dep"();});\n")
VAR2_DEP+=$(echo "\"DEP - "$val_dep"\": ign_"$value_dep",\n")

read -r -d '' DEP <<EOI
function attachPopups_ign_$value_dep() {\\
ign_$value_dep.eachLayer(function popUp (layer) {\\
var props = layer.feature.properties;\\
var out = [];\\
if (props){\\
  for(var key in props){\\
    if (key != "id" && key != "ID" && key != "NOM_DEP_M" && key != "NOM_DEP" && key != "INSEE_DEP" && key != "INSEE_REG" && key != "INSEE_REG" && key != "DEP" && key != "lien1")  {\\
      if (layer.feature.properties[key] != "")  {\\
      var targetValue = layer.feature.properties[key].substr(layer.feature.properties[key].lastIndexOf('/') + 1);\\
      out.push(/*key+": "+*/'<a href="'+layer.feature.properties[key]+'">'+targetValue+'</a>');\\
      }\\
    }\\
  }\\
}\\
layer.bindPopup(out.join("<br />"), {\\
 maxWidth : 1500\\
})\\
});\\
};
EOI

VAR3_DEP+=${DEP}


done


################################################################################################################################################################

TYPE_REGION=$3
IFS="," read -a ARRAY_INDEX_REGION <<< $4

VAR1_REGION=""
VAR2_REGION=""
VAR3_REGION=""
for val_region in ${ARRAY_INDEX_REGION[@]}; do
   echo $val_region
   value_region="$(tr [A-Z] [a-z] <<< "${val_region//-/_}")"

VAR3_REGION+=${REGION}

VAR1_REGION+=$(echo "var ign_"$value_region"=omnivore.topojson(\'output/regions_"$value_region".json\').on(\"ready\", function() {attachPopups_ign_"$value_region"();});\n")
VAR2_REGION+=$(echo "\"REGION - "$val_region"\": ign_"$value_region",\n")

read -r -d '' REGION <<EOI
function attachPopups_ign_$value_region() {\\
ign_$value_region.eachLayer(function popUp (layer) {\\
var props = layer.feature.properties;\\
var out = [];\\
if (props){\\
  for(var key in props){\\
    if (key != "id" && key != "ID" && key != "NOM_REG_M" && key != "NOM_REG" && key != "INSEE_REG" && key != "REG" && key != "lien1")  {\
      if (layer.feature.properties[key] != "")  {\\
      var targetValue = layer.feature.properties[key].substr(layer.feature.properties[key].lastIndexOf('/') + 1);\\
      out.push(/*key+": "+*/'<a href="'+layer.feature.properties[key]+'">'+targetValue+'</a>');\\
      }\\
    }\\
  }\\
}\\
layer.bindPopup(out.join("<br />"), {\\
 maxWidth : 1500\\
})\\
});\\
};
EOI

VAR3_REGION+=${REGION}


done


################################################################################################################################################################
# Arguments
TYPE_FR=$5
IFS="," read -a ARRAY_INDEX_FR <<< $6

VAR1_FR=""
VAR2_FR=""
VAR3_FR=""
for val_fr in ${ARRAY_INDEX_FR[@]}; do
   echo $val_fr
   value_fr="$(tr [A-Z] [a-z] <<< "${val_fr//-/_}")"

VAR3_FR+=${FR}

VAR1_FR+=$(echo "var ign_"$value_fr"=omnivore.topojson(\'output/france_"$value_fr".json\').on(\"ready\", function() {attachPopups_ign_"$value_fr"();});\n")
VAR2_FR+=$(echo "\"FR - "$val_fr"\": ign_"$value_fr",\n")

read -r -d '' FR <<EOI
function attachPopups_ign_$value_fr() {\\
ign_$value_fr.eachLayer(function popUp (layer) {\\
var props = layer.feature.properties;\\
var out = [];\\
if (props){\\
  for(var key in props){\\
    if (key != "id" && key != "ID" && key != "FR" && key != "NOM" && key != "lien1")  {\\
      if (layer.feature.properties[key] != "")  {\\
      var targetValue = layer.feature.properties[key].substr(layer.feature.properties[key].lastIndexOf('/') + 1);\\
      out.push(/*key+": "+*/'<a href="'+layer.feature.properties[key]+'">'+targetValue+'</a>');\\
      }\\
    }\\
  }\\
}\\
layer.bindPopup(out.join("<br />"), {\\
 maxWidth : 1500\\
})\\
});\\
};
EOI

VAR3_FR+=${FR}


done


sed 's|REPLACE_FILE_DEP|'"$VAR1_DEP"'|g; s|REPLACE_TITLE_DEP|'"$VAR2_DEP"'|g; s|REPLACE_POPUP_DEP|'"$VAR3_DEP"'|g; s|REPLACE_POPUP_DEPREPLACE_POPUP_DEP|\&\&|g;
s|REPLACE_FILE_REGION|'"$VAR1_REGION"'|g; s|REPLACE_TITLE_REGION|'"$VAR2_REGION"'|g; s|REPLACE_POPUP_REGION|'"$VAR3_REGION"'|g; s|REPLACE_POPUP_REGIONREPLACE_POPUP_REGION|\&\&|g;
s|REPLACE_FILE_FR|'"$VAR1_FR"'|g; s|REPLACE_TITLE_FR|'"$VAR2_FR"'|g; s|REPLACE_POPUP_FR|'"$VAR3_FR"'|g; s|REPLACE_POPUP_FRREPLACE_POPUP_FR|\&\&|g;'  index_test.html > index_ign2map.html
