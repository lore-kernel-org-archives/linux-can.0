From: "Rost, Martin" <Martin.Rost@tonfunk.de>
Subject: mcp251x: mcp2515 stops receiving
Date: Fri, 21 Mar 2014 12:40:30 +0000
Message-ID: <2E9F00CBB66AB544A1ACDC59627518BA0DB3F120@mailserver>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----A44A9F6734AA0A75364A20F0BF869B0B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tonfunk.biz ([145.253.128.114]:39060 "EHLO mail.tonfunk.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759943AbaCUMkl (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 21 Mar 2014 08:40:41 -0400
Received: from [129.84.3.7] (port=23049 helo=tonfunk.biz)
	by mail.tonfunk.biz with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <Martin.Rost@tonfunk.de>)
	id 1WQykY-0003t6-0d
	for linux-can@vger.kernel.org; Fri, 21 Mar 2014 13:40:38 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an S/MIME signed message

------A44A9F6734AA0A75364A20F0BF869B0B
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Hello List,

We are using the MCP2515 on a tegra3 (Toradex Colibri T30, to be precise) a=
nd every now and then the driver just stops.
The interrupt line stays low, and the driver does not collect the data.
From my investigations I conclude, that the MCP lowers the IRQ line before =
the value in the INTF register is  updated,=20
so when the driver reads the INTF register, a 0 is returned, and the driver=
 assumes nothing has to be done.
=20
(
Chances are I'm misinterpreting my observations.=20
It might as well be that the call to the IST is suspended, because the prev=
ious instance is still running and processes the new irq cause as well,=20
so the next call will not see the signal at all.=20
But in that case the driver should not stop with the irq line held low, or =
should it?
)
=20
We are using the 3.1.10 kernel from the toradex repository, which should be=
 in sync with the nvidia tegra4linux one.
I have browsed through the patches between 3.1.10 and head and have applied=
 all those that seem to address issues and don't interfere with the 3.1.10 =
kernel structures, but to no avail.
In fact, these patches have been applied:
cab32f39dcc5b35db96497dc0a026b5dea76e4e7
db388d6460ffa53b3b38429da6f70a913f89b048
ae5d589e5f9f3217656ada632869968178886ac6
b1ef05a5a20afe50d4188a5b59579bd140758cf0
I have changed the IST loop to poll the INTF register beforehand for up to =
10ms, and now the driver seems a lot more stable in our environment.
Has someone seen this issue before, or can confirm I am not completely off =
the path?
=20
On a side note, I have a second reason that makes the driver stop, which ha=
s to do with smp somehow.
Disabling core1..3 keeps that from happening, but the problem addressed abo=
ve would persist.
Switching the irq to a different core by setting /proc/irq/91/smp_affinity =
does not trigger this problem.
Any insights or starting point on this would also be greatly appreciated.
=20
Best regards
Martin=20

------A44A9F6734AA0A75364A20F0BF869B0B
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
HAYJKoZIhvcNAQkFMQ8XDTE0MDMyMTEyNDA0MFowIwYJKoZIhvcNAQkEMRYEFA21
9GlixayRZS13vNo37S+2ku6aMHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0G
CSqGSIb3DQEBAQUABIGAQmFePts/7YHuQo5pbqYtEg0qRKL994QWVPUE1fWUZr+b
BlGnNsyC4fCMf35DWLuFk/oBgB1AnSvnF6JFAmCF1FISRld6qPdgwazFLw2PTegZ
3VcWZPEX86qcvm0RyJU27TIKj5t4h6W9RJzozYS+VwSGig+nKwue8mve4mgq8Cs=

------A44A9F6734AA0A75364A20F0BF869B0B--

