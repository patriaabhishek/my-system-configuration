#!/bin/bash

rootca_labels=( "IVZ_DEV_ROOT_CA" "IVZ_ROOT_CA" "InvescoGlobalRootCAD1" "InvescoGlobalRootCAP1" )
rootca_urls=( 'http://pki.corpdev.dev/CertEnroll/USHOUCART01VD_IVZ%20DEV%20ROOT%20CA(2).crt' 'http://pki.corp.amvescap.net/pki/USHOUCART11V_IVZ%20ROOT%20CA(1).crt' 'http://pki.dev.invesco.net/certenroll/USDSVRTCAWD100_Invesco%20Global%20Root%20CA%20D1.crt' 'http://pki.prd.invesco.net/certenroll/USDSVRTCAWP100.corp.amvescap.net_Invesco%20Global%20Root%20CA%20P1.crt' )

# http://pki.dev.invesco.net/certenroll
# http://pki.prd.invesco.net/certenroll
# https://pki.corpdev.dev/CertEnroll/
# http://pki.corp.amvescap.net/pki

for index in "${!rootca_urls[@]}"; do
    label=${rootca_labels[$index]}
    url=${rootca_urls[$index]}
    echo $label from $url
    curl -s -o ${label}.crtr $url
    openssl x509 -inform der -in ${label}.crtr -out ${label}.crt && rm ${label}.crtr
    chmod 644 ${label}.crt
done

ls -ltra

mv *.crt /usr/local/share/ca-certificates
