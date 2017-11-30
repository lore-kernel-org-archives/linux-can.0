From: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree
 bindings
Date: Thu, 30 Nov 2017 17:44:19 +0100
Message-ID: <6aea8071-dc21-4ba7-2b2f-5af41b5755a5@posteo.de>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
 <20171124183509.12810-2-kernel@martin.sperl.org>
 <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop>
 <6EBDD798-8632-4F42-A138-369BCD36DF68@martin.sperl.org>
 <0a7e4416-332a-5c23-bda3-8c7561410314@posteo.de>
 <612BB6CD-5330-40B8-A854-FD065E0A3331@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000608000200060204070105"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <612BB6CD-5330-40B8-A854-FD065E0A3331-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000608000200060204070105
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE

Am 30.11.2017 um 08:24 schrieb kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
> I understand, but the question still is: how to
> present the information in a valid way.
>
> To use gpio propperly it would require that the driver
> implements a =E2=80=9Csub-driver=E2=80=9D pinctrl with all the extra
> (boilerplate) code overhead.
>
> Also this would mean mixing different types of
> logical drivers into a single source - I doubt that
> would be easy to get accepted...
>
> Here again a summary of all the GPIOs that the mcp2517fd has:
> * TXCAN: dedicated GPIO with single function,=20
>          individually conigurable as push/pull or open drain
> * INT: main interrupt line - configurable as push/pull or=20
>          individually conigurable as push/pull or open drain
> * GPIO0: general GPIO with in/out option, but 2 special =E2=80=9Ccases=E2=
=80=9D:
>          tx-irq and TX-disable
>          group configurable as push/pull or open drain
> * GPIO1: general GPIO with in/out potion, but 1 special =E2=80=9Ccases=E2=
=80=9D:
>          rx-irq
>          group configurable as push/pull or open drain
> * CLKO/SOF: clock output at (1/10th, 1/5th, 1/2, 1 of the=20
>             core frequency) or start of frame output
>             possibly group configurable as push/pull or open drain
> 	    (not explicitly specified in datasheet)
>
> How would you try to present that HW-configuration in the=20
> device tree instead?
> How would it impact the driver design?
>
Hi,
I'm afraid I don't know what is best practice but you may want to look
at the max310x driver which declares it's GPIOs and GPIO based
interrupts in the regular driver.

drivers/tty/serial/max310x.c
Documentation/devicetree/bindings/serial/maxim,max310x.txt
Look for "#ifdef CONFIG_GPIOLIB".

My first try would be a single dt node like the max310x uses in the dt
example.
Imho it is better to make things useful before making them complicated.

Regards,
Patrick


--------------ms000608000200060204070105
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcxMTMwMTY0NDE5WjAvBgkqhkiG9w0BCQQxIgQgt+zJ
M3pA6UTcy7F76tjNR8N6Ia1iANFo7VGrT7p1/fEwbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvQYJKwYBBAGCNxAEMYGvMIGsMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQafT8GQlVvfLZ
xwEt5Doy0TCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgU2VjdXJlIEVtYWlsIENBAhBp9PwZCVW98tnHAS3kOjLRMA0GCSqGSIb3DQEBAQUA
BIIBAA8/7Kajnues2rru85Mutec2ll4aizZX1vnMKeaVZ7njfAxymUVDatqQrg9we0fSOQzr
fgKEKYGrt6+8H2u2Ubj3h5JBnz/LJyqxnaj8OBnJ1vdYQT95iGeVH4OrDBHngSn/1gsvDGpL
284Z4rl1M+TVSQw9/5PspcDV0JywY/CdTnO3UnQPkSdyiyH3hFbeZ2oi4fbMtbGdrZ4+1u8F
wqKGaOgKKAYd1UUY3by6bcdOi/JWW1X5eQ3alIwEoGOtzxUFA+telj9ec7NpHW9m4NnKOjdA
Q44xZPzu/Qp41Ng5KjkWdI5WKD7FkC8FDs8k/D+RkAtob2J3MId2f59WixMAAAAAAAA=
--------------ms000608000200060204070105--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
