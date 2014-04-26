#!/bin/bash
mongo --quiet MongoToCsvScript4 --eval 'printjson(db.user_details3.find().toArray())' > output.json
cut -d ':' -f2 output.json >new_output.json 
cut -d ':' -f1 output.json >new_output_header.json 
cat new_output.json | tr -d " \t\n\r" > output.json
sed -e "s/},{/\n/g" <output.json >new_output.json
cat new_output.json | tr -d "}]" > output.json
cat output.json | tr -d "[{" > new_output.json
cat new_output.json | tr -d '"' > output.json
vari=$(<new_output_header.json)
s2="},"
vari2=$(awk -v a="$vari" -v b="$s2" 'BEGIN{print index(a,b)}')
echo ${vari:0:$vari2}>header.json
sed -e "s/ /,/g" <header.json >header2.json
cat header2.json | tr -d '"' > header.json
vari4=$(<header.json)
echo ${vari4:4}>header.json
cat header.json | tr -d '}' > header2.json
cat header2.json output.json > final.csv
rm new_output_header.json header.json header2.json new_output.json output.json
