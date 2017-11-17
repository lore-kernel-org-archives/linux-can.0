From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: PCAN-USB on 3v3 CAN
Date: Fri, 17 Nov 2017 18:29:47 +0100
Message-ID: <01dc3e8c-9d59-3211-843a-fc2afe1672c3@posteo.de>
References: <20171117132954.GA7355@airbook.vandijck-laurijssen.be>
 <VI1PR0302MB3325CE41756C19E9042B791BD62F0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090304060907020206080502"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:60789 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbdKQR3u (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 17 Nov 2017 12:29:50 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id D4FE820C83
        for <linux-can@vger.kernel.org>; Fri, 17 Nov 2017 18:29:48 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 3ydlVN2Cgnz105x
        for <linux-can@vger.kernel.org>; Fri, 17 Nov 2017 18:29:48 +0100 (CET)
In-Reply-To: <VI1PR0302MB3325CE41756C19E9042B791BD62F0@VI1PR0302MB3325.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms090304060907020206080502
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi,

I can also confirm that mixing 3,3V and 5V transceivers has minimal
effect on signal quality.
The only measureable effect is the slightly reduced differential voltage.=

I have multiple SN65HVD230, MCP2551 and TJA1050 on the same CAN bus.

The only problem I know of are bias networks where CAN Hi is pulled to
VCC and obviously you should not have a 5V and a 3,3V bias on the same wi=
re.

Regards,
Patrick



Am 17.11.2017 um 15:35 schrieb Rost, Martin:
> Hi Kurt,
>=20
> We're using both 5V transceivers (like TJA1040) and 3.3V tranceivers (l=
ike SN65HVD231) on the same busses for years, and I'm not having problems=
 with them.
> According to the datasheet the bus voltage adheres to the same standard=
 ISO11898.
> The 3.3V devices are more sensitive to voltage spikes, so shorting the =
bus lines to e.g. 24V kills your 3.3V transceiver for sure, while most 5V=
 ones should survive.
>=20
> There is a different CAN standard though, thas carries 12V on the bus l=
ines. It's hard to find, and I have never seen anyone using it.
>=20
> Regards
> Martin=20

Am 17.11.2017 um 15:41 schrieb St=C3=A9phane Grosjean:
> Hi,
>=20
> The 3V3 is not the problem but this weird bitrate is not supported by t=
he PCAN-USB.
>=20
> Regards,
>=20
> Stephane
>=20
> -----Original Message-----
> From: linux-can-owner@vger.kernel.org [mailto:linux-can-owner@vger.kern=
el.org] On Behalf Of Kurt Van Dijck
> Sent: vendredi 17 novembre 2017 14:30
> To: linux-can@vger.kernel.org
> Subject: PCAN-USB on 3v3 CAN
>=20
> Hello,
>=20
> I have difficulty connecting my PCAN-USB to a CAN network where all nod=
es have a 3v3 transceiver, and the obscure bitrate of 923kBit.
>=20
> Since this is the first time I encountered a '3v3' CAN bus, I was a bit=
 supprised. Will this work with my (I think) 5v PCAN-USB?
> Is this transceiver voltage interchangeable?
>=20
> Kind regards,
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=
 the body of a message to majordomo@vger.kernel.org More majordomo info a=
t  http://vger.kernel.org/majordomo-info.html
>=20
> --
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt - HRB 9183
> Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
> --
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BDq=EF=
=BF=BD=EF=BF=BD=EF=BF=BD^n=EF=BF=BDr=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
=1A=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD=EF=BF=
=BD=1E=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=03(=EF=BF=BD=E9=9A=8E=
=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD=1A=EF=BF=BD=1Bm=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=DE=96=EF=BF=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BD=
=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BDmml=3D=3D
>=20


--------------ms090304060907020206080502
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcxMTE3MTcyOTQ3WjAvBgkqhkiG9w0BCQQxIgQgfjmm
yiiKlyGU81dSgkPr7jUb3QTJn+DaRB95QDAe63QwbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvQYJKwYBBAGCNxAEMYGvMIGsMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQafT8GQlVvfLZ
xwEt5Doy0TCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgU2VjdXJlIEVtYWlsIENBAhBp9PwZCVW98tnHAS3kOjLRMA0GCSqGSIb3DQEBAQUA
BIIBAIOKmApybaRU/j4tClmElZZsE+cum4uJZb45uWGlz5V+ndRjKlOoHpD0HUK1nxK6Kn80
YrLIUo8lOuuv9/wz6JRfoc44em1d866HZxEnBtMqTMJGLAPZeUwwjGySMPibCINxGkymunQd
0SGH0tFQARD72AAy0B1t+nFbvBf6oNT2uyRSRiiJDTon+MY6qwq6PEBuoCHtNNob1yq0NEDU
EJZzaHSu5ffNkq2KXpiUD7g/QprpNZ6QFpbfTsTZff9f2ABPY7D8cw4UJG2gyKwIsp37Seqd
65jAmCd0s1URQ+jEZUHYS+FAO6S1nVy/77bqBVuVCIDnOdF96wTCepudhFwAAAAAAAA=
--------------ms090304060907020206080502--
