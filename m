From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [libsocketcan] Add can_get_link_stats() - v2
Date: Wed, 07 Mar 2012 10:44:53 +0100
Message-ID: <4F572E15.2050304@pengutronix.de>
References: <6686CF564BC462488080D46D3C933CA4089AA6@EXCH02-AKLNZ.MARINE.NET.INT>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig469C1436051C6CE8DF96420F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57881 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab2CGJpK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 04:45:10 -0500
In-Reply-To: <6686CF564BC462488080D46D3C933CA4089AA6@EXCH02-AKLNZ.MARINE.NET.INT>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Reuben Dowle <Reuben.Dowle@navico.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig469C1436051C6CE8DF96420F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/06/2012 08:04 PM, Reuben Dowle wrote:
> Add can_get_link_stats()
>=20
> This function gets link_stats64 information for the can interface.
> This structure can be for any interface (not just can), but it
> seems logical to keep functions for getting any statistics relevant
> to CAN in this library.
>=20
> Signed-off-by: Reuben Dowle <reuben.dowle@navico.com>

I was at iCC2012 CAN conference, now I've some more time to look at the
code. What about naming the function after the struct? Seems more
consistent to me.

> +int can_get_link_stats(const char *name, struct rtnl_link_stats64 *ls)=


I mean "can_get_link_stats64" instead of "can_get_link_stats"?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig469C1436051C6CE8DF96420F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9XLhcACgkQjTAFq1RaXHPDlACfXb1Iynhp67d8fjtjhBxI7+ES
c8kAnj3QWHCgwJVSo5Wk24+NlwgSyqZ2
=G5LX
-----END PGP SIGNATURE-----

--------------enig469C1436051C6CE8DF96420F--
