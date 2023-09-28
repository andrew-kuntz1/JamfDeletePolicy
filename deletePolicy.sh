#!/bin/bash

user="USERNAME_HERE"
password="PASSWORD_HERE"
url="https://URL_HERE.jamfcloud.com"
policyID="ID_HERE"

# Get username and password encoded in base64 format and stored as a variable in a script:
encodedCredentials=$( printf "$user:$password" | /usr/bin/iconv -t ISO-8859-1 | /usr/bin/base64 -i - )

# Use encoded username and password to request a token with an API call and store the output as a variable in a script:
token=$(/usr/bin/curl $url/uapi/auth/tokens -s -X POST -H "Authorization: Basic $encodedCredentials" | grep token | awk '{print $3}' | tr -d ',"')

echo $token

/usr/bin/curl -ks -H "content-type: text/xml" -H "Authorization: Bearer $token" $url/JSSResource/policies/id/$policyID -X DELETE

