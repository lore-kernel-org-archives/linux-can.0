From: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree
 bindings
Date: Wed, 29 Nov 2017 21:35:25 +0100
Message-ID: <0a7e4416-332a-5c23-bda3-8c7561410314@posteo.de>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
 <20171124183509.12810-2-kernel@martin.sperl.org>
 <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop>
 <6EBDD798-8632-4F42-A138-369BCD36DF68@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060408000007020903080108"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6EBDD798-8632-4F42-A138-369BCD36DF68-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060408000007020903080108
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE

Hello Martin,


I didn't catch the whole discussion but you may want to check

include/dt-bindings/gpio/gpio.h

> #define GPIO_OPEN_DRAIN (GPIO_SINGLE_ENDED | GPIO_ACTIVE_LOW)

This corresponds to

Documentation/devicetree/bindings/gpio/gpio.txt

> Most controllers are however specifying a generic flag bitfield
> in the last cell, so for these, use the macros defined in
> include/dt-bindings/gpio/gpio.h whenever possible:
>
> Example of a node using GPIOs:
>
> =C2=A0=C2=A0 =C2=A0node {
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0enable-gpios =3D <&qe_pio_e 18 GP=
IO_ACTIVE_HIGH>;
> =C2=A0=C2=A0 =C2=A0};
>
> GPIO_ACTIVE_HIGH is 0, so in this example gpio-specifier is "18 0" and
> encodes
> GPIO pin number, and GPIO flags as accepted by the "qe_pio_e"
> gpio-controller.
>
> Optional standard bitfield specifiers for the last cell:
>
> - Bit 0: 0 means active high, 1 means active low
> - Bit 1: 1 means single-ended wiring, see:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://en=
=2Ewikipedia.org/wiki/Single-ended_triode
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 When used with active-low, this means o=
pen drain/collector, see:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://en=
=2Ewikipedia.org/wiki/Open_collector
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 When used with active-high, this means =
open source/emitter

Regards,

Patrick



Am 29.11.2017 um 12:55 schrieb kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
> Hi Rob!
>
> Thanks for all the effort - I shall incorporate those changes into V2.
>
>> s/Microcip/Microchip/
>> s/_/-/
>>
>>> +					   0 =3D Start of Frame output
>>> +					   default: 10
>>> + - microchip,clock_div =3D <1|2>: internal clock divider - default 1=

>>> + - microchip,gpio_opendrain: gpio (int0,1) in open drain mode
>>> +			     instead of default push/pull
>>> + - microchip,int_opendrain: int pin in open drain mode
>>> +			    instead of default push/pull
>> IIRC, we have a standard property for this.
> Would you know what that could be - I did a quick search for
> standard properties, but could not find a definitive list=E2=80=A6
>
> The only thing I found in:
>   Documentation/devicetree/bindings/w1/w1-gpio.txt
> is:
>   linux,open-drain
>
> But there is also: =20
>   nvidia,open-drain
>   open_drain
>   open-drain
>   drive-open-drain (pinctrl)
>   st,irq-open-drain
>
> Only the last is specific to the interrupt line and none to the other
> GPIOs of the chip (txcan, GPIO) - and each can get set differently.
>
> So how shall I implement that?
>
> Thanks,
> 	Martin--
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--------------ms060408000007020903080108
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcxMTI5MjAzNTI1WjAvBgkqhkiG9w0BCQQxIgQgpal+
XdRWVigk9ZZRiqkp91pddT5lHYR5zdtdxjLhcRcwbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvQYJKwYBBAGCNxAEMYGvMIGsMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQafT8GQlVvfLZ
xwEt5Doy0TCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgU2VjdXJlIEVtYWlsIENBAhBp9PwZCVW98tnHAS3kOjLRMA0GCSqGSIb3DQEBAQUA
BIIBABcyoVSC0s8o1Iu+fjjY5dxvjcZ4X1yJvkSZOhwr5Fn+Bk4jEdz/44brBxj85Keob+gw
XUJNdc0OwoqTY4uzoQ98nzYmCEEH/lMRM6o4ti0a9OuuoZWVHknBB2DeP9R3UpX1qrnTGJg1
lpIuHMgTC4xho95LynRyvIQBuToSzOpA+ZboYYmORURRLfWZIZirKcyz9jBjHKdsMf52G3mg
PMicgO9pWx/KmImXXvzlcSz64Fu47JSOGH2pGnhAainKKQUlsA+vsuzhHeMAn/kZ3q/fmJYc
miXCWcSWHVTDe+qJH6COujTucstZgAsfTkBER88ETS3R39Zf4+KbJzz7SMoAAAAAAAA=
--------------ms060408000007020903080108--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
