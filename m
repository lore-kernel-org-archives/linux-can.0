From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull request: can-next 2012-06-07
Date: Thu, 07 Jun 2012 10:14:11 +0200
Message-ID: <4FD062D3.5010107@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig95958D088E6FA04B568030EE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48802 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab2FGIOT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Jun 2012 04:14:19 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: Linux Netdev List <netdev@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95958D088E6FA04B568030EE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello David,

here two patches for net-next, by AnilKumar Ch, they add support for
Bosch's d_can hardware to the existing c_can driver.

regards, Marc

---

The following changes since commit c1864cfb80a64933c221e33fed9611356c0319=
44:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2012-06-=
06 15:06:41 -0700)

are available in the git repository at:

  git://gitorious.org/linux-can/linux-can-next.git master

AnilKumar Ch (2):
      can: c_can: Move overlay structure to array with offset as index
      can: c_can: Add support for Bosch D_CAN controller

 drivers/net/can/c_can/Kconfig          |   13 ++-
 drivers/net/can/c_can/c_can.c          |  120 ++++++++++++-----------
 drivers/net/can/c_can/c_can.h          |  163 ++++++++++++++++++++++++--=
------
 drivers/net/can/c_can/c_can_platform.c |   76 ++++++++++-----
 4 files changed, 247 insertions(+), 125 deletions(-)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig95958D088E6FA04B568030EE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/QYtcACgkQjTAFq1RaXHObBwCgmXaHAxeQLHvm4arHK6iZTlgK
skYAniSPO/zSus9rfzUjs+AqmCNR7K2Q
=fwZw
-----END PGP SIGNATURE-----

--------------enig95958D088E6FA04B568030EE--
