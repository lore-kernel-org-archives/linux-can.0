From: "Menschel.P" <menschel.p@posteo.de>
Subject: Re: j1939 (Higher Layer Protocols)
Date: Thu, 5 Nov 2015 20:22:02 +0100
Message-ID: <563BAC5A.8060604@posteo.de>
References: <20151105180831.GA24951@bamboo.electronicsoup>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060608070309070203070605"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:33700 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbbKETWL (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Nov 2015 14:22:11 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id E654B209AB
	for <linux-can@vger.kernel.org>; Thu,  5 Nov 2015 20:22:07 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3nsF8v0qgRz5vN3
	for <linux-can@vger.kernel.org>; Thu,  5 Nov 2015 20:22:06 +0100 (CET)
In-Reply-To: <20151105180831.GA24951@bamboo.electronicsoup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060608070309070203070605
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello John,

if it's just about the standards hierarchy, I can help.

1.SAE J1939 is on top. Truck and Construction Equipment usage, although
US Trucks are mainly J1587 (RS485) with J1708 protocol.
1.1 SAEJ1939 defines its own transport protocol to transmit a PGN longer
than 8Bytes.
1.2 Additionally ISO15765 aka "KWP2000 over CAN" defines another
transport protocol closely linked to KWP2000(ISO 14230) or the newer
UDS(ISO14229).
It is basically a wrapper for half-duplex serial communication over CAN.

2.NMEA2000 is the marine adaption of J1939, agriculture equipment often
uses NMEA2000 GPS devices.
2.1 NMEA2000 FAST Packet is another transport protocol for >8Byte
messages. I believe that's what you encountered on the boat. I don't
know the details.

3.ISOBUS(ISO 11783) is the agriculture adaption of J1939
3.1 Since the devices of the agriculture equipment can be used in
multiple combinations, ISOBUS has mechanisms to register new devices to
the CAN bus and so on. AFAIK there is no additional transport protocol.

Regards,
Patrick


Am 05.11.2015 um 19:08 schrieb John Whitmore:
> Newbie here so this could go to kernel newbies mailing list but it is C=
an
> Related so here goes.
>
> I'm coming at this from the restricted bubble of microcontrollers, but =
just so
> you know what that produced...
>
> I have a low level library of code which handles all Can frames (I keep=

> wanting to say Layer 2 but it's probably not) on my single Can
> Interface. Basically it is a dispatcher which handles all the frames. S=
o the
> main loop of my embedded microcontroller reads a frame and dispatches i=
t.
>
> "Application" code then just registers a handler something like
>
> register_handler(filter, handler_function)
>
> It's fairly basic but it works for me. I'm working on my own networks s=
o don't
> have to worry about the rest of the world. And I was only using 8 Byte
> messages. All my different nodes are basically the low level dispatcher=
 which
> is alway the same and specific handler registrations.
>
> I then started using longer messages (I keep wanting to say Layer 3 but=
 it's
> probably not) and I got lost in a world of F'n standards. I had thought=
 that
> j1939 was for lorries in the US or something. I Ended up going with ISO=
-15765
> to send longer messages. Because of the way I did my frames I ended up =
doing
> the same with this protocol:
>
> register_iso15765_handler(filter, iso15765_handler_function)
>
> I have to enable a switch at build time and if ISO-15765 is enabled a f=
rame
> handler is registered:
>
> register_handler(iso15765_frame_filter, iso15765_dispatch_function)
>
> The iso15765 dispatcher now just receives all frames which is assembles=
 into
> messages and dispatches them to interested parties.
> That all worked for what I was trying to do which was reflash units acr=
oss the
> CanBus network. As a result of that application my Messages are Flash R=
ow
> sized.
>
> As I could now send long messages with ISO-15765 I had a dedicated unit=
 on my
> Can Bus network which acted as a "logger" for the whole bus. Any node t=
hat had
> something to log just sent an ISO-15765 message.
>
> We're now getting to Linux as the RaspberryPi came along. I had a CanBu=
s
> logger using ISO-15765 but the unit was a microcontroller which just fi=
red it
> over RS232 to a minicom log running on a laptop. The RaspberryPi had a =
File
> System!!!=20
>
> Because I already had a logger which basically was a call to:
>
> register_iso15765_handler(filter, iso15765_handler_function)
>
> I used SocketCan in RAW mode to grab all frames and ported my frame
> dispatcher. So my ISO-15765 dispatcher which simply registered a frame =
handler
> is the same code on microcontroller and Linux (RPi) And my CanBus Netwo=
rk
> Logger is similar code as well. In the case of RPi it writes the loggin=
g
> messages to the File System, not to RS232.
>
>
> I was happy with Can Frames and ISO-15765 when somebody asked me to do =
some
> work on a boat. That's NMEA2000 and found that that is based on ISO-117=
83. Man
> there are too many protocols! ISO-11783 don't encode the length of the =
message
> :-( And it has a function based addressing scheme :-( AND an extended 2=
9 Bit
> Can Frame can ONLY be either ISO-15765 or ISO-11783 :-(
>
> I can't remember the CAN ID pattern but there are two bits in the exten=
ded can
> frame which dictate either ISO-15765 or ISO-11783.
>
> Given the path I've taken I've sort of implemented ISO-11783 the same
> way as I have ISO-15765. So now my microcontroller "Applications" can:
>
> register_handler(iso15765_filter, handler_function)
> register_iso15765_handler(iso15765_filter, iso15765_handler_function)
> register_iso11783_handler(iso11783_filter, iso11783_handler_function)
>
> Only standard 11 bit can ID frames can use the first registration but a=
ll my
> nodes use Standard frames for sending data around the network. 8 Bytes =
is huge
> in my microcontroller world.
>
> I'm not very well versed in Linux but what I've done seems wrong in thi=
s
> environment. I mean if I was running my Can Bus Logger and another high=
er
> layer application I'd have two SocketCan connections with 2 Can Frame
> dispatchers and 2 ISO-15765 dispatchers and 2 ISO-11783 dispatchers. Ob=
viously
> totally wrong.
>
> The advantage from my end is that I can run the same code on microcontr=
ollers
> as RPi. So even if it's wrong it sort of works for me.
>
>
> The only reason I wrote all this is because of the recent discussion on=

> J1939. I've never read that standard but my understanding is that I can=
't use
> that for NMEA2000 data on a boat as NMEA defines their own PGN codes an=
d
> messages. I'm looking at them in the canboat project on github.
>
> I should actually look at the Linux-j1939 API and work through that wit=
h a cup
> of tea. I've only really looked at http://elinux.org/J1939 and given my=

> limited and restricted background it feels wrong:
>
> ip link set can0 j1939 on
>
> Obviously my arch is wrong in Linux but a Can Bus is a transport networ=
k. Same
> as TCP/IP it can transport anything all at the same time. (magic)
>
> I should duck my head back down ;-)
>
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--------------ms060608070309070203070605
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
MTEwNTE5MjIwMlowLwYJKoZIhvcNAQkEMSIEINVppmD95X2NOJUP0atC9mt5Wz3h2JOLNLZm
OK8qyKeEMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZI
hvcNAwICASgwgcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RP
IENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAgXWYtApfLyFhHovG0eoOwTCBxAYLKoZIhvcN
AQkQAgsxgbSggbEwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYD
VQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQQIRAIF1mLQKXy8hYR6LxtHqDsEwDQYJKoZIhvcNAQEBBQAEggEAUywFE+P9hYze
CoPSD0LNHb6fVg8+L7Xy9Tew5ZN5ijZFbqHG1OEOLM41S5Ighgojp1uYud6DhsfRijH6GDuM
62vQC71oV5CqX3NNmpwC7JoLIJ35F5/OqKTOFiLY28d7BQeSpGTQ0f828ZaetIUZ3WydjkpY
t+2grtQv6q1jNc/bIiiLR9H4TFbEJ0S0g/mUEoMSIZps7YWqSr3DeWDVh6VGINCtLrg1iEg0
cHvF4+Ee8mYs4yEFbuw1yzYpYActZYiFhdAu06OztNdy9fAbzXh0kJCse3w1n/H7vwQV5Uwb
qSboNTBIuTcqZfcNj4Y+6gBnHWXFbHUftx+HajQ4QAAAAAAAAA==
--------------ms060608070309070203070605--
