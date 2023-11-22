# ``Certificates``


## Overview

This document describes the process of receiving russian digital goverment certificate and converting it to another formats such as `der`, `cer` `crt`.

 
## Pre-requires 

1. Homebrew package manager. See: https://brew.sh/
2. openssl brew formula 
3. You can run mac os terminal command in the directory of file location
 
### Downloading

- `russiantrustedca.pem` - file is originaly downloaded from `https://www.gosuslugi.ru/crt`. Choose Mac Os certificates. 

### Converting

- `russiantrustedca.der` - converted from pem file to der with help of Mac OS terminal command `openssl x509 -outform der -in russiantrustedca.pem -out russiantrustedca.der `

- `russiantrustedca.crt` - converted from pem file to crt with help of Mac OS terminal command
`openssl x509 -outform der -in russiantrustedca.pem -out russiantrustedca.crt`       

- `russiantrustedrootca.cer` - see intruction below
- `russiantrustedsubca.cer` - see intruction below

1) Split one pem file to sub and root files with help of Mac OS terminal command:
`split -p "-----BEGIN CERTIFICATE-----" russiantrustedca.pem individual-` 
2) Two files individual-aa and individual-ab will be produced 
3) Add cer / crt to the end of files
4) Rename file which ends on "aa" to russiantrustedsubca
5) Rename file which ends on "ab" to russiantrustedrootca 

