# Deuxième étape : extraction des liens par départements dans des fichiers CSV

# Le petit manuel
if [ "$1" == "-h" ] ; then
    echo "Usage: ./`basename $0` _temp/1_scraping/1_liens.txt _temp/2_departements \"001,002,003,004,005,006,007,008,009,010,011,012,013,014,015,016,017,018,019,02A,02B,002A,002B,021,022,023,024,025,026,027,028,029,030,031,032,033,034,035,036,037,038,039,040",,"041,042,043,044,045,046,047,048,049,050,051,052,053,054,055,056,057,058,059,060,061,062,063,064,065,066,067,068,069,070,071,072,073,074,075,076,077,078,079,080,081,082,083,084,085,086,087,088,089,090,091,092,093,094,095,971,972,973,974,975,976\""
    echo "Show this help: ./`basename $0` -h"
    exit 0
fi


# Arguments
SOURCE_FILE=$1
OUTPUT_DIR=$2
IFS="," read -a ARRAY_DEPARTEMENTS <<< $3

# Création du répertoire parent
[ -d $OUTPUT_DIR ] || mkdir -p $OUTPUT_DIR

# Permet de créer des fichiers par département
for val in ${ARRAY_DEPARTEMENTS[@]}; do
  val_t=$(echo $val | head -c 3)
  echo "Extraction département : $val_t"
  # Exceptions
  if [ "$val" = "002A" ] || [ "$val" = "002B" ]|| [ "$val" = "0003" ]; then
      grep -E "D$val|DEP_$val" $SOURCE_FILE | awk '{ printf("%s,D'${val: -3}'\n", $0); }' >> "$OUTPUT_DIR/D${val: -3}.csv"
    else
      grep -E "D$val|DEP_$val" $SOURCE_FILE | awk '{ printf("%s,D'$val_t'\n", $0); }' > "$OUTPUT_DIR/D$val_t.csv"
    fi
done
