From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: Make driver more quiet
Date: Wed, 05 Mar 2014 19:02:23 +0100
Message-ID: <531766AF.4040408@pengutronix.de>
References: <1394040716-31095-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="su4rfwkHOLujXthocbuurQFWBAlCwGi6S"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52312 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbaCESCf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Mar 2014 13:02:35 -0500
In-Reply-To: <1394040716-31095-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--su4rfwkHOLujXthocbuurQFWBAlCwGi6S
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/05/2014 06:31 PM, Alexander Shiyan wrote:
> This patch moves one diagnostic message used for debugging purposes
> to dev_dbg() and removes one useless message.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied to can-next.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--su4rfwkHOLujXthocbuurQFWBAlCwGi6S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMXZq8ACgkQjTAFq1RaXHMPhgCfcx0K8vCyaQqOxIpAeF5OguLO
edcAn0elNdzCGJAAwWhlMlVVPCuP2GTE
=OwJ3
-----END PGP SIGNATURE-----

--su4rfwkHOLujXthocbuurQFWBAlCwGi6S--
