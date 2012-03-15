From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull request: linux-can-next 2012-03-08
Date: Thu, 15 Mar 2012 14:32:47 +0100
Message-ID: <4F61EF7F.60406@pengutronix.de>
References: <1331200230-1118-1-git-send-email-mkl@pengutronix.de> <20120308.132050.1759923507049489031.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0687F4C571D06B4F60C9FA3B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55497 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985Ab2CONdD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Mar 2012 09:33:03 -0400
In-Reply-To: <20120308.132050.1759923507049489031.davem@davemloft.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0687F4C571D06B4F60C9FA3B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/08/2012 10:20 PM, David Miller wrote:
> [davem@dokdo net-next]$ git pull git@gitorious.org:linux-can/linux-can-=
next.git master
> Permission denied (publickey).
> fatal: The remote end hung up unexpectedly

Doh! - Now with the correct URL.

The following changes since commit cdf485be3a63d1f34293740fb726088c6840ce=
ea:

  ixgbe: dcb: use DCB config values for FCoE traffic class on open (2012-=
03-14 00:49:10 -0700)

are available in the git repository at:
  git://gitorious.org/linux-can/linux-can-next.git master

Stephane Grosjean (1):
      can: peak_usb: PCAN-USB specific part: fix little endian usage

 drivers/net/can/usb/peak_usb/pcan_usb.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0687F4C571D06B4F60C9FA3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9h74IACgkQjTAFq1RaXHPfLwCglnjvjiPtJ2WikKijfZv9ps9b
LPAAnjeafHZbzfMUkFK2Iri0K/bJ2ILa
=NYVa
-----END PGP SIGNATURE-----

--------------enig0687F4C571D06B4F60C9FA3B--
