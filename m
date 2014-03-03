From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: remove CAN FD compatibility for CAN 2.0 sockets
Date: Mon, 03 Mar 2014 14:55:49 +0100
Message-ID: <531489E5.203@pengutronix.de>
References: <5311EF59.6060200@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Lie6iTIAEiMBlcwb1miswkghwCPMDhhll"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43493 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbaCCNzz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Mar 2014 08:55:55 -0500
In-Reply-To: <5311EF59.6060200@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lie6iTIAEiMBlcwb1miswkghwCPMDhhll
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/01/2014 03:31 PM, Oliver Hartkopp wrote:
> In commit e2d265d3b587 (canfd: add support for CAN FD in CAN_RAW socket=
s)
> CAN FD frames with a payload length up to 8 byte are passed to legacy
> sockets where the CAN FD support was not enabled by the application.
>=20
> After some discussions with developers at a fair this well meant featur=
e
> leads to confusion as no clean switch for CAN / CAN FD is provided to t=
he
> application programmer. Additionally a compatibility like this for lega=
cy
> CAN_RAW sockets requires some compatibility handling for the sending, e=
=2Eg.
> make CAN2.0 frames a CAN FD frame with BRS at transmission time (?!?).
>=20
> This will become a mess when people start to develop applications with
> real CAN FD hardware. This patch reverts the bad compatibility code
> together with the documentation describing the removed feature.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>=20

Thx, applied to can and included in my latest pull request.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Lie6iTIAEiMBlcwb1miswkghwCPMDhhll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMUieUACgkQjTAFq1RaXHPIfwCcDK7t89a7Anhqklw9NPpqyNMW
bkcAoIWy1RZMgvuC82KS5fJarDFSQdvC
=WQ1Z
-----END PGP SIGNATURE-----

--Lie6iTIAEiMBlcwb1miswkghwCPMDhhll--
