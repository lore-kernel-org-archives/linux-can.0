From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Fwd: Loosing CAN messages with socket-CAN
Date: Wed, 03 Apr 2013 12:37:03 +0200
Message-ID: <515C064F.2060503@pengutronix.de>
References: <OFFDCA8F9E.6364F5F1-ONC1257B42.00342754-C1257B42.003887D3@de.abb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DMIKLNEEMSDTWLRJXNBJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47848 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab3DCKhJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Apr 2013 06:37:09 -0400
In-Reply-To: <OFFDCA8F9E.6364F5F1-ONC1257B42.00342754-C1257B42.003887D3@de.abb.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jeroen Lammertink <jeroen.lammertink@nl.abb.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DMIKLNEEMSDTWLRJXNBJ
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Jeroen,

please use the linux-can Mailinglist, but don't post HTML mails there.

Marc

-------- Original Message --------
Subject: Loosing CAN messages with socket-CAN
Date: Wed, 3 Apr 2013 12:17:31 +0200
From: Jeroen Lammertink <jeroen.lammertink@nl.abb.com>
To: bet-frogger@users.berlios.de

Marc Kleine-Budde,

I hope you can put me in the right direction for the following problem: W=
e
seem to loose CAN messages.

We are sending batches of 80 CAN messages using socket CAN to transfer an=

image for download. After the 80 messages we wait for a response
consisting of a single CAN message. Within the messages we have coded a
sequence number, so that we can detect lost messages. Besides the CAN
device that is subject of download, we have also a (hardware) CAN sniffer=

on the CAN bus. We typically log CAN messages when we put them in the
socket. With this set-up we typically detect loosing a short series of
(mostly 5) CAN messages, somewhere halfway the batch of 80. No other
devices are present on the CAN bus.

I've dumped below some version and set-up info of Ubuntu, socket-can and
ifconfig.

Is this problem known?
May this problem be related to using an old version of socket can?
How can I upgrade Ubuntu to the latest versions of socket-can?

Thanks in advance,

Jeroen Lammertink


bmterra@q7buntu:~/user/jla$ uname -a
Linux q7buntu 3.5.0-26-generic #42~precise1-Ubuntu SMP Mon Mar 11 22:19:4=
2
UTC 2013 i686 i686 i386 GNU/Linux
bmterra@q7buntu:~/user/jla$ cat /proc/net/can/version
rev 20090105 abi 8
bmterra@q7buntu:~/user/jla$ ifconfig can0
can0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:1128 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4400 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1024
          RX bytes:9024 (9.0 KB)  TX bytes:34176 (34.1 KB)
          Interrupt:18


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




------enig2DMIKLNEEMSDTWLRJXNBJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFcBlMACgkQjTAFq1RaXHPvEQCghMcstxAschEOAe2ZdlPSa1vG
s/kAn3OVdIejl4xBcmTmps4aWlr2HONd
=vLM9
-----END PGP SIGNATURE-----

------enig2DMIKLNEEMSDTWLRJXNBJ--
