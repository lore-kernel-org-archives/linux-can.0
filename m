From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: can-j1939 API
Date: Mon, 19 Oct 2015 05:41:50 +0200
Message-ID: <5624667E.3080809@posteo.de>
References: <linux-can/can-utils/pull/7@github.com>
 <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de>
 <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
 <CAFUozzFQTOASSR94vKQnMGajUSvHGgL7BMuJSvuXKd3=n6aiog@mail.gmail.com>
 <562151D4.3060902@posteo.de>
 <20151018024250.GB29078@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050309020203080004090109"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:55625 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbbJSDlx (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 18 Oct 2015 23:41:53 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 4629120937
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2015 05:41:51 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3nfP5p72lNz5vMs
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2015 05:41:50 +0200 (CEST)
In-Reply-To: <20151018024250.GB29078@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms050309020203080004090109
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 18.10.2015 um 04:42 schrieb Kurt Van Dijck:
>=20
> --- Original message ---
>> Date:	Fri, 16 Oct 2015 21:36:52 +0200
>> From: Patrick Menschel <menschel.p@posteo.de>
>> To: linux-can <linux-can@vger.kernel.org>
>> Subject: Re: can-j1939 API
>> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
>>  Thunderbird/38.3.0
>>
>> Hi,
>>
>> 1. concerning J1939, I think it would be best to implement it is a
>> "view" on can0 without changing can0 itself.
>=20
> What exactly do you mean with 'view'?
>=20
Basically leave the can0 functionality as it is and add another
interface such as J1939_0 or whatever. That way other applications may
still use normal can0. But maybe I just misunderstood your concept,
sorry if that's the case.

>> As it's already been mentioned, j1939 may share the physical layer wit=
h
>> other protocols, i.e. CanOpen on diesel powered railway equipment or
>> proprietary protocols of some OEMs for construction machinery.
>> If there is tester or application equipment installed, CCP is usually
>> also present.
>=20
> Thanks for the example.
> IMHO, CanOpen uses only 11bit CANids, so theres no collision in the CAN=

> id space. Does anyone ever encountered CAN protrocols that have
> collisions in the CANid space with can-j1939?
>=20
>>
>> 2. concerning address claiming and address collision handling via the
>> NAME property, I think it should be handled in user space, not within
>> the module as you may have multiple source addresses on the same devic=
e.
>> For example Engine ECU SA 0x00 and Emission Controller SA 0x3D usually=

>> are one and the same physical device.
>=20
> I think I partly share your conclusion,
> I do not understand how multiple addresses on an ECU are an argument
> for handling address claiming in userspace.
>=20
If the device running socketcan+j1939 can only have one SA, it would not
allow such multi-role implementations.
>>
>> Regards,
>> Patrick
>=20
> Kind regards,
> Kurt
>>
>>
>> Am 16.10.2015 um 00:04 schrieb Alex Layton:
>>> On Tue, Sep 29, 2015 at 3:49 PM, Kurt Van Dijck
>>> <dev.kurt@vandijck-laurijssen.be> wrote:
>>>> I would like to challenge other j1939 (not necessarily socketcan+can=
-j1939)
>>>> users to share their opinions.
>>>
>>> Hello, I am the author of https://github.com/ISOBlue/isoblue-software=
,
>>> finally getting around to participating in this list.
>>>
>>>>>> If you look at http://elinux.org/J1939
>>>>
>>>>>> $ modprobe can-j1939
>>>>
>>>> This is a systemwide action, as opposed to
>>>>
>>>>>> $ ip link set can0 j1939 on
>>>>
>>>> which is an interface-wide action.
>>>>
>>>> Due to the nature of CAN, the kernel should not/cannot decide if CAN=

>>>> traffic is J1939 or not.
>>>> Unlike other CAN protocols (RAW, BCM, ISOTP), J1939 allocates the wh=
ole
>>>> CAN id range for its use, and using CAN ids incompatible with j1939
>>>> is regarded illegal.
>>>>
>>>> So this must become a switch.
>>>
>>> I disagree with this, like Austin Schuh did. In my experience there i=
s
>>> almost always other non-J1939 CAN traffic present and it must be
>>> possible to use both. The module should just ignore any CAN that does=

>>> not look right to it, and there needs to still be a way to get at the=

>>> other CAN on the bus through a CAN_RAW socket or something.
>>>
>>>>>> and if you think about this kind of assignment, it should be imple=
mented
>>>>>> inside the j1939 stuff and not in af_can.c. The can-gw routing net=
link
>>>>
>>>> j1939 touches af_can because address configuration via netlink is
>>>> absent in af_can. j1939 adds (with seperate patches) the ability to =
add
>>>> addressess for CAN sockets, but only for those CAN protocols that
>>>> support it.
>>>> I see no decent way to bypass af_can, except for creating af_j1939.
>>>
>>> Sorry if this is a stupid question, but what is the point of adding
>>> addresses to a CAN interface with ip? Doesn't the code creating the
>>> socket set what its address and/or NAME is? My implementation does no=
t
>>> modify af_can, though it is admittedly much more simplistic than
>>> Kurt's.
>>>
>>>>>> I remember our discussion about the address claiming but I wonder =
if we
>>>>>> really follow the requirement to only put functionality into the k=
ernel
>>>>>> that really has to be implemented there.
>>>>
>>>> The kernel tracks and validates J1939 traffic. Any userspace applica=
tion
>>>> can track, but none can validate & reject without duplicating effort=
=2E
>>>
>>> I too think at least part of the address handling needs to be in the
>>> kernel module.
>>>
>>>>>> Did you take a look at https://github.com/ISOBlue/isoblue-software=
 -
>>>>>> which is far simpler - whether it can fulfill the basic functional=
ities
>>>>>> (segmentation, etc.) to enable j1939 for Linux?
>>>>
>>>> I took a quick look. It appears that they only put the address claim=
ing
>>>> in the kernel. I understand that this is exactly your concern in my
>>>> implementation :-).
>>>
>>> Yes, my implementation does address claiming in the module. From what=

>>> I understand, mine does even more of the process than Kurt's does (my=

>>> module actually sends the address claim messages). However, my module=

>>> does not deal with NAMEs, only the addresses.
>>>
>>>
>>> Alex
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--------------ms050309020203080004090109
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
BAIBBQCgggJjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE1
MTAxOTAzNDE1MFowLwYJKoZIhvcNAQkEMSIEIN7jY4un0BEStTPMwtG8BKH29C5BM9EPxVeK
Wh8kq+pkMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAgXWYtApfLyFhHovG0eoOwTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAIF1mLQKXy8hYR6LxtHqDsEwDQYJKoZIhvcNAQEBBQAEggEAN57Be0qbZ82t
Bk8Zr+49U0XcKkYIsjJ2+EXuB9nQS0VOgx8AELaEb20JYgtL8+1SbM9TxXokSqzjijmMx0WB
r1RKwEcb8FFteIq0bReRgI/YXTDw8TDajhiVo6ARZZLfu0fSpDfH9Z+XKMAyA/xV3mB1nLWm
m8mo3QXsdQmpVrvXg6jaimqtW+2f0CuLUOH5JbKeMQBD5QOv8aRKSjIjO/0/agAYFz4PN/cT
GRQ5C7+sYsP8JJFCqcSzEQE5ZR8NvRRLOlPGHgxZbbv9MINMosXovm5dS7MLMTdubHdJ6iCQ
kJNRB8FF/HU9LtMrtaiLWn0wNcbSoIJ6xQEsi3SiJAAAAAAAAA==
--------------ms050309020203080004090109--
