From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: [PATCH v8 1/3] can: Allwinner A10/A20 CAN Controller support -
 Devicetree bindings
Date: Sun, 5 Mar 2017 11:59:49 +0100
Message-ID: <83349902-ea3d-0a2a-59ee-52b88c9e5c76@posteo.de>
References: <1442402482-7118-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442402482-7118-2-git-send-email-info@gerhard-bertelsmann.de>
 <55FA7428.4030801@pengutronix.de> <20150917100617.GB4684@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060605080403090008000906"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:40057 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbdCEK7x (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 5 Mar 2017 05:59:53 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 835E720A47
        for <linux-can@vger.kernel.org>; Sun,  5 Mar 2017 11:59:50 +0100 (CET)
In-Reply-To: <20150917100617.GB4684@lukather>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms060605080403090008000906
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello Marc,

I'm refering to this original patch.

I just upgraded my two BananaPis to Kernel 4.9.13 and apparently the
correct Devicetree bindings are still missing in

arch/arm/boot/dts/sun7i-a20.dtsi

,so I added them manually.

I've done some basic tests and everything works as expected.

How is the policy?
May I write the DT Patch or is this the domain of the original Author?

Thanks and Best Regards,
Patrick


Am 17.09.2015 um 12:06 schrieb Maxime Ripard:
> On Thu, Sep 17, 2015 at 10:04:56AM +0200, Marc Kleine-Budde wrote:
>> On 09/16/2015 01:21 PM, Gerhard Bertelsmann wrote:
>>> Devicetree bindings for Allwinner A10/A20 CAN
>>>
>>> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
>>> ---
>>>
>>>  .../devicetree/bindings/net/can/sun4i_can.txt      |  38 +
>>>  1 files changed, 389 insertions(+)
>>>
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/can/sun4i_can.txt =
b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
>>> new file mode 100644
>>> index 0000000..cd0f50c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/can/sun4i_can.txt
>>> @@ -0,0 +1,38 @@
>>> +Allwinner A10/A20 CAN controller Device Tree Bindings
>>> +-----------------------------------------------------
>>> +
>>> +Required properties:
>>> +- compatible: "allwinner,sun4i-a10-can"
>>> +- reg: physical base address and size of the Allwinner A10/A20 CAN r=
egister map.
>>> +- interrupts: interrupt specifier for the sole interrupt.
>>> +- clock: phandle and clock specifier.
>>> +
>>> +
>>> +Example
>>> +-------
>>> +
>>> +SoC common .dtsi file:
>>> +
>>> +	can0_pins_a: can0@0 {
>>> +		allwinner,pins =3D "PH20","PH21";
>>> +		allwinner,function =3D "can";
>>> +		allwinner,drive =3D <0>;
>>> +		allwinner,pull =3D <0>;
>>> +	};
>>> +...
>>> +	can0: can@01c2bc00 {
>>> +		compatible =3D "allwinner,sun4i-a10-can";
>>> +		reg =3D <0x01c2bc00 0x400>;
>>> +		interrupts =3D <0 26 4>;
>>> +		clocks =3D <&apb1_gates 4>;
>>> +		status =3D "disabled";
>>> +	};
>>
>> What about adding this snippet to SoC where the CAN core is available?=

>> Maxime, what's the policy on sinxi?
>=20
> It would be great, but it can come as a second step.
>=20
>> If you give me an Ack I'd like to take the series via linux-can-next
>> (and to net-next) upstream.
>=20
> I just did so for this patch, I'll review the driver when I'll have a
> bit of time.
>=20
> Thanks!
> Maxime
>=20


--------------ms060605080403090008000906
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
BAIBBQCgggJjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3
MDMwNTEwNTk0OVowLwYJKoZIhvcNAQkEMSIEIKRRjJmySz4nUaSt/mWBGnWgktgHg05IuQt5
78fl/C+AMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAvREavCLRTrKKuEIsseliUTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAL0RGrwi0U6yirhCLLHpYlEwDQYJKoZIhvcNAQEBBQAEggEASIWVml4c+lTH
07NqFcd9VLZfEA8OKAWnulJXxQNkhmcfMO3G40afr1ptC/UZwu4WTqv9h2eifQHoP563DRSd
ZK1Edllpk1HvMbgaGzA2X1DXJpjUOQwPl9/DMjUm/5A+UkIvSrvfqUCsV9q1tIzIGYMOllzD
0ZWVjb2bzdnZLXO2+ZdpKLYxXo9gbKc6107Apr/CXIrNY5LGxLFo2WnOndDMk7bvfSHqfpn3
67rsLfXoROnIC8XMSzpE6NGoCV7Qixx3o8fac372gA9LoTb1xo/SEAuQPRQzWiq6dEYMcOPr
N/M0SzUiLVJ2vwwsLPS5KO8kkLLPI0lFMPK4A4GKYgAAAAAAAA==
--------------ms060605080403090008000906--
