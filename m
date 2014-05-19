From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: unify identifiers to ensure unique include processing
Date: Mon, 19 May 2014 08:20:10 +0200
Message-ID: <5379A29A.1040404@pengutronix.de>
References: <1400178716-8748-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Jiq5fdohAnAakpq1skVR7iH17jNUkLrhu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56083 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaESGUN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 02:20:13 -0400
In-Reply-To: <1400178716-8748-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jiq5fdohAnAakpq1skVR7iH17jNUkLrhu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2014 08:31 PM, Oliver Hartkopp wrote:
> Armin pointed me to the fact that the identifier which is used to ensur=
e the
> unique include processing in lunux/include/uapi/linux/can.h is CAN_H.
> This clashed with his own source as includes from libraries and APIs sh=
ould
> use an underscore '_' at the identifier start.
>=20
> This patch fixes the protection identifiers in all CAN relavant include=
s.
>=20
> Reported-by: Armin Burchardt <armin@uni-bremen.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Jiq5fdohAnAakpq1skVR7iH17jNUkLrhu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlN5opoACgkQjTAFq1RaXHPxFwCfcHE3kPvrU7biPLSTJJZlGKdH
pW4AoIVUTs2Pa5ezHlgguEYtm0+LKZ4i
=UquL
-----END PGP SIGNATURE-----

--Jiq5fdohAnAakpq1skVR7iH17jNUkLrhu--
