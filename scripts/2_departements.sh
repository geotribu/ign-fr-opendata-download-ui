# Création du répertoire 2_dep
[ -d _temp/2_departements ] || mkdir -p _temp/2_departements

# Permet de créer des fichiers par département
declare -a StringArray=("001_" "002_" "003_" "0003" "004_" "005_" "006_" "007_" "008_" "009_" "010_" "011_" "012_" "013_" "014_" "015_" "016_" "017_" "018_" "019_" "02A_" "02B_" "002A" "002B" "021_" "022_" "023_" "024_" "025_" "026_" "027_" "028_" "029_" "030_" "031_" "032_" "033_" "034_" "035_" "036_" "037_" "038_" "039_" "040_" "041_" "042_" "043_" "044_" "045_" "046_" "047_" "048_" "049_" "050_" "051_" "052_" "053_" "054_" "055_" "056_" "057_" "058_" "059_" "060_" "061_" "062_" "063_" "064_" "065_" "066_" "067_" "068_" "069_" "070_" "071_" "072_" "073_" "074_" "075_" "076_" "077_" "078_" "079_" "080_" "081_" "082_" "083_" "084_" "085_" "086" "087_" "088_" "089_" "090_" "091_" "092_" "093_" "094_" "095_" "971_" "972_" "973_" "974_" "975_" "976_")
for val in ${StringArray[@]}; do
   val_t=$(echo $val | head -c 3)
   # Exceptions
   if [ "$val" = "002A" ] || [ "$val" = "002B" ]|| [ "$val" = "0003" ]; then
        grep -E "D$val|DEP_$val" _temp/1_scraping_liens/liens_ign.txt | awk '{ printf("%s,D'${val: -3}'\n", $0); }' >> '_temp/2_departements/D'${val: -3}'.csv'
      else
        grep -E "D$val|DEP_$val" _temp/1_scraping_liens/liens_ign.txt | awk '{ printf("%s,D'$val_t'\n", $0); }' > _temp/2_departements/D$val_t.csv
      fi
done
