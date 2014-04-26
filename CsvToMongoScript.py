from pymongo import MongoClient
import datetime
import json

client=MongoClient('localhost',27017)
db=client['MongoToCsvScript4']
collection=db['user_details3']
# post = {"author": "Mike2","text": "My first blog post2!","tag": "mongodb2"}
# post_id=collection.insert(post)
f=open("output.csv","r")
arr=[]

for line in f:
	arr.append(line[0:-1])
# print arr
arr_json=[]
arr_header=arr[0].split(',') 
for j in range(1,len(arr)):
	json_str='{'
	arr_text=arr[j].split(',')
	for i in range(len(arr_header)):
		json_str=json_str+'"'+arr_header[i]+'":"'+arr_text[i]+'",'
	json_str=json_str[0:-1]+"}"
	arr_json.append(json_str)

for i in range (len(arr_json)):
	print collection.insert(json.loads(arr_json[i]))