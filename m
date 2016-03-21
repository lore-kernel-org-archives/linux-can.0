From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: Testing CAN on Allwinner A20 / Banana Pi
Date: Mon, 21 Mar 2016 14:05:54 +0100
Message-ID: <56EFF1B2.9050404@posteo.de>
References: <55F3E7A0.9020309@posteo.de> <55F3ECAC.7040508@pengutronix.de>
 <56ED45C9.7080803@posteo.de> <56ED4725.8080209@pengutronix.de>
 <56EFBE77.2020408@eurek.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020408010105030609060505"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:50838 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496AbcCUNGC (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 21 Mar 2016 09:06:02 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 2460420DDB
	for <linux-can@vger.kernel.org>; Mon, 21 Mar 2016 14:05:56 +0100 (CET)
In-Reply-To: <56EFBE77.2020408@eurek.it>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: gianluca <gianlucarenzi@eurek.it>
Cc: linux-can <linux-can@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms020408010105030609060505
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Thanks for the advice,

in my case the sunxi_defconfig already had the driver selected, so no
change necessary.
Apparently only the device tree information is missing in the mainline
kernel. If that were to change, it would work out of the box if a
transceiver is added.

At the moment I can send and recv from both C and Python3.

Regards,
Patrick


Am 21.03.2016 um 10:27 schrieb gianluca:
> On 03/19/2016 01:33 PM, Marc Kleine-Budde wrote:
>>>
>>> Compiling to dtb and back to dts now resolves to
>>>
>>>         can@01c2bc00 {
>>>             compatible =3D "allwinner,sun4i-a10-can";
>>>             reg =3D <0x1c2bc00 0x400>;
>>>             interrupts =3D <0x0 0x1a 0x4>;
>>>             clocks =3D <0x31 0x4>;
>>>             status =3D "okay";
>>>             pinctrl-names =3D "default";
>>>             pinctrl-0 =3D <0x32>;
>>>         };
>>>
>>> That does look plausible from my perspective.
>>>
>>> Unfortunately I'm still missing /dev/can0 and have no clue why.
>>
>> CAN devices are network devices and will not show up in "/dev". Have a=

>> look at:
>>
>>      ifconfig -a
>>
>>> If your Bpi works with legacy u-boot, I would try that next.
>=20
> It is not enough having the can-core controller in dtsi only. The kerne=
l
> has to be compiled with a network/can/socketcan enabled and the specifi=
c
> SoC can controller enabled in the same subarch structure.
> i.e.: you will need to have:
>=20
> in sunxi_defconfig:
>=20
> CONFIG_CAN=3Dy
> CONFIG_CAN_SUN4I=3Dy
>=20
> Just my $0.2...
>=20
> Hope this helps!


--------------ms020408010105030609060505
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
MDMyMTEzMDU1NFowLwYJKoZIhvcNAQkEMSIEIKROBi0tuq3bOhyzlAnrtuu56PcH0JUnpbRR
gSYr3mPZMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAgXWYtApfLyFhHovG0eoOwTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAIF1mLQKXy8hYR6LxtHqDsEwDQYJKoZIhvcNAQEBBQAEggEAZNE4/jNYkleQ
wGWnx+rRpAL/pctxVv+i/M4Sh48fBoopYcuIW+WTXopHe7+BF92HRTpedUgShMPlXaDKzBjA
E/GSmSFwN75zKD/E5t7Rjep9ohn+qJumLGiNepSGxtbolkMqqXqDxb5fSqoDzi9vNIK2uUA+
8JniqS2LsEedGA0MS4+aJaNbvwcLkhPInnXjig0mOErZVpcv5zlm+UmY/2/4/rCjTfXTAcR4
PXzDGC7ATs8UWHnqiroc3h7eLYn3GtOkhoFxv5tfH/v5EdFLfh8RRvdRw0nwv5ly5XtVnrE+
PIGQpsJtgEd3xRP35b2wFbEhpvg3qaZM9T1Y+eu9YgAAAAAAAA==
--------------ms020408010105030609060505--
