From: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree
 bindings
Date: Fri, 22 Dec 2017 16:50:25 +0100
Message-ID: <94bcc173-1655-f76e-4016-8ff55f59d8b1@posteo.de>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
 <20171124183509.12810-2-kernel@martin.sperl.org>
 <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop>
 <6EBDD798-8632-4F42-A138-369BCD36DF68@martin.sperl.org>
 <0a7e4416-332a-5c23-bda3-8c7561410314@posteo.de>
 <612BB6CD-5330-40B8-A854-FD065E0A3331@martin.sperl.org>
 <6aea8071-dc21-4ba7-2b2f-5af41b5755a5@posteo.de>
 <F6036A58-9E98-4A62-950E-3396C9EE636E@martin.sperl.org>
 <1ac487f7-17e3-c8a0-0f99-8138fe867373@posteo.de>
 <f83be38e-1a44-79cc-4cdb-f26d8c8a5c61@martin.sperl.org>
 <d79ee9eb-8b36-0086-8d76-ec6bca224fe5@posteo.de>
 <4E2DB518-A148-46CE-8267-73D292991BD2@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060105010604030507030209"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E2DB518-A148-46CE-8267-73D292991BD2-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060105010604030507030209
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Martin,

as I wrote earlier, I would save the GPIO_LIB part for a driver update
later on as to me there seems to be no daily use case.

I think SLEEP is the preferred solution.
If the device is in SLEEP after probing, the logical step would be to
disable GPIO functions and configure INT0/GPIO0/XSTBY to XSTBY thus the
transceiver is also sleeping.

Best practice usually comes from practical usage.
If there already is a reference design PCB with the mcp2517fd, it would
make sense to see what the designer did connect to the optional GPIO
pins and then guess what additional use cases could be of interest.
Without that knowledge, you're prone to do over-engineering.

Regards,
Patrick



Am 17.12.2017 um 15:34 schrieb kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
> Hi Patrick!
>=20
> So I started implementing the GPIO_LIB implementation but
> I have hit an issue where I would like to get some feedback.
>=20
> So in principle the gpiolib works, but only if the device is
> not asleep and the clock is enabled, which at this very moment means
> that the can interface has to be up and running.
>=20
> So at this very moment the only option that I see would be to
> disable the sleep mode which the device enters after probing until
> the can-network interface is enabled (which enables the clock and
> start the oscillator) - with SLEEP enabled when GPIOLIB support
> is disabled.
>=20
> This is obviously not optimal from the power perspective=E2=80=A6
>=20
> The other option would be starting the clock and oscillator
> as soon as a set_direction* (or reques/free) function is called.
> (where I would need to start using locks to avoid race conditions
> as well as clock usage counters...).
>=20
> Which of the above is the preferred solution? Are there other ideas
> how I could solve this dilemma?
>=20
>=20
> Martin
>=20


--------------ms060105010604030507030209
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcxMjIyMTU1MDI1WjAvBgkqhkiG9w0BCQQxIgQgDRFC
GjkK98Ura5EnKZTm9dQeERPNprebYsjAd5dO3s4wbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvQYJKwYBBAGCNxAEMYGvMIGsMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQafT8GQlVvfLZ
xwEt5Doy0TCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgU2VjdXJlIEVtYWlsIENBAhBp9PwZCVW98tnHAS3kOjLRMA0GCSqGSIb3DQEBAQUA
BIIBAC22F1p4ba5zBvawIhKon+Al9KsPvzVXNg5H4LPoa5L96Ips/nuwrCPCq9VvBxh3ZGEi
vMoRHdBcUQ80TTnmbZ6hFjDxLpstrpNEly0G6sWcMOfQug9luxNCzGqJYEUfqeJMzJzaIimx
LArS5Dj0kxjR7uKr5TlaL3FrfgoTbKx8lQbEmvz1LqdrxJI/6lqQpXvd4Af3n/uRsvj09Y4v
Stt7ljwpS5qEMilHwdndj8tGL4eKUaqhV6IcK6ZFXL0lKvsvGRwGjVjMg6MvOEwm/BnwFTr2
HKirc46rdu8+IOPrdJ7GERhBBqeCjmOn/4gjM6Z7TLhyjO9ukevrR3S2g7wAAAAAAAA=
--------------ms060105010604030507030209--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
