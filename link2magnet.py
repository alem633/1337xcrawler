import requests
from bs4 import BeautifulSoup

pPaths = open('paths.txt', 'r')

links = []

for path in pPaths:
    path = path.replace('\n', '')
    links.append(path)

for i in range(0, len(links)):
    links[i] = 'https://www.1337x.to' + links[i]

for link in links:
    r = requests.get(link)
    soup = BeautifulSoup(r.text, 'html.parser')
    for alink in soup.find_all('a'):
        magnet = alink.get('href')
        if magnet and "magnet" in magnet:
            print(magnet + "\n")
            break

pPaths.close()