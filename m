From: "Rost, Martin" <Martin.Rost@tonfunk.de>
Subject: AW: [PATCH] mcp251x: mcp2515 stops receiving
Date: Mon, 12 May 2014 17:34:14 +0000
Message-ID: <2E9F00CBB66AB544A1ACDC59627518BA0DC8873C@mailserver>
References: <2E9F00CBB66AB544A1ACDC59627518BA0DC7ED11@mailserver>
 <5370FE36.8020901@pengutronix.de>,<1399914895.885192215@f95.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----B8A9FAFC2B775519F998D7D6F0A8E99E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from svn.tonfunk.biz ([145.253.128.114]:34332 "EHLO mail.tonfunk.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759156AbaELReV (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 12 May 2014 13:34:21 -0400
Received: from [129.84.3.7] (port=33333 helo=tonfunk.biz)
	by mail.tonfunk.biz with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <Martin.Rost@tonfunk.de>)
	id 1Wju7F-0002Wq-1l
	for linux-can@vger.kernel.org; Mon, 12 May 2014 19:34:18 +0200
In-Reply-To: <1399914895.885192215@f95.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an S/MIME signed message

------B8A9FAFC2B775519F998D7D6F0A8E99E
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Hello Alexander,=0A=
=0A=
> I absolutely don't like the patch. This is not a solution to the problem =
but=0A=
> ways to circumvent it.=0A=
=0A=
True that. I whish I had a better solution.=0A=
=0A=
> I would recommend to make a temporary parameter for sysfs, then when a=0A=
> problem occurs, you could take a snapshot from all registers (including a=
n=0A=
> interrupt status register) and understand what the problem is.=0A=
=0A=
I've never done that. Any hints on how to start on this?=0A=
=0A=
Regards,=0A=
Martin=

------B8A9FAFC2B775519F998D7D6F0A8E99E
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIH2wYJKoZIhvcNAQcCoIIHzDCCB8gCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCBcwwggLVMIICPqADAgECAgkAvMrc21OtG8kwDQYJKoZIhvcNAQEFBQAw
UTEXMBUGA1UEAxMOZncudG9uZnVuay5iaXoxEDAOBgNVBAsTB0dhdGV3YXkxFzAV
BgNVBAoTDlRvbmZ1bmsgR3J1cHBlMQswCQYDVQQGEwJkZTAeFw0wOTExMjQxMjA2
MTVaFw0yOTExMTkxMjA2MTVaMFExFzAVBgNVBAMTDmZ3LnRvbmZ1bmsuYml6MRAw
DgYDVQQLEwdHYXRld2F5MRcwFQYDVQQKEw5Ub25mdW5rIEdydXBwZTELMAkGA1UE
BhMCZGUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAOmcYL9cTddZ0whp7cdz
Lvlbr73uir65Z7nSTXG+RYDaUkaLhgVuJms16/EWECMa5K0qhFNVA0aE8tUqKJcj
TuhR1flVnPq6koG8ArpudfBoNQk7v4Jgadj6ReVwJhjvQZ+dGFU+oH8F8jODhklv
cvGjdfSKNlRHMirVsBIR8FtjAgMBAAGjgbQwgbEwHQYDVR0OBBYEFF0bok+BXaTx
L3YfvzwzI7JjlCXIMIGBBgNVHSMEejB4gBRdG6JPgV2k8S92H788MyOyY5QlyKFV
pFMwUTEXMBUGA1UEAxMOZncudG9uZnVuay5iaXoxEDAOBgNVBAsTB0dhdGV3YXkx
FzAVBgNVBAoTDlRvbmZ1bmsgR3J1cHBlMQswCQYDVQQGEwJkZYIJALzK3NtTrRvJ
MAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEFBQADgYEAV9GoynO+nRC9zmnf9h6T
tFuqLMX6ITJ4CBChBrlWOc+290rANXBxiwQS+QqY+zc3VxAiMDoY64fvgvnNCtsy
fL5W1ycyRq9vvBffdF/K7MjZS+zke1XRuv6vJJABpRYMcW97E4UdBj+qH8vLfZ2f
YjuAK58Zua5S6C54zvcvRUgwggLvMIICWKADAgECAgEBMA0GCSqGSIb3DQEBBQUA
MFExFzAVBgNVBAMTDmZ3LnRvbmZ1bmsuYml6MRAwDgYDVQQLEwdHYXRld2F5MRcw
FQYDVQQKEw5Ub25mdW5rIEdydXBwZTELMAkGA1UEBhMCZGUwHhcNMDkxMTI1MDgw
NzQ5WhcNMjkxMTIwMDgwNzQ5WjB1MQswCQYDVQQGEwJkZTEXMBUGA1UEChMOVG9u
ZnVuayBHcnVwcGUxEDAOBgNVBAsTB0dhdGV3YXkxFDASBgNVBAMTC01hcnRpbiBS
b3N0MSUwIwYJKoZIhvcNAQkBFhZNYXJ0aW4uUm9zdEB0b25mdW5rLmRlMIGfMA0G
CSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3Ys/1C5iWSvFiKA4QAFiZNcdgc8nyycCc
BCi/96l1YC/DIrgLeLNP4MtNK/F6BMRhOfCmlXIUmprANiAsET7cVW8qOt6KWr8b
2SeZseE+jmqI0qeUaWjvF5ykjOo8D1X+YklVYIH/h82Wdozfa2xGW3WXm5ucDExR
azpH5aNQxQIDAQABo4GyMIGvMAkGA1UdEwQCMAAwEQYJYIZIAYb4QgEBBAQDAgSw
MCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAd
BgNVHQ4EFgQUwxDoSCAXpA8PB15z3pIKjewUaxIwHwYDVR0jBBgwFoAUXRuiT4Fd
pPEvdh+/PDMjsmOUJcgwIQYDVR0RBBowGIEWTWFydGluLlJvc3RAdG9uZnVuay5k
ZTANBgkqhkiG9w0BAQUFAAOBgQDa8BMQmQnuoHPGiTuyyy1AvcHwkMfn96vVOPQy
OT0fSQmCwVer1E9/h691pa3hfFdkE9FyqfKp9TTihPMLzpA/aL7GVBftKNVt91JZ
txTrw8bATe4dh7YjP+70gkzFJ3v4xbQkiclskoeE+QS2eyR5dGvnGJRTjYjh4qd/
yRkeITGCAdcwggHTAgEBMFYwUTEXMBUGA1UEAxMOZncudG9uZnVuay5iaXoxEDAO
BgNVBAsTB0dhdGV3YXkxFzAVBgNVBAoTDlRvbmZ1bmsgR3J1cHBlMQswCQYDVQQG
EwJkZQIBATAJBgUrDgMCGgUAoIHYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTE0MDUxMjE3MzQyMFowIwYJKoZIhvcNAQkEMRYEFAPm
hIRgdMPETqMIBtX3JlieumWbMHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0G
CSqGSIb3DQEBAQUABIGACjZH1Ia+ecwhCun7qx0Bq/b/PwqSaLHG6obDY91ct445
cJ5T+AtPzE+LN98wIfT49OtvbzTGpiGWWgqVA7kn+8lLehU2NBTLExyX5fv02w2t
zRN4wbY2NgnWflPW+C1HQXbmr35nBC5K0r9LjzmQ0df3kkt7JQfjy1ZvjtVT6WA=

------B8A9FAFC2B775519F998D7D6F0A8E99E--

