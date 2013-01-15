From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: upcoming pull reqeust
Date: Tue, 15 Jan 2013 21:58:18 +0100
Message-ID: <50F5C2EA.8030304@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MDFAACDRVBGQWJFPODHE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55331 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757015Ab3AOU6Y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Jan 2013 15:58:24 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1TvDaR-0006Xs-Mg
	for linux-can@vger.kernel.org; Tue, 15 Jan 2013 21:58:23 +0100
Received: from [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b] (hardanger.wlan.blackshift.org [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b])
	(using TLSv1 with cipher ECDHE-ECDSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: frogger)
	by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id 6A2115F511
	for <linux-can@vger.kernel.org>; Tue, 15 Jan 2013 21:58:23 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MDFAACDRVBGQWJFPODHE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I'm going to send a pull request to David this week, it will include:
the LED trigger patches by Fabio and Kurt and my Kconfig cleanup. The
usb8-dev driver has some problems with unplug under heavy load, so it
will not be included.

The patches are in the for-davem branch in the linux-can-next repo at
gitorious:

https://gitorious.org/linux-can/linux-can-next/commits/for-davem

The shortlog is:

Fabio Baltieri (7):
      can: add tx/rx LED trigger support
      can: flexcan: add LED trigger support
      can: at91_can: add LED trigger support
      can: ti_hecc: add LED trigger support
      can: c_can: add LED trigger support
      can: mcp251x: add LED trigger support
      can: sja1000: add LED trigger support

Kurt Van Dijck (2):
      can: export a safe netdev_priv wrapper for candev
      can: rename LED trigger name on netdev renames

Marc Kleine-Budde (4):
      can: Kconfig: convert 'depends on CAN' into 'if CAN...endif' block
      can: Kconfig: convert 'depends on CAN_DEV' into 'if CAN_DEV...endif=
' block
      can: Kconfig: switch on all CAN protocolls by default
      can: sja1000: correct indention of Kconfig help text

 drivers/net/can/Kconfig           |   37 +++++++----
 drivers/net/can/Makefile          |    2 +
 drivers/net/can/at91_can.c        |   10 +++
 drivers/net/can/c_can/Kconfig     |    2 +-
 drivers/net/can/c_can/c_can.c     |   10 +++
 drivers/net/can/cc770/Kconfig     |    2 +-
 drivers/net/can/dev.c             |   18 ++++++
 drivers/net/can/flexcan.c         |   11 ++++
 drivers/net/can/led.c             |  129 +++++++++++++++++++++++++++++++=
++++++
 drivers/net/can/mcp251x.c         |   23 +++++--
 drivers/net/can/mscan/Kconfig     |    2 +-
 drivers/net/can/sja1000/Kconfig   |   14 ++--
 drivers/net/can/sja1000/sja1000.c |   17 ++++-
 drivers/net/can/softing/Kconfig   |    2 +-
 drivers/net/can/ti_hecc.c         |   10 +++
 drivers/net/can/usb/Kconfig       |    2 +-
 include/linux/can/dev.h           |   11 ++++
 include/linux/can/led.h           |   51 +++++++++++++++
 net/can/Kconfig                   |   13 ++--
 19 files changed, 329 insertions(+), 37 deletions(-)
 create mode 100644 drivers/net/can/led.c
 create mode 100644 include/linux/can/led.h

Comments, any missing patches or {Reviewed,Acked,Tested}-by?

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2MDFAACDRVBGQWJFPODHE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD1wu4ACgkQjTAFq1RaXHOkegCeOjaf6w7YsfsLicwSyGZioMoP
+M8An1cngEdK34QLx1G8Ys5p1xxyqSm/
=HEYv
-----END PGP SIGNATURE-----

------enig2MDFAACDRVBGQWJFPODHE--
