From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Subject: Re: [PATCH] Revert "can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb"
Date: Mon, 7 Jan 2019 09:50:59 +0100
Message-ID: <73bd9bcf-f78c-97c0-0c36-105dc0fa16c6@ginzinger.com>
References: <eaac34af-7058-e434-7d39-7cb221e5ea88@ginzinger.com>
 <976e38b6-072e-a88b-b51d-e85a37fc71ea@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----5D21EAA025EB638B63BA4C6E962E8409"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <976e38b6-072e-a88b-b51d-e85a37fc71ea@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an S/MIME signed message

------5D21EAA025EB638B63BA4C6E962E8409
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: de-AT
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF

Manfred=C2=A0Schlaegl=C2=A0|=C2=A0Leitung Entwicklung Linz=C2=A0

GINZINGER ELECTRONIC SYSTEMS GMBH

Tel.: +43 7723 5422 153
Mobil: +43 676 841 208 253
Mail: manfred.schlaegl@ginzinger.com
Web: www.ginzinger.com




On 04.01.19 16:23, Marc Kleine-Budde wrote:
> On 12/19/18 7:39 PM, Manfred Schlaegl wrote:
>> This reverts commit 7da11ba5c5066dadc2e96835a6233d56d7b7764a.
>>
>> After introduction of this change we encountered following new error
>> message on various i.MX plattforms (flexcan)
>> flexcan 53fc8000.can can0: __can_get_echo_skb: BUG! Trying to echo non
>> existing skb: can_priv::echo_skb[0]
>=20
> Doh! I should have tested more extensive. Sorry.
>=20
>> The introduction of the message was a mistake because
>> priv->echo_skb[idx] =3D NULL is a perfectly valid in following case:
>> If CAN_RAW_LOOPBACK is disabled (setsockopt) in applications, the
>> pkt_type of the tx skb's given to can_put_echo_skb is set to
>> PACKET_LOOPBACK. In this case can_put_echo_skb will not set
>> priv->echo_skb[idx]. It is therefore kept NULL.
>>
>> (As additional argument for revert: The order of check and usage of idx
>> was changed. idx is used to access an array element before checking it's
>> boundaries)
>>
>> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
>=20
> Applied to linux-can.

Great, thanks!

>=20
> Tnx,
> Marc
>=20




________________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089


Diese Nachricht ist vertraulich und darf nicht an andere Personen weitergeg=
eben oder von diesen verwendet werden. Verst=C3=A4ndigen Sie uns, wenn Sie =
irrt=C3=BCmlich eine Mitteilung empfangen haben.

This message is confidential. It may not be disclosed to, or used by, anyon=
e other than the addressee. If you receive this message by mistake, please =
advise the sender.

------5D21EAA025EB638B63BA4C6E962E8409
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIOGgYJKoZIhvcNAQcCoIIOCzCCDgcCAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggsfMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkq
hkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3Jp
dHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYh
UPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6
fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1
KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI
03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqc
k39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMB
AAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNV
HQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/
oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0
cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
AAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+jsQgwR
GiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDc
ZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwp
WZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNm
NppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade
2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztve
BdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDA
fd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/
cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe
2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxh
csjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggUxMIIEGaAD
AgECAhAVuN6n5eZlkokswwu9CiaWMA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAe
Fw0xODA3MTgwMDAwMDBaFw0yMTA3MTcyMzU5NTlaMC8xLTArBgkqhkiG9w0BCQEW
Hm1hbmZyZWQuc2NobGFlZ2xAZ2luemluZ2VyLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBANuvwEqX7INJV7N6ebdlXbK6yo1vBpZ5RnCazmItsGzy
DRZdfP8GI8m4+A1iHmwF/s+EzYskMYFKqMWvYd4CwRvhuYxFyybYXAl8HeKLjPSj
PovMab+PYJQxqQJp/cOrcvzoL/tZZ4Z6EnvxiwkrL7gEyiqjEveuJiwiVF3E0xBU
AWIqFoKNuxdMGFJb7Al1K2ub4OEx+LtK/JtC8nHctYRli8usu5HQKQRT2ghNDkVr
octDSlZPnWVzCRF+Vi2PIiHwMmKta/7FtSnOuPSHHn0xyHjLtkX5zhKFR1t2JzOf
YsHOYJXwgkDBZdJkwcwp4/HepI82+5/N76Y7h4lMb/ECAwEAAaOCAd4wggHaMB8G
A1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBRo6er5dpiB
GN/6nuU4bNJGB0mLXjAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNV
HSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIx
AQIBAwUwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09N
T0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
iwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wKQYD
VR0RBCIwIIEebWFuZnJlZC5zY2hsYWVnbEBnaW56aW5nZXIuY29tMA0GCSqGSIb3
DQEBCwUAA4IBAQBF+zubtkZ8iMPKmi2USbYoYZo4RIK4kVmMcQpYlifGCBR1qpHb
kq420yCFp/4UKg+QiXq7WZWOTEMV9IaLLVZv13LrC5oqF7dQPXDF66W8rpxy19wG
Cmdmfj1hhAf/NkrH0Xii7VG99gVP27zIYVZaBWWb2R/UfjB56XziJXuu9nkSpeI8
5+MdoFN9UwAs3MZG2nyxk6yIdKJunD5xTXN/gFjchfK6QKcX9GYgSFbxBKfzvzBa
z51GgSWGi+rDTOy55dI961NAQdogqFVrertXxNAhGkFMHzpk1XRGyRr4wL52C8FS
ffy4+OP7WB9wI8LQwXHsj3wiYh+EjCfsXAogMYICvzCCArsCAQEwgawwgZcxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcT
B1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRD
T01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBAhAVuN6n5eZlkokswwu9CiaWMA0GCWCGSAFlAwQCAQUAoIHkMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDEwNzA4NTEwM1ow
LwYJKoZIhvcNAQkEMSIEIBM8kDmkbNBfjochVx8VLRdQtdfiiPOnQu/TvwzqJq1P
MHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAAha
s/fc+awulc5RMiI91wCpa7VZr2F+/sy4MWTKKDUVXtImaAHPXq1QK8FdwWvVy1aN
SFMv0p4LrwyXchFGzgpfnu7dEyxvmoE84qA7jvppvm9JYlpk3aodz3zgWB/pxgPA
TidSpLPd7uuIHAibJlpjt7ubusYasoZ2nwML2JIjqacGdMDYld7YjrpQQqo/O7iH
jYWIBnZXr6+ut+3XF3X8iLCnkOYXmmSvBku6pBzTaAFvcsz5Hg3I7B9JDw5FqhC7
bYaAi0otYwkL2wGjDYQDuSVqMLz6V4BkqS9ef3j/3O14JVB2eanEW9uSxIS4lYXH
q/ITuDJap+Ol3mQU/pI=

------5D21EAA025EB638B63BA4C6E962E8409--
