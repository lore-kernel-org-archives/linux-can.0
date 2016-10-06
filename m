From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: Measuring latency of CAN messages in SocketCAN
Date: Thu, 6 Oct 2016 21:48:57 +0200
Message-ID: <d01e175a-7c62-3e55-ed34-bb65a96458e9@posteo.de>
References: <web-11102383@rz.tu-bs.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050800020700090709000201"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:59711 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbcJFTtC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 6 Oct 2016 15:49:02 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 469C820914
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2016 21:48:56 +0200 (CEST)
In-Reply-To: <web-11102383@rz.tu-bs.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bremer Henning <h.bremer@tu-braunschweig.de>, linux-can@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050800020700090709000201
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable


> I am using SocketCAN on a Beaglebone Black with Debian (Wheezy). I
> have my Beaglebone plugged in a CAN-Network of 5 microcontrollers. Now
> I would like to measure the time one message needs to be delivered
> from my beaglebone to another microcontroller via CAN depending on the
> priority (ID) of the sent message.
> Is there a way to do this in SocketCAN?
>
IMHO latency is best to be measured with an oscilloscope or a logic
analyzer. Switching a GPIO PIN is a good trigger to start a measurement.
Just wait for the message to be sent and measure the time in between.

As CAN is CSMA, latency has to be measured without other nodes on the
network.

The other option on the BBB is to sent a message from can0 to can1 and
clock the time in between tx and rx. Assuming rx takes as much time as
tx, you can split that time in half to get the latency.

Regards,
Patrick


--------------ms050800020700090709000201
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
tukWeh95FPZKEBom+nyK+5swggVAMIIEKKADAgECAhEAvREavCLRTrKKuEIsseliUTANBgkq
hkiG9w0BAQsFADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBMB4XDTE2MDYwNDAwMDAwMFoXDTE3MDYwNDIzNTk1OVowJTEjMCEGCSqGSIb3DQEJ
ARYUbWVuc2NoZWwucEBwb3N0ZW8uZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDhF/cULHYMLK+xHh/HbwO1aY3M+56GI9uRfRLAJWEEpdSFWvW8whRizlAZ0t9eHDzzCI1l
wi7xDKBfwJt3VNxVjqHs3JjpcxSln/22AF3t8BKy3ACUtw6COlAk7bbwxr29qf7R4wFjumdS
AS4uc6vDEBqlLrpdQCICwgOne97Dvi849VmbCBTCLTDpMxgrOXkiveGmQ2wBqLEPU/9o5ZH8
jcCbenY5GZTh7u4gvigPfgIu79jE3dS6he+c64SWgcD7bI/zA9KMCkRuvLrFnN+bu8TeH9jy
FpdsFuJ4+7mjoYsalR7S/wm0M7pbcZEDw2fJp4XogbLFmpjIlJjA8QM1AgMBAAGjggHyMIIB
7jAfBgNVHSMEGDAWgBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAdBgNVHQ4EFgQUsac6ykMiqHZ3
OqhHkkcxeF9NoW8wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYI
KwYBBQUHAwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsG
DCsGAQQBsjEBAgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0
L0NQUzBdBgNVHR8EVjBUMFKgUKBOhkxodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9T
SEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGQBggrBgEF
BQcBAQSBgzCBgDBYBggrBgEFBQcwAoZMaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RP
U0hBMjU2Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAkBggrBgEF
BQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMB8GA1UdEQQYMBaBFG1lbnNjaGVsLnBA
cG9zdGVvLmRlMA0GCSqGSIb3DQEBCwUAA4IBAQBSqnMFVFL1I7Hr3/FWhV3r0cHCSYrAAJu0
lpgUJcvf6TOGuWNTksdyxbRFWyB6uc6trI9VrQHXbUhHHaUOPyDYBT50Xv4BrgIFYpQe7JI1
IYPyE5PAR4323CeOTADK4S7KyerSRm7ZnqRCOHp6NTC/2cehFgkfCuO01AeRmzyA8arANiZf
TS2rPtd31PjpBQ0OpngLxn2qWEIf90Ibq+XxSuiXaLg4l2PI/975QLi0nn466Ql7U2nUeawn
R34LMZk1c2ImpKZUX+cpz17btGWyohXSdXLQnrruWvO2dx4F5AjuJ/F8JHbIm17I/mlzh883
4e16eovJEoiXCNVlmxZ3MYIERDCCBEACAQEwgbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAL0RGrwi0U6yirhCLLHpYlEwDQYJYIZIAWUD
BAIBBQCgggJjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2
MTAwNjE5NDg1N1owLwYJKoZIhvcNAQkEMSIEIMhuL1oEGAOH7+A/jWgES8WzP6/oi9eMx+pM
u8HwwkrmMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAvREavCLRTrKKuEIsseliUTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAL0RGrwi0U6yirhCLLHpYlEwDQYJKoZIhvcNAQEBBQAEggEALaAnCrB4ORtA
5jdcxNDxww/Vcm8MMGVZ9VbxTUBFcifUQkhVTNFofAMvVsta0m9YpGwZVdxN7rLEtHM+6Saq
C6U+OfuojuLahIlnLHarVKgZ6kyQpmAZJ/w5mN6z+4tzdZdZOb3eB+3IFF9MZzhOEXXC4zRF
j1Fq1A5WkJBuuEGWho0yw8KG0w8Z7sNw1bmguJTQ+tSbFRntj9pRNZPripBc0wMBsfwLpHCh
yNPkgo+zag281BIi6NrYo8r6NDB93QtgNNw1RbIlCYfYYGiatwYPKS7bBt/V4zmJ/Zpj31cM
UBCai7xUHufUUrnjtDfnn2wiWXOl906dm4oZjkeYpQAAAAAAAA==
--------------ms050800020700090709000201--
