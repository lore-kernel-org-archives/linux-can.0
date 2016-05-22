From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Sun, 22 May 2016 22:27:32 +0200
Message-ID: <57421634.5050607@posteo.de>
References: <573E491E.1000906@denx.de>
 <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com>
 <573EAE9D.20006@hartkopp.net> <573EFC23.2040906@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040405040306010901000903"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:37485 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493AbcEVU1j (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 22 May 2016 16:27:39 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 2789020AE9
	for <linux-can@vger.kernel.org>; Sun, 22 May 2016 22:27:33 +0200 (CEST)
In-Reply-To: <573EFC23.2040906@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms040405040306010901000903
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

>> I remember a K-Line implementation for Linux where we had a MPC5200 UA=
RT
>> which we programmed with bit-banging of some control line to do the
>> 5bit/s opening pattern.
>> After that we went to 10400 bit/s and did some K-Line communication.
>> All this was done by a user space application on /dev/ttyS0.
>=20
> Yes, and this does make perfect sense until you start dealing with
> faster modes and need more precise timing. The K-Line is limited by
> 250kBaud/s bus speed.
>=20

Hello Marek,

Afaik there is no ECU left that actually needs the "5 Baud INIT".
Most ECUs use the "FAST INIT" procedure, means 25ms low, 25ms high, then
start communication with 10400Baud.

The nasty part are the 25ms low, 25ms high , that is also prior to the 5
Baud Init pattern.

After that, everything on the K-Line is pure serial communication.

I've done a few test myself with an FT232RL based KKL-Interface and
these 25ms low, 25ms high are very hard to realize. No Success at my end.=


=46rom my point of view, the 25ms low, 25ms high are the only reason to
move into kernel space and possibly switch the Tx Pin to GPIO and pull
it low/high for 25ms, then switch it back to UART.

Regards,
Patrick



--------------ms040405040306010901000903
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CfcwggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQsw
CQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4
dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290
MB4XDTE0MTIyMjAwMDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAImxDdp6UxlOcFIdvFamBia3uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdh
TpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYepLkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak
+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayTQLm1CJM6nCpToxDbPSBhPFUDjtlOdiUC
ISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9UjewM2ktQ+v61qXxl3dnUYzZ7ifr
vKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3RhUL7GQD/L5OKfoiECAwEAAaOC
ARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1QaMB0GA1UdDgQWBBSSYWuC
4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAd
BgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRVHSAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4dGVybmFs
Q0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb
4yJjnFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ
26Y3NOh74AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT
9HaSyoY0B7ksyuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInl
tukWeh95FPZKEBom+nyK+5swggVAMIIEKKADAgECAhEAgXWYtApfLyFhHovG0eoOwTANBgkq
hkiG9w0BAQsFADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBMB4XDTE1MDYwNjAwMDAwMFoXDTE2MDYwNTIzNTk1OVowJTEjMCEGCSqGSIb3DQEJ
ARYUbWVuc2NoZWwucEBwb3N0ZW8uZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQCmXKd7KFXQ5Y1lT+HtgiumuCHTLdaZJEmv9CVr2CuRZYieupiipE7kyqjfmrml8GqqZ8aN
jT416/fN4OGolBcNQAk6qah/yesqdhMMKi4VcgY9Npyy86NQU5mXYpu2UTnQw4pSCgUR4Co4
zXHFDwZ3gHcwoVG+osRmEe9IrjYWGQaCWhjEe+wtipPy6UxuqbKhTYPUUnFYuCLxgibGFb2e
vShPK636V+EIgAug0IzmlLXxFoA4Mh/80NXzaNQA4zAP0sZ84/JKwEUE34a9rSHB1CoHH9fZ
QeuxCsa9BVG/jaZmlv/RsDLjlTxoYki5Xvskbmzbm1rTWqyMOJwJH7jxAgMBAAGjggHyMIIB
7jAfBgNVHSMEGDAWgBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAdBgNVHQ4EFgQUePDBZrYdfsBv
BjAwsKanMPGoUpEwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYI
KwYBBQUHAwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsG
DCsGAQQBsjEBAgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0
L0NQUzBdBgNVHR8EVjBUMFKgUKBOhkxodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9T
SEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGQBggrBgEF
BQcBAQSBgzCBgDBYBggrBgEFBQcwAoZMaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RP
U0hBMjU2Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAkBggrBgEF
BQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMB8GA1UdEQQYMBaBFG1lbnNjaGVsLnBA
cG9zdGVvLmRlMA0GCSqGSIb3DQEBCwUAA4IBAQA33XFpLPRq8YL327tL4WY5ln2z8hjYTdgz
uVGTtUU7fLcLVWlCwHU/ki29PjbVja73aXmgJU1d7ISnXcxXa1BRLgcFs8MjZzf8zqPzYXwb
VM5Z7J04deNlqz4CoGY2KSLIAArFbPIyX+Ry6t31xpo215D9IZNaloewSpYuj9g1qrH0LafH
YG88MeCF3Ilf8Ca7t16AtyVAd96kDuWET61QpIxfBJasv5IspDw9QXD8ajWgimQI+QTjGDMI
IV8Jj+1XbrW0EPKJpfrBuHHYAtVMrdJ7N6Ykjokam2F6oYhZNbG8YflootIHC/WV7o5OAllx
9IaJwAZaj9PBugpENM9SMYIERDCCBEACAQEwgbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAIF1mLQKXy8hYR6LxtHqDsEwDQYJYIZIAWUD
BAIBBQCgggJjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2
MDUyMjIwMjczMlowLwYJKoZIhvcNAQkEMSIEIJ0XjPflvBvjTFT8/AzZdZkbvBPPPoygDRJz
CPQQinBAMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAgXWYtApfLyFhHovG0eoOwTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAIF1mLQKXy8hYR6LxtHqDsEwDQYJKoZIhvcNAQEBBQAEggEALL6Ff9NyfwOH
QZ7NyJ6cMNITEPgU/LJFjb/l2BgPFxbrnF7be59qgGJyeOFNuzfChJDDRczuPIkkU5L6j0gB
kEXMSFI0F9dkhUehDkjvKaxis/kvawpMCumqx9LqUxWz3uTw/fm/oLYC2WDMe01NoXSIpscg
+hd82IGBRuV8Aar0Ie0IPi78IFyDSUGYsCBBFfRNK2UxFi9wdjsVlq7egbTbfQT05AYHKzqo
7Lwxb6et2Fc8OQRbaf67nwrX6rl60sdWZJEAtyebgrSi4bRjwcNGJQ4hxVb/UJ7ESZEl+Vpn
r2klpIe/y7UjeLEGYDviXpj7b8Xe9MLw9Y0RNoB8dAAAAAAAAA==
--------------ms040405040306010901000903--
