From: "Rost, Martin" <Martin.Rost@tonfunk.de>
Subject: RE: [PATCH] mcp251x: mcp2515 stops receiving
Date: Thu, 22 May 2014 06:38:18 +0000
Message-ID: <2E9F00CBB66AB544A1ACDC59627518BA0DC96DCF@mailserver>
References: <2E9F00CBB66AB544A1ACDC59627518BA0DC7ED11@mailserver>
 <5370FE36.8020901@pengutronix.de> <20140521235346.GA15375@griso.site>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----CA5814B779243F44AB5A0CCBA8BDDAB6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smartman.tonfunk.biz ([145.253.128.114]:40729 "EHLO
	mail.tonfunk.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbaEVGvE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 May 2014 02:51:04 -0400
Received: from [129.84.3.7] (port=17590 helo=tonfunk.biz)
	by mail.tonfunk.biz with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <Martin.Rost@tonfunk.de>)
	id 1WnMe1-0007ei-0T
	for linux-can@vger.kernel.org; Thu, 22 May 2014 08:38:25 +0200
In-Reply-To: <20140521235346.GA15375@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: John Whitmore <arigead@gmail.com>

This is an S/MIME signed message

------CA5814B779243F44AB5A0CCBA8BDDAB6
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0


Hello John,

> -----Original Message-----
> From: linux-can-owner@vger.kernel.org [mailto:linux-can-
> owner@vger.kernel.org] On Behalf Of John Whitmore
> Sent: Thursday, May 22, 2014 1:54 AM
> To: Marc Kleine-Budde
> Cc: Rost, Martin; linux-can@vger.kernel.org; Alexander Shiyan
> Subject: Re: [PATCH] mcp251x: mcp2515 stops receiving
>=20
> I'm not an expert in the Linux Driver code nor the implemented fix but I =
can
> confirm that the Interrupt is generated with no flags set. I'm not sure o=
f the
> 10mS timing but I'd imagine that should work.
>=20

Thanks for confirming it.
I fiddled a bit with the timing, and it seemed that 5ms would catch some bu=
t not all occurrences of this problem.
So I went for 10 to make sure.

I'm not too deep into kernel internals, so is there some best practice to t=
his?

Regards,
Martin

------CA5814B779243F44AB5A0CCBA8BDDAB6
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
HAYJKoZIhvcNAQkFMQ8XDTE0MDUyMjA2MzgzMFowIwYJKoZIhvcNAQkEMRYEFHmb
EdZvY/UNY05X0MYcgkhpniYvMHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0G
CSqGSIb3DQEBAQUABIGAFxtzzmF1+/y7AZI8WPiFP4oRloH9AkOubkWyQvjSRlDx
fRyT9Z7r2h4G/hSJf3KgAfnjfo1E34Uaq5uy9QFpr9JOAxx7vmR34MeRBzzvdpAa
LpitLx2BaAv1L2SOUbEMe0gPz2W+j8m4hFgWYMycfCMDWRaR186QeEKhdo9Q/+s=

------CA5814B779243F44AB5A0CCBA8BDDAB6--

