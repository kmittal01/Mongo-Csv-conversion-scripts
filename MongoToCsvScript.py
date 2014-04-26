from pymongo import MongoClient
import datetime
import json

client=MongoClient('localhost',27017)
db=client['MongoToCsvScript4']
collection=db['user_details3']
# post = {"author": "Mike2","text": "My first blog post2!","tag": "mongodb2"}
# post_id=collection.insert(post)

def find_me(s, ch):
    return [i for i, ltr in enumerate(s) if ltr == ch]

flag=0
array_lines=[]
header=''

for post in collection.find():
	arr_words=[]
	line=''
	arr1=find_me(str(post),"'")
	for i in range(len(arr1)):
		if (i%2==0):
			arr_words.append(str(post)[(arr1[i]+1):(arr1[i+1])])
	for i in range (len(arr_words)):
		if (i%2!=0):
			line=line+str(arr_words[i])+','
	line=line[0:-1]
	array_lines.append(line)
	if flag==0:
		for i in range (len(arr_words)):
			if (i%2==0):
				header=header+str(arr_words[i])+','
		flag=1
		header=header[0:-1]
f=open("output.csv","w")
f.write(header+"\n")
for i in range (len(array_lines)):
	f.write(array_lines[i]+"\n")
f.close()
	
