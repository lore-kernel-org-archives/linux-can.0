From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Truncate DLC to 8 instead of dropping?
Date: Fri, 31 Aug 2012 13:59:04 +0200
Message-ID: <20120831115904.GB2624@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48580 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab2HaL7F (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Aug 2012 07:59:05 -0400
Received: from katana.hi.pengutronix.de ([2001:6f8:1178:2:221:70ff:fe71:1890] helo=pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <w.sang@pengutronix.de>)
	id 1T7PsO-0007xl-9m
	for linux-can@vger.kernel.org; Fri, 31 Aug 2012 13:59:04 +0200
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I just noticed today that commit c7cd606f60e7679c7f9eee7010f02a6f000209c1
("can: Fix data length code handling in rx path") says regarding
overlong packets:

=3D=3D=3D

The ISO 11898-1 Chapter 8.4.2.3 (DLC field) says that register values > 8
should be reduced to 8 without any error reporting or frame drop.

=3D=3D=3D

and this is why get_can_dlc() came into existance.

However, functions like can_dropped_invalid_skb() from dev.h or can_rcv() f=
rom
af_can.c do check for a correct length, but drop the packet in the error ca=
se.
Don't those need to be fixed?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBApwgACgkQD27XaX1/VRt3KwCgvzZbHFE7TOSKacFruDW40PWG
iFwAni9FCfdKliojVpevCdg1UONh4315
=/TzQ
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
