from bs4 import BeautifulSoup
import os

html = open('search.html', 'r')
soup = BeautifulSoup(html, 'html.parser')
html.close()
os.remove('search.html')

#print(soup.prettify())
for link in soup.find_all('a'):
    torrent = link.get('href')
    if torrent and "/torrent/" in torrent:
        print(torrent)