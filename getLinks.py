import sys
import requests
import json
import time

def printFile(zipLinks, n_lezione):
    file_name = 'testzips'+str(n_lezione)+'.txt'
    f = open(file_name, 'w+')
    f.write(zipLinks)
    f.close()

if(len(sys.argv) != 2):
    print("USAGE: python3.6 get_links.py X")
    sys.exit()

n_lezione = int(sys.argv[1])
lezione_cercata = 'Lezione '+ str(n_lezione)
main_url = 'http://algo1920.dijkstra.di.unipi.it/api/lessons'
lesson_url = 'http://algo1920.dijkstra.di.unipi.it/api/task'
payload = {"action":"list"}
headers = {'content-type': 'application/json;charset=UTF-8'}

r = requests.post(main_url, data=json.dumps(payload), headers=headers)
if(r.status_code == 200):
    lessons = r.json()
    i = 0
    found = False
    n_lezioni = len(lessons["lessons"])
    while(not found and i < n_lezioni):
        if(lezione_cercata == lessons["lessons"][i]["title"]):
            found = True
        else:
            i+=1
    if(found):
        esercizi_lezione = lessons["lessons"][i]["tasks"]
        zipLinks = ''
        for esercizio in esercizi_lezione:
            payload = {"name":esercizio["name"],"action":"get"}
            r = requests.post(lesson_url, data=json.dumps(payload), headers=headers)
            print(esercizio["title"]+'. . .\n')
            time.sleep(2)
            if(r.status_code == 200):
                lesson = r.json()
                ziplink_part = lesson["attachments"][0][1] + '/' + lesson["attachments"][0][0]
                zipLinks += 'http://algo1920.dijkstra.di.unipi.it/api/files/' + ziplink_part +'\n'
        printFile(zipLinks, n_lezione)
    else:
        print("Lezione non trovata")
