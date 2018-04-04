import requests
import re

URL = 'http://127.0.0.1'

#  constants 
ACAOstar = "\'Access-Control-Allow-Origin\': \'\*\'"
ACAOnull = "\'Access-Control-Allow-Origin\': \'null\'"


#  program starts
r = requests.get(URL)

print (URL)
print ("STATUS: " + str(r.status_code))

# find ACAO in server HEADERS (with * or NULL)
finds = re.search(ACAOstar, str(r.headers))
findn = re.search(ACAOnull, str(r.headers))
# print if founded
if finds:
    print (str(finds.group(0)))
else:
    if findn:
        print (str(findn.group(0)))
    else:
        print ("Access-Control-Allow-Origin (not null or *)")


# print ("HEADERS: \n" + str(r.headers))
# print ("CONTENT: \n" + r.content)
# print ("HERE: " + str(r.cookies))

