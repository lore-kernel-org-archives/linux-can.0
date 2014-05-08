From: "Rost, Martin" <Martin.Rost@tonfunk.de>
Subject: [PATCH] mcp251x: mcp2515 stops receiving
Date: Thu, 8 May 2014 06:33:52 +0000
Message-ID: <2E9F00CBB66AB544A1ACDC59627518BA0DC7ED11@mailserver>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----9066E08081876EFC958EE8CF83C42DF0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tonfunk.biz ([145.253.128.114]:52474 "EHLO mail.tonfunk.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbaEHGeC (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 May 2014 02:34:02 -0400
Received: from [129.84.3.7] (port=6639 helo=tonfunk.biz)
	by mail.tonfunk.biz with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <Martin.Rost@tonfunk.de>)
	id 1WiHu2-0000UR-2N
	for linux-can@vger.kernel.org; Thu, 08 May 2014 08:33:58 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an S/MIME signed message

------9066E08081876EFC958EE8CF83C42DF0
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0


The mcp2515 sometimes seems to trigger an interrupt with the corresponding =
register not being set yet.
This makes the driver exit the interrupt because there is obviously nothing=
 to do, but the interrupt line is kept low.
Therefore the driver does not see any more interrupts until the chip is res=
et (via interface down/up).

This patch changes the IST to first check the IRQ registers, and wait up to=
 10 ms if an event really occurrs.
If the IRQ register is still empty after 10ms, a kernel message gets issued=
.
The IST loop is rearranged to evaluate the IRQ register at the last moment =
before exiting, to not miss a late irq event.

---
diff --git "a/mcp251x.c" "b/mcp251x.c"
index ad58ac6..668ce63 100644
--- "a/mcp251x.c"=09
+++ "b/mcp251x.c"=09
@@ -806,15 +806,29 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev=
_id)
 	struct mcp251x_priv *priv =3D dev_id;
 	struct spi_device *spi =3D priv->spi;
 	struct net_device *net =3D priv->net;
+	u8 intf, eflag;
+	u8 retrycount =3D 10;
=20
 	mutex_lock(&priv->mcp_lock);
-	while (!priv->force_quit) {
+=09
+	do {
+	mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
+		if (!intf) {
+//			printk(KERN_CRIT "MCP251x: IRQ delaying.\r\n");
+			mdelay(1);
+		}
+	} while (!intf && (retrycount--));
+=09
+	if (!intf)
+		printk(KERN_CRIT "MCP251x: IRQ without a cause.\r\n");
+=09
+	while ((!priv->force_quit) && (intf)) {
 		enum can_state new_state;
-		u8 intf, eflag;
+//		u8 intf, eflag;
 		u8 clear_intf =3D 0;
 		int can_id =3D 0, data1 =3D 0;
=20
-		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
+//		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
=20
 		/* mask out flags we don't care about */
 		intf &=3D CANINTF_RX | CANINTF_TX | CANINTF_ERR;
@@ -913,8 +927,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_i=
d)
 			}
 		}
=20
-		if (intf =3D=3D 0)
-			break;
+//		if (intf =3D=3D 0)
+//			break;
=20
 		if (intf & CANINTF_TX) {
 			net->stats.tx_packets++;
@@ -926,6 +940,7 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_i=
d)
 			netif_wake_queue(net);
 		}
=20
+		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
 	}
 	mutex_unlock(&priv->mcp_lock);
 	return IRQ_HANDLED;

---


------9066E08081876EFC958EE8CF83C42DF0
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
HAYJKoZIhvcNAQkFMQ8XDTE0MDUwODA2MzQwMFowIwYJKoZIhvcNAQkEMRYEFPVf
TnZ8/tyU0qtf1QNqPgVbHRekMHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0G
CSqGSIb3DQEBAQUABIGANt/gFKCzpzKqBGqKQC3vK0K3nvg+14+tTz0IVatN2UBo
1Ypf8WHQ6fblLT2j9zhJ7BKg0eT71z5Do8UND7gsSCWfpk+OBcF5bMzt64AFEpWM
5bTCuNJCTr6zasPRqJT6REMfmtlJDRnKRbjPqo1S/sZiey7wnTpm8Eb+H/342LQ=

------9066E08081876EFC958EE8CF83C42DF0--

