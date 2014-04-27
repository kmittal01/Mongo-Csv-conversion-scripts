#!/bin/bash
count=0
while read line

do
	arr[$count]=$line
	count=$((count+1))
done<$1
IFS="," read -a array_header<<<"${arr[0]}"
echo "${array_header[0]}"
counter=0
for j in {1..7}
# for j in {1..${#arr[@]}}
do
	json_str='{'
	IFS="," read -a arr_text<<<"${arr[$j]}"
for i in {1..3}
do
	a='"'
	b="${array_header[$i]}"
	c='":"'
	d="${arr_text[i]}"
	e='",'
	json_str=$json_str$a$b$c$d$e   
done
json_str=${json_str:0:${#json_str}-1}
json_str=$json_str'}'
arr_json[$counter]=$json_str
counter=$((counter+1))
done

for element in "${arr_json[@]}"
do
    echo "${element}"
	mongo MongoToCsvScript4 --eval 'db.user_details4.insert('${element}')'
done
	
# echo 'db.testData.insert('${element}')'


