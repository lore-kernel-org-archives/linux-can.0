From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can-next pull request for CAN ID Ematch
Date: Wed, 04 Jul 2012 13:09:28 +0200
Message-ID: <4FF42468.5040901@pengutronix.de>
References: <4FF3C278.8040200@hartkopp.net> <4FF3DCBF.2040905@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig81793EF1A9353DA05B221DE8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38943 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab2GDLJi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Jul 2012 07:09:38 -0400
In-Reply-To: <4FF3DCBF.2040905@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Rostislav Lisovy <lisovy@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, =?windows-1252?Q?Pavel_P=ED=9Aa?= <pisa@cmp.felk.cvut.cz>, Michal Sojka <sojkam1@fel.cvut.cz>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig81793EF1A9353DA05B221DE8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/04/2012 08:03 AM, Oliver Hartkopp wrote:
> Hi all,
>=20
> the pull location is still valid :-)
>=20
> Btw. i needed to change a minor thing as the em_canid_match() function =
did
> not handle the case that the same CAN-ID can be SFF or EFF ...
>=20
> The option to support the CAN_EFF_FLAG cleared in the can_mask is broke=
n,
> unusual and can not be handled in a simple way.
>=20
> The tc tool can handle eff and sff rules - and so i did it in the
> em_canid_change() function now. No support for CAN_EFF_FLAG cleared in =
the
> can_mask - just check the CAN_EFF_FLAG in the filter.can_id to decide t=
he
> rules type.

I hope I took the correct patch. Please check the for-davem branch in my
gitorious repo[1].

I've changed some things in the commit:
- credited Rostislav Lisovy as the original author.
  (git commit --amend --author=3D"Rostislav Lisovy <lisovy@gmail.com>")
- added a "net:" in the Subject line
- Fixed coding style issue in pkt_cls.h
  all defines indent now with a tab

The patch currently has these S-o-bs:

    Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
    Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Oliver, if you want to credit your changes I can add a oneliner between
Rostislav's and your S-o-b, which may look like this:

[Oliver: fixed random stuff]

Marc

cheers, Marc

[1] https://gitorious.org/linux-can/linux-can-next/commits/for-davem

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig81793EF1A9353DA05B221DE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/0JGwACgkQjTAFq1RaXHP78wCbBOmPx/69posrvp2hMtnAIUgT
cFcAnj2nqkxqwpSvAopYLrgUWOYRjtBQ
=xp1s
-----END PGP SIGNATURE-----

--------------enig81793EF1A9353DA05B221DE8--
