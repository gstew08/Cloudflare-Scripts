#!/bin/bash

extip=$(curl ifconfig.me)
extip=$extip/32

oldextip=$(cat /file/location/oldextip)

if [ $extip != $oldextip ]; then

curl --request PUT \
  --url https://api.cloudflare.com/client/v4/accounts/<accountidentifier>/gateway/locations/<uuid> \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer <account api token>' \
  --data '{
  "client_default": true,
  "ecs_support": false,
  "name": "<LocationName>",
  "networks": [
   {
     "network": "'"$extip"'"
   }
  ]
}'

echo $extip > /file/location/oldextip
echo "IP Updated" >> /file/location/cloudflare-updategatewaylocation.log
else
 echo "They are the same"
fi
