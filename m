From: "Rost, Martin" <Martin.Rost@tonfunk.de>
Subject: Re: [PATCH] mcp251x: mcp2515 stops receiving
Date: Mon, 12 May 2014 17:27:51 +0000
Message-ID: <2E9F00CBB66AB544A1ACDC59627518BA0DC8872A@mailserver>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----FDD43C258460D4213D7822F941047708"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from keys.tonfunk.biz ([145.253.128.114]:34324 "EHLO
	mail.tonfunk.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaELR2C (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 13:28:02 -0400
Received: from [129.84.3.7] (port=33285 helo=tonfunk.biz)
	by mail.tonfunk.biz with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <Martin.Rost@tonfunk.de>)
	id 1Wju14-0002BH-0b
	for linux-can@vger.kernel.org; Mon, 12 May 2014 19:27:54 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an S/MIME signed message

------FDD43C258460D4213D7822F941047708
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

=0A=
Hello Marc,=0A=
=0A=
> Hmmmm, I think level triggered interrupt would help here. However not=0A=
> all interrupt controller support level interrupts and=0A=
> arch/arm/mach-pxa/icontrol.c sets the trigger to rising edge.=0A=
=0A=
That was my first attempt. That explains why it didn't help, too.=0A=
=0A=
> What happens if the register is still empty after 10ms? Can we do=0A=
> something better than the print, which will probably not fix the probem..=
.=0A=
=0A=
I thought about re-checking the line if the IRQ line was released, but I ha=
ve no clue how to do that...=0A=
I haven't seen a problem when returning regardless (in my setup), but I'd l=
ike to give a hint at least in case someone runs into the same problem.=0A=
=0A=
> I'll send a cleaned version of you patch.=0A=
much appreciated.=0A=
=0A=
Regards,=0A=
Martin.=

------FDD43C258460D4213D7822F941047708
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
HAYJKoZIhvcNAQkFMQ8XDTE0MDUxMjE3MjgwMFowIwYJKoZIhvcNAQkEMRYEFBf0
X+wqngUX2r9ENayMZA61DAu9MHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0G
CSqGSIb3DQEBAQUABIGAC3EzWrtpibLZH+LJwzWEAbmnUln2v1BqQlmMj2Pn1J42
iR5qbhNj8eNHabXHD7dS2+8CXMyf23YY1DsZeYRMj6E+5+eMLaQl3l4KRkFi77CP
DYW9vJkcNChODhPYjnGk5hprKQZj9xMfsUzu/8TgeI0Bybz9fLXD3DaDGa5AwbI=

------FDD43C258460D4213D7822F941047708--

