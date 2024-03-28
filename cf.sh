#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

apt install jq curl -y
IP=$(wget -qO- icanhazip.com)
DOMAIN=gilergames.tk
#sub=$(</dev/urandom tr -dc a-z0-9 | head -c4)
echo "    Cloudflare with SNI Bug "
echo "Enter your ISPbughost pointed VPS IP "
read -rp " Enteer : " -e host
SUB_DOMAIN=${sub}.onedata.my.id
set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/1281e4a960f86c00001b88f143e292ba/dns_records" \
     -H "Content-Type: application/json" \
     -H "X-Auth-Email: foreverwelearn@gmail.com" \
     -H "X-Auth-Key: 1296c6be4d1fd676728ff11f720c3fb31b939" \
     --data '{"type":"A","name":"${sub}.onedata.my.id","content":"${IP}","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/1281e4a960f86c00001b88f143e292ba/dns_records/${sub}.onedata.my.id" \
     -H "X-Auth-Email: foreverwelearn@gmail.com" \
     -H "X-Auth-Key: 1296c6be4d1fd676728ff11f720c3fb31b939" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"${sub}.onedata.my.id","content":"$IP","ttl":120,"proxied":false}')
echo "IP=$SUB_DOMAIN" > /var/lib/premium-script/ipvps.txt
echo $SUB_DOMAIN > /root/domain
rm -f /root/cf.sh
