From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 19:54:30 +0200
Message-ID: <7661b770-574f-6337-d9a9-ff2103ebb8a6@posteo.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090404020207010602020408"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:45036 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbcJDRyh (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 4 Oct 2016 13:54:37 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 1920620ACE
        for <linux-can@vger.kernel.org>; Tue,  4 Oct 2016 19:54:33 +0200 (CEST)
In-Reply-To: <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms090404020207010602020408
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> Recently, someone on this list was confronted with an engine ECU that
>> dropped TP that had the last packet not 8 bytes long.
>> And I believe I've encountered an issue a long time ago where this
>> happened on all PGNs.
>> So I introduced this option, having 3 possibilities:
>> * no padding
>> * padding for TP
>> * padding for all PGN.
> How to switch between padding for TP only and padding for all PGN?
>
> Marc
>

I'm working with J1939 regularly and programmed J1939 in Python3 a while
ago.

=46rom my experience, message construction is responsibility of the user
program.

There are numerous SPNs to be implemented in a message while
unimplemented bits are to be padded with ones.
It may be possible to pad all messages with 0xFF but that doesn't solve
the non implemented bits in front of the padding.

I think it's best practice to fulfill the requirements by creating a
j1939 message with 8 Bytes of 0xFF and then replace the bits for a
specific SPN.
This would be in user space when calling the J1939 message constructor.

BTW many j1939 descriptor files types such as the PCAN ".sym" files,
define SPNs as a bit offset and a length (additionally with type, factor
and offset as compu_method), so no need to invent the wheel again.

Regards,
Patrick


--------------ms090404020207010602020408
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
MTAwNDE3NTQzMFowLwYJKoZIhvcNAQkEMSIEICiHN8AJ0oGi2ts7Gd0485ZRKos44wt2jU0r
CoDRlKXPMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAvREavCLRTrKKuEIsseliUTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAL0RGrwi0U6yirhCLLHpYlEwDQYJKoZIhvcNAQEBBQAEggEA3/U3WmtByRs+
dJMEt14iDfoKevvM8eNyumA2aZl0xss9ALlzVzLaQYUudSHduzKcn2peYYIM6hxBdV+Guu0v
LQPoiMxm2G21ckz31YlBpc8SU9smymU6RSdmojGZv2cg+mz8O8zeI4AXVdnseFZwvjInrNFD
kAAlg6rRIFCZJKBu07p57fksHUdmiD1ckmC/IgsOagFlB1Vm7JfUV1jMTACENFymxAK+YEPm
fPyJ0C1STsHtFqtyGrATvRP5/pw6tGL+TMCQu/iHX3AYnJ8haoDDTZu6eJDVuaYCMgqCj+0c
cD3aFr0rDVZg6NjRvzuKmWOmdYg4p1sDRcP7CT5n+gAAAAAAAA==
--------------ms090404020207010602020408--
