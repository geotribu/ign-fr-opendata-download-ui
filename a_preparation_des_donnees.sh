#Récupère la page web
curl https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html > page_ign.txt

#Permet d'extraire les liens
cat page_ign.txt | grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'  > liens_ign.txt

#création du répertoire dep
mkdir dep

#Permet de créer des fichiers par département
grep -E "D001|DEP_001" liens_ign.txt | awk '{ printf("%s,D001\n", $0); }' > dep/D001.csv
grep -E "D002|DEP_002" liens_ign.txt | awk '{ printf("%s,D002\n", $0); }' > dep/D002.csv
grep -E "D003|DEP_003" liens_ign.txt | awk '{ printf("%s,D003\n", $0); }' > dep/D003.csv
grep -E "D004|DEP_004" liens_ign.txt | awk '{ printf("%s,D004\n", $0); }' > dep/D004.csv
grep -E "D005|DEP_005" liens_ign.txt | awk '{ printf("%s,D005\n", $0); }' > dep/D005.csv
grep -E "D006|DEP_006" liens_ign.txt | awk '{ printf("%s,D006\n", $0); }' > dep/D006.csv
grep -E "D006|DEP_007" liens_ign.txt | awk '{ printf("%s,D007\n", $0); }' > dep/D007.csv
grep -E "D008|DEP_008" liens_ign.txt | awk '{ printf("%s,D008\n", $0); }' > dep/D008.csv
grep -E "D009|DEP_009" liens_ign.txt | awk '{ printf("%s,D009\n", $0); }' > dep/D009.csv
grep -E "D010|DEP_010" liens_ign.txt | awk '{ printf("%s,D010\n", $0); }' > dep/D010.csv
grep -E "D011|DEP_011" liens_ign.txt | awk '{ printf("%s,D011\n", $0); }' > dep/D011.csv
grep -E "D012|DEP_012" liens_ign.txt | awk '{ printf("%s,D012\n", $0); }' > dep/D012.csv
grep -E "D013|DEP_013" liens_ign.txt | awk '{ printf("%s,D013\n", $0); }' > dep/D013.csv
grep -E "D014|DEP_014" liens_ign.txt | awk '{ printf("%s,D014\n", $0); }' > dep/D014.csv
grep -E "D015|DEP_015" liens_ign.txt | awk '{ printf("%s,D015\n", $0); }' > dep/D015.csv
grep -E "D016|DEP_016" liens_ign.txt | awk '{ printf("%s,D016\n", $0); }' > dep/D016.csv
grep -E "D017|DEP_017" liens_ign.txt | awk '{ printf("%s,D017\n", $0); }' > dep/D017.csv
grep -E "D018|DEP_018" liens_ign.txt | awk '{ printf("%s,D018\n", $0); }' > dep/D018.csv
grep -E "D019|DEP_019" liens_ign.txt | awk '{ printf("%s,D019\n", $0); }' > dep/D019.csv
grep -E "D02A|DEP_02A" liens_ign.txt | awk '{ printf("%s,D02A\n", $0); }' > dep/D02A.csv
grep -E "D02A|DEP_02B" liens_ign.txt | awk '{ printf("%s,D02B\n", $0); }' > dep/D02B.csv
grep -E "D021|DEP_021" liens_ign.txt | awk '{ printf("%s,D021\n", $0); }' > dep/D021.csv
grep -E "D022|DEP_022" liens_ign.txt | awk '{ printf("%s,D022\n", $0); }' > dep/D022.csv
grep -E "D023|DEP_023" liens_ign.txt | awk '{ printf("%s,D023\n", $0); }' > dep/D023.csv
grep -E "D024|DEP_024" liens_ign.txt | awk '{ printf("%s,D024\n", $0); }' > dep/D024.csv
grep -E "D025|DEP_025" liens_ign.txt | awk '{ printf("%s,D025\n", $0); }' > dep/D025.csv
grep -E "D026|DEP_026" liens_ign.txt | awk '{ printf("%s,D026\n", $0); }' > dep/D026.csv
grep -E "D027|DEP_027" liens_ign.txt | awk '{ printf("%s,D027\n", $0); }' > dep/D027.csv
grep -E "D028|DEP_028" liens_ign.txt | awk '{ printf("%s,D028\n", $0); }' > dep/D028.csv
grep -E "D029|DEP_029" liens_ign.txt | awk '{ printf("%s,D029\n", $0); }' > dep/D029.csv
grep -E "D030|DEP_030" liens_ign.txt | awk '{ printf("%s,D030\n", $0); }' > dep/D030.csv
grep -E "D031|DEP_031" liens_ign.txt | awk '{ printf("%s,D031\n", $0); }' > dep/D031.csv
grep -E "D032|DEP_032" liens_ign.txt | awk '{ printf("%s,D032\n", $0); }' > dep/D032.csv
grep -E "D033|DEP_033" liens_ign.txt | awk '{ printf("%s,D033\n", $0); }' > dep/D033.csv
grep -E "D034|DEP_034" liens_ign.txt | awk '{ printf("%s,D034\n", $0); }' > dep/D034.csv
grep -E "D035|DEP_035" liens_ign.txt | awk '{ printf("%s,D035\n", $0); }' > dep/D035.csv
grep -E "D036|DEP_036" liens_ign.txt | awk '{ printf("%s,D036\n", $0); }' > dep/D036.csv
grep -E "D037|DEP_037" liens_ign.txt | awk '{ printf("%s,D037\n", $0); }' > dep/D037.csv
grep -E "D038|DEP_038" liens_ign.txt | awk '{ printf("%s,D038\n", $0); }' > dep/D038.csv
grep -E "D039|DEP_039" liens_ign.txt | awk '{ printf("%s,D039\n", $0); }' > dep/D039.csv
grep -E "D040|DEP_040" liens_ign.txt | awk '{ printf("%s,D040\n", $0); }' > dep/D040.csv
grep -E "D041|DEP_041" liens_ign.txt | awk '{ printf("%s,D041\n", $0); }' > dep/D041.csv
grep -E "D042|DEP_042" liens_ign.txt | awk '{ printf("%s,D042\n", $0); }' > dep/D042.csv
grep -E "D043|DEP_043" liens_ign.txt | awk '{ printf("%s,D043\n", $0); }' > dep/D043.csv
grep -E "D044|DEP_044" liens_ign.txt | awk '{ printf("%s,D044\n", $0); }' > dep/D044.csv
grep -E "D045|DEP_045" liens_ign.txt | awk '{ printf("%s,D045\n", $0); }' > dep/D045.csv
grep -E "D046|DEP_046" liens_ign.txt | awk '{ printf("%s,D046\n", $0); }' > dep/D046.csv
grep -E "D047|DEP_047" liens_ign.txt | awk '{ printf("%s,D047\n", $0); }' > dep/D047.csv
grep -E "D048|DEP_048" liens_ign.txt | awk '{ printf("%s,D048\n", $0); }' > dep/D048.csv
grep -E "D049|DEP_049" liens_ign.txt | awk '{ printf("%s,D049\n", $0); }' > dep/D049.csv
grep -E "D050|DEP_050" liens_ign.txt | awk '{ printf("%s,D050\n", $0); }' > dep/D050.csv
grep -E "D051|DEP_051" liens_ign.txt | awk '{ printf("%s,D051\n", $0); }' > dep/D051.csv
grep -E "D052|DEP_052" liens_ign.txt | awk '{ printf("%s,D052\n", $0); }' > dep/D052.csv
grep -E "D053|DEP_053" liens_ign.txt | awk '{ printf("%s,D053\n", $0); }' > dep/D053.csv
grep -E "D054|DEP_054" liens_ign.txt | awk '{ printf("%s,D054\n", $0); }' > dep/D054.csv
grep -E "D055|DEP_055" liens_ign.txt | awk '{ printf("%s,D055\n", $0); }' > dep/D055.csv
grep -E "D056|DEP_056" liens_ign.txt | awk '{ printf("%s,D056\n", $0); }' > dep/D056.csv
grep -E "D057|DEP_057" liens_ign.txt | awk '{ printf("%s,D057\n", $0); }' > dep/D057.csv
grep -E "D058|DEP_058" liens_ign.txt | awk '{ printf("%s,D058\n", $0); }' > dep/D058.csv
grep -E "D059|DEP_059" liens_ign.txt | awk '{ printf("%s,D059\n", $0); }' > dep/D059.csv
grep -E "D060|DEP_060" liens_ign.txt | awk '{ printf("%s,D060\n", $0); }' > dep/D060.csv
grep -E "D061|DEP_061" liens_ign.txt | awk '{ printf("%s,D061\n", $0); }' > dep/D061.csv
grep -E "D062|DEP_062" liens_ign.txt | awk '{ printf("%s,D062\n", $0); }' > dep/D062.csv
grep -E "D063|DEP_063" liens_ign.txt | awk '{ printf("%s,D063\n", $0); }' > dep/D063.csv
grep -E "D064|DEP_064" liens_ign.txt | awk '{ printf("%s,D064\n", $0); }' > dep/D064.csv
grep -E "D065|DEP_065" liens_ign.txt | awk '{ printf("%s,D065\n", $0); }' > dep/D065.csv
grep -E "D066|DEP_066" liens_ign.txt | awk '{ printf("%s,D066\n", $0); }' > dep/D066.csv
grep -E "D067|DEP_067" liens_ign.txt | awk '{ printf("%s,D067\n", $0); }' > dep/D067.csv
grep -E "D068|DEP_068" liens_ign.txt | awk '{ printf("%s,D068\n", $0); }' > dep/D068.csv
grep -E "D069|DEP_069" liens_ign.txt | awk '{ printf("%s,D069\n", $0); }' > dep/D069.csv
grep -E "D070|DEP_070" liens_ign.txt | awk '{ printf("%s,D070\n", $0); }' > dep/D070.csv
grep -E "D071|DEP_071" liens_ign.txt | awk '{ printf("%s,D071\n", $0); }' > dep/D071.csv
grep -E "D072|DEP_072" liens_ign.txt | awk '{ printf("%s,D072\n", $0); }' > dep/D072.csv
grep -E "D073|DEP_073" liens_ign.txt | awk '{ printf("%s,D073\n", $0); }' > dep/D073.csv
grep -E "D074|DEP_074" liens_ign.txt | awk '{ printf("%s,D074\n", $0); }' > dep/D074.csv
grep -E "D075|DEP_075" liens_ign.txt | awk '{ printf("%s,D075\n", $0); }' > dep/D075.csv
grep -E "D076|DEP_076" liens_ign.txt | awk '{ printf("%s,D076\n", $0); }' > dep/D076.csv
grep -E "D077|DEP_077" liens_ign.txt | awk '{ printf("%s,D077\n", $0); }' > dep/D077.csv
grep -E "D078|DEP_078" liens_ign.txt | awk '{ printf("%s,D078\n", $0); }' > dep/D078.csv
grep -E "D079|DEP_079" liens_ign.txt | awk '{ printf("%s,D079\n", $0); }' > dep/D079.csv
grep -E "D080|DEP_080" liens_ign.txt | awk '{ printf("%s,D080\n", $0); }' > dep/D080.csv
grep -E "D081|DEP_081" liens_ign.txt | awk '{ printf("%s,D081\n", $0); }' > dep/D081.csv
grep -E "D082|DEP_082" liens_ign.txt | awk '{ printf("%s,D082\n", $0); }' > dep/D082.csv
grep -E "D083|DEP_083" liens_ign.txt | awk '{ printf("%s,D083\n", $0); }' > dep/D083.csv
grep -E "D084|DEP_084" liens_ign.txt | awk '{ printf("%s,D084\n", $0); }' > dep/D084.csv
grep -E "D085|DEP_085" liens_ign.txt | awk '{ printf("%s,D085\n", $0); }' > dep/D085.csv
grep -E "D086|DEP_086" liens_ign.txt | awk '{ printf("%s,D086\n", $0); }' > dep/D086.csv
grep -E "D087|DEP_087" liens_ign.txt | awk '{ printf("%s,D087\n", $0); }' > dep/D087.csv
grep -E "D088|DEP_088" liens_ign.txt | awk '{ printf("%s,D088\n", $0); }' > dep/D088.csv
grep -E "D089|DEP_089" liens_ign.txt | awk '{ printf("%s,D089\n", $0); }' > dep/D089.csv
grep -E "D090|DEP_090" liens_ign.txt | awk '{ printf("%s,D090\n", $0); }' > dep/D090.csv
grep -E "D091|DEP_091" liens_ign.txt | awk '{ printf("%s,D091\n", $0); }' > dep/D091.csv
grep -E "D092|DEP_092" liens_ign.txt | awk '{ printf("%s,D092\n", $0); }' > dep/D092.csv
grep -E "D093|DEP_093" liens_ign.txt | awk '{ printf("%s,D093\n", $0); }' > dep/D093.csv
grep -E "D094|DEP_094" liens_ign.txt | awk '{ printf("%s,D094\n", $0); }' > dep/D094.csv
grep -E "D095|DEP_095" liens_ign.txt | awk '{ printf("%s,D095\n", $0); }' > dep/D095.csv
grep -E "D971|DEP_971" liens_ign.txt | awk '{ printf("%s,D971\n", $0); }' > dep/D971.csv
grep -E "D972|DEP_972" liens_ign.txt | awk '{ printf("%s,D972\n", $0); }' > dep/D972.csv
grep -E "D973|DEP_973" liens_ign.txt | awk '{ printf("%s,D973\n", $0); }' > dep/D973.csv
grep -E "D974|DEP_974" liens_ign.txt | awk '{ printf("%s,D974\n", $0); }' > dep/D974.csv
grep -E "D975|DEP_975" liens_ign.txt | awk '{ printf("%s,D975\n", $0); }' > dep/D975.csv
grep -E "D976|DEP_976" liens_ign.txt | awk '{ printf("%s,D976\n", $0); }' > dep/D976.csv

#Fusion des fichiers csv
cat dep/*csv > liens_par_dep.csv
