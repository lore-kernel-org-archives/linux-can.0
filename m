From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull request: linux-can-next 2012-07-17
Date: Tue, 17 Jul 2012 09:50:34 +0200
Message-ID: <5005194A.4090900@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD34CBA3DE871A24A88670F26"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34492 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab2GQHus (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Jul 2012 03:50:48 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: Linux Netdev List <netdev@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD34CBA3DE871A24A88670F26
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello David,

the fifth pull request for upcoming v3.6 net-next. The first two
patches (created by me) add const qualifiers to the flexcan and
mpc5xxx_can driver. The next patch by Julia Lawall fixes a return value
problem in the error path of the softing driver.

regards, Marc

--

The following changes since commit 6ba6047bf99cf4ade4f63b6b3d97cc3ad763b6=
78:

  gigaset: silence GCC warning for unused 'format_ie' (2012-07-16 23:23:5=
3 -0700)

are available in the git repository at:

  git://gitorious.org/linux-can/linux-can-next.git for-davem

for you to fetch changes up to da78b7998e365b3f90b2a1a55d3b6ba6cc0c5905:

  can: softing: softing_main: ensure a consistent return value in error c=
ase (2012-07-17 09:35:59 +0200)

----------------------------------------------------------------
Julia Lawall (1):
      can: softing: softing_main: ensure a consistent return value in err=
or case

Marc Kleine-Budde (2):
      can: flexcan: make flexcan_priv.devtype_data member point to const =
data
      can: mpc5xxx_can: make data in mpc5xxx_can_probe const

 drivers/net/can/flexcan.c              |    4 ++--
 drivers/net/can/mscan/mpc5xxx_can.c    |    2 +-
 drivers/net/can/softing/softing_main.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD34CBA3DE871A24A88670F26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAFGVAACgkQjTAFq1RaXHNXvACfUA4zsL47Y6Os2EzWNyCIPKgE
5B0AnizaiOwAYitqltbRXMpatkvM5JOQ
=HJdc
-----END PGP SIGNATURE-----

--------------enigD34CBA3DE871A24A88670F26--
