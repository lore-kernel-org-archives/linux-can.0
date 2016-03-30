From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: can-isotp-modules
Date: Wed, 30 Mar 2016 15:24:10 +0200
Message-ID: <56FBD37A.2080600@posteo.de>
References: <zarafa.563c41ac.05a0.6a1e301242cec580@euve35974.vserver.de>
 <56F8FCA6.4060007@posteo.de> <56FBC475.1070703@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040905050201060005050207"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:42621 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271AbcC3NYQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 30 Mar 2016 09:24:16 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 6C4222098D
	for <linux-can@vger.kernel.org>; Wed, 30 Mar 2016 15:24:11 +0200 (CEST)
In-Reply-To: <56FBC475.1070703@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Michael Luxen <mluxen@gmx.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms040905050201060005050207
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 30.03.2016 um 14:20 schrieb Oliver Hartkopp:
>=20
>=20
> On 03/28/2016 11:43 AM, Patrick Menschel wrote:
>> Hello Michael,
>>
>> I'd like to ask if there are other preconditions about compiling isotp=

>> on the bbb.
>>
>> I recently purchased a bbb and I'm currently trying to compile modules=

>> for
>>
>> 4.1.15-ti-rt-r43
>=20
> '-rt-' looks like 'real time'
>=20
> Can you send the output of the warnings and errors?

About 25000 lines with multiple occurrences of macro and null character
errors of this kind.

include/linux/export.h:1:1: warning: null character(s) ignored

include/linux/byteorder/generic.h:96:21: note: in expansion of macro
=E2=80=98__be16_to_cpu=E2=80=99
#define be16_to_cpu __be16_to_cpu

looks almost the same as what Michael posted on 03.11.2015 23:29
> root@beaglebone:~/can-isotp-modules# make
> make -C /lib/modules/4.1.6-ti-r16/build M=3D/root/can-isotp-modules mod=
ules TOPDIR=3D/root/can-isotp-modules
> make[1]: Entering directory '/usr/src/linux-headers-4.1.6-ti-r16'
>   CC [M]  /root/can-isotp-modules/drivers/net/can/vcan.o
> In file included from include/linux/module.h:17:0,
>                  from /root/can-isotp-modules/drivers/net/can/vcan.c:44=
:
> /root/can-isotp-modules/drivers/net/can/vcan.c: In function '__check_ec=
ho':
> include/linux/moduleparam.h:377:61: warning: return from incompatible p=
ointer type
>   static inline type __always_unused *__check_##name(void) { return(p);=
 }
>                                                              ^
> include/linux/moduleparam.h:428:35: note: in expansion of macro '__para=
m_check'
>  #define param_check_bool(name, p) __param_check(name, p, bool)
>                                    ^
> include/linux/moduleparam.h:145:2: note: in expansion of macro 'param_c=
heck_bool'
>   param_check_##type(name, &(value));       \
>   ^
> include/linux/moduleparam.h:125:2: note: in expansion of macro 'module_=
param_named'
>   module_param_named(name, name, type, perm)


--------------ms040905050201060005050207
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
MDMzMDEzMjQxMFowLwYJKoZIhvcNAQkEMSIEIN43JOZyuJ3VybouOKZr3shW969MokZ6Xrw3
whD7jK4ZMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAgXWYtApfLyFhHovG0eoOwTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAIF1mLQKXy8hYR6LxtHqDsEwDQYJKoZIhvcNAQEBBQAEggEAHUxOC1Q7rWi+
zEhk+hDBGrktdtjepX3PCtiO2wUEzZTKfQTpDGpSRoGt9Ezr6ZMOa89TMbNrs7XrMtDWTw5r
lzvF900HszRf6zR54fN7BSaWTRIGj63uJXq/IQ6pUo+BmQXxmotlLrMSIUp9v3c2/H2yjdbi
cDuABtd43sxjXPRIO4JYXyoz/Kzy/Wf1W0u3MoxhRh/0aBSj6rT44dTfpL1P5M7BuXofkFjv
syYNdpMgBR75VrwUuZ1sfCbpj2zZEM4Y3M3S5dTGeyvT1pR715yBUUW4ZNep2MR4pCwn9aHs
GefDtLbj7KNGEiyp5rNwkepwPMd8T3Xg0iJ165pWHgAAAAAAAA==
--------------ms040905050201060005050207--
