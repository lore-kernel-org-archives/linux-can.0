From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: [PATCH 4/5][RFC] can: kline: Add KLine rtnl configuration options
Date: Sun, 12 Jun 2016 17:36:00 +0200
Message-ID: <575D8160.4060702@posteo.de>
References: <1465500064-5402-1-git-send-email-marex@denx.de>
 <1465500064-5402-4-git-send-email-marex@denx.de> <5759CFCD.1050305@posteo.de>
 <575C6928.80302@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000800090406030501020905"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:60173 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932525AbcFLPgF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 12 Jun 2016 11:36:05 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id DD97320918
	for <linux-can@vger.kernel.org>; Sun, 12 Jun 2016 17:36:01 +0200 (CEST)
In-Reply-To: <575C6928.80302@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, linux-can <linux-can@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms000800090406030501020905
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Am 11.06.2016 um 21:40 schrieb Marek Vasut:
> On 06/09/2016 10:21 PM, Menschel.P wrote:
>> Hello Marek,
>=20
> Hi,
>=20
>> these look like the timing parameters for KWP2000 protocol.
>>> +struct kline_timing {
>>> +    __u32 w0;
>>> +    __u32 w1;
>>> +    __u32 w2;
>>> +    __u32 w3;
>>> +    __u32 w4;
>>> +    __u32 w5;
>>> +    __u32 p1;
>>> +    __u32 p2_94;
>>> +    __u32 p2_08;
>>> +    __u32 p3;
>>> +    __u32 p4;
>>> +};
>> The wX parameters are the wake up timings and the pX are the response
>> timings in between tester and ecu.
>> Imho the protocol needs to be separated from the device driver since
>> there are other protocols like kwp500 and kwp1281 that use k-line.
>=20
> Do you have some idea how to design the framework ?
>=20

Hi,

As I wrote before, I favor the serial port since K-Line is pure serial
communication.
Let the serial driver do the wakeup pattern in kernel space by using
pinctl to pull up/ down the line for the necessary time.
If no pinctl available use regular RTS/CTS pins with external
transistors. There is already an extension for RS485 support, e.g. RX/TX
switching of the transceiver PHY.

The protocol handler would hand the wakeup parameters to the serial
driver when Open() is called.

Regards,
Patrick


--------------ms000800090406030501020905
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
MDYxMjE1MzYwMFowLwYJKoZIhvcNAQkEMSIEIM39nQKRaP6DCbc50dcU7P5qUaeiZhBbUIH7
O88fEC1iMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAvREavCLRTrKKuEIsseliUTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAL0RGrwi0U6yirhCLLHpYlEwDQYJKoZIhvcNAQEBBQAEggEABkbbPNzWS1dH
FyZ69ntK3lznayGdlpi7O1l+RV6iGWuOIghf6PailRudxkIihhH3bEn2dpmw6RsnI3R9GyA7
mcOEHX40pb8E+O+ULjXQC5dCDWdezvmng377+yfH2cJRpL/ad1+EK563T6IE8bjrebTb6I/3
OvfDWFwK5R87OB0uCIDHk+pj3Ecxe8s7TZ4LMD5dYYCtmtXeS2WJEIQ+9llBK8m7rSlxePHv
uCsPSPZSrQ2sScKRhvErK1jHKaMFgGTjKJvR8qffo9VROG2km5Ncdgy4aCvUj3ezEB4iVdna
owq9Cx4VfF/p4AJDy040xBdPC061v8YgrnGPQQ39TgAAAAAAAA==
--------------ms000800090406030501020905--
