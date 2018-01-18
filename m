From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: j1939 ACL
Date: Thu, 18 Jan 2018 17:20:11 +0100
Message-ID: <b9c1932d-70b8-f5c3-836b-3fb9cd6206a0@posteo.de>
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <a27d8272-a796-2261-449e-1407158566c3@smile.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060809010503020305000507"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:55258 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933379AbeARQUQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Jan 2018 11:20:16 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout01.posteo.de (Postfix) with ESMTPS id 91A5F20F56
        for <linux-can@vger.kernel.org>; Thu, 18 Jan 2018 17:20:13 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 3zMq1S1Wkwz9s4G
        for <linux-can@vger.kernel.org>; Thu, 18 Jan 2018 17:20:12 +0100 (CET)
In-Reply-To: <a27d8272-a796-2261-449e-1407158566c3@smile.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060809010503020305000507
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE


> Here is an example of Address Claim sequence where device
> AAAAAAAAAAAAAAAA enters the network and device BBBBBBBBBBBBBBBB
> already have address 0xAA:
>
> (1516110467.317706) can0 18EAFFFE#00EE00 ------------> Device
> AAAAAAAAAAAAAAAA asks for addresses of all other devices on the network=

> (1516110467.329943) can0 18EEFFAA#BBBBBBBBBBBBBBBB --> Device
> BBBBBBBBBBBBBBBB says it has address 0xAA
> (1516110468.568107) can0 18EEFFAA#AAAAAAAAAAAAAAAA --> Device
> AAAAAAAAAAAAAAAA claims address 0xAA. That is allowed because his
> device name has an higher priority.
> (1516110468.576132) can0 18EEFFAB#BBBBBBBBBBBBBBBB --> Device
> BBBBBBBBBBBBBBBB claims another address.
>
Hi,

it should be pointed out that address claiming has some caveats.

Like with the CAN ID the NAME with more leading zeros wins thus
"BBBBBBBBBBBBBBBB" looses to "AAAAAAAAAAAAAAAA" but there is also the
"arbitrary_address_capable" flag (the last bit) and "AAAAAAAAAAAAAAAA"
does not have that flag set.

Thus "AAAAAAAAAAAAAAAA" would claim the source address 0xAA regardless
of NAME priority.
"BBBBBBBBBBBBBBBB" has the "arbitrary_address_capable" flag set und can
solve the source address conflict by moving on to another source address.=


IMHO in case you have a NAME with lower priority but without
"arbitrary_address_capable" flag, it would actually win against a higher
priority NAME that has the "arbitrary_address_capable" flag set.

Regards,
Patrick



--------------ms060809010503020305000507
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CyEwggUzMIIEG6ADAgECAhBp9PwZCVW98tnHAS3kOjLRMA0GCSqGSIb3DQEBCwUAMIGXMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xNzA2MDYwMDAw
MDBaFw0xODA2MDYyMzU5NTlaMCUxIzAhBgkqhkiG9w0BCQEWFG1lbnNjaGVsLnBAcG9zdGVv
LmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoNhDbc0RVWdVfJEhvKfjVPmY
wnjbpn/YIWexSHoH3L65Gzj0+IHWdI56CvKzWniZYI8pjoCnVQU4gEfRWJqev9wijlagbfYe
0yQQEUFigJEEzC6EoaC5JJfJcNr1qkYB9RSFeSuGnKOb4Z3NGXp0yXjLkY+jzNbRrOelKB6p
AT5KGaAa6ESkucnPPNrMScHZBHznUxT0u0aGu8goQUw/SZVN3S3KvXIrQfXt2bZiCXCtw5go
0+N/MI78KSU2uO9hlzEDq0tp30iWWs3zpt/vZjuojufw0ikUxz9tseFzhTIfRp5tYnE08h+z
Tmc9w9ld8WA12YdK61P2HNHtsGDqZQIDAQABo4IB6jCCAeYwHwYDVR0jBBgwFoAUgq9sjPjF
/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFJZcg7d5WiG3X5RR8+DRmSaH0kqCMA4GA1UdDwEB
/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMF
AjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggr
BgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2g
S4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklo
dHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFu
ZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5j
b20wHwYDVR0RBBgwFoEUbWVuc2NoZWwucEBwb3N0ZW8uZGUwDQYJKoZIhvcNAQELBQADggEB
ACV8QT6dz5yYb5lItTyb1IrP7Tlc5Ri+eaki13Wlh62z3dYdC0C3GuOrKTVwwDAKpbuUm5g2
OFDVXkAfZhw8DkCjB2bghH1xoUBXqJ5PhjsWvUgptgefvJ5z80dXPSkKTYgRQj2yDaBUl6mS
dPIYYTvX9QIL3Ad1nSqZjkwY/Ingw6o3NlUQnAN3EeVQEarZ7X+T/COAQl50bNNY+3+ATEk+
euma2T4CEiv9dJa5SkLCoLIAf3H5JcmaV9e32wxXKaS1yq8DZ57w1Jn7ZNULOOgVTMDuGdTL
L9jcJe6fVdgKz5LwPHsSUveUrhAzp9zEWa/v9sjVHRJOXJERO7oNjvgwggXmMIIDzqADAgEC
AhBqm+E4O/8ra58B1dm4p1JWMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFD
T01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9uIEF1
dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAxMDkyMzU5NTlaMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0
aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2NHbZhGra
0D00SOTq9bus3/mxgUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVUkbIr
5SU0RDX/kSsKwer3H1pT/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTq
Rvaq8aWccm+KOMjTcE6s2mj6RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDa
ElmOupyTf1Qib+cpukNJnQmwygjD8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEA
AaOCATwwggE4MB8GA1UdIwQYMBaAFLuvfgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSC
r2yM+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIB
ADARBgNVHSAECjAIMAYGBFUdIAAwTAYDVR0fBEUwQzBBoD+gPYY7aHR0cDovL2NybC5jb21v
ZG9jYS5jb20vQ09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwcQYIKwYBBQUH
AQEEZTBjMDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FB
ZGRUcnVzdENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkIBtTYLzXN30D+03Hj
6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/AhqX2/kiQNxm
gUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO+88G4zipA2psZaWeEykgzClZlPz1FjTC
kk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX8mnahjp3I2Y2mkjhk0xQfhNqbzlL
WPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17bTbY7+1RTWBviN9YJzK8HxzOb
XYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr84JHoy+fNLpfvYc/Q9EtF
OI5ISYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnXoc7mbrS22XUSeTwx
CTP9bcmUdp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7DoJC91WJ8Lce3C
VJqb1XWeKIJ84F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1cWcef20Wk
yk5S/GFyyPJwG0fR1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjGCBDUwggQxAgEB
MIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09N
T0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQafT8
GQlVvfLZxwEt5Doy0TANBglghkgBZQMEAgEFAKCCAlkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwMTE4MTYyMDExWjAvBgkqhkiG9w0BCQQxIgQgAfJY
fVbrCXHAJSmDDED6hfpu3WJxjx9a3E12pFcB+l0wbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvQYJKwYBBAGCNxAEMYGvMIGsMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQafT8GQlVvfLZ
xwEt5Doy0TCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgU2VjdXJlIEVtYWlsIENBAhBp9PwZCVW98tnHAS3kOjLRMA0GCSqGSIb3DQEBAQUA
BIIBAJ8jWTN6vhEWY3WxrnP6m+3IxmbzULtmkyLvE+XLrN0V1kNYAraDNEQyDmLwnU/MtjlK
aNJc8WJsOYDfmTP8B5ilraJoOgR0XFpyu/M2WLQUAAKaGoHbV2XacswOcFqh/kD3C1UGBaaw
vGaChNQt+uk8+8WzYfqg26BUag89z0O3iJlmsWwVYWkOIL45jfkBewrET89NOFt5hCYWCV+P
L2N2w9QZd21Hb7dYuEzZhVMnlA0wbuVzOidSZiKm5OygBVxfi73D2Ga6SVIYvr/ep/j+bbBy
+vO1LIkDx3+KU5eA5qeLa+85xlfU1ROqSuxrdwD1OI57kUezXCBnxSDaQWsAAAAAAAA=
--------------ms060809010503020305000507--
