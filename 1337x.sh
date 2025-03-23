#! /usr/bin/bash

if [ -z "$2" ]; then
    echo "Utilizzo: $0 [query] [pages] [-t]"
    echo "  -t = magnets to .torrent"
    exit 1
fi

rm -rf paths.txt

query=$(echo "$1" | tr ' ' '+')
for ((i=1; i<=$2; i++)); do
    curl -s "https://www.1337x.to/search/$query/$i/" --compressed -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' -H 'Accept-Encoding: gzip, deflate, br, zstd' -H 'Referer: https://www.1337x.to/search/italiano/1/' -H 'Alt-Used: www.1337x.to' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'Sec-Fetch-Dest: document' -H 'Sec-Fetch-Mode: navigate' -H 'Sec-Fetch-Site: same-origin' -H 'Sec-Fetch-User: ?1' -H 'Priority: u=0, i' -H 'TE: trailers' > search.html
    python3 parser.py >> paths.txt
done

python3 link2magnet.py > magnets.txt
rm -rf paths.txt

if [[ $# -ge 3 && "$3" == "-t" ]]; then
    mkdir -p torrents
    mv magnets.txt torrents
    cd torrents
    demagnetize batch magnets.txt
    rm magnets.txt
    cd ..
fi
