From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: Propagate SO_PRIORITY of raw sockets to skbs
Date: Mon, 27 Jan 2014 10:21:13 +0100
Message-ID: <52E62509.7020008@pengutronix.de>
References: <1390565857-10417-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pB2fvL8e78ibb1S0ml5NKIfO23EESOaKo"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46535 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbaA0JVT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Jan 2014 04:21:19 -0500
In-Reply-To: <1390565857-10417-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>, linux-can@vger.kernel.org
Cc: lisovy@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pB2fvL8e78ibb1S0ml5NKIfO23EESOaKo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2014 01:17 PM, Michal Sojka wrote:
> From: Rostislav Lisovy <lisovy@gmail.com>
>=20
> This allows controlling certain queueing disciplines by setting the
> socket's SO_PRIORITY option.
>=20
> For example, with the default pfifo_fast queueing discipline, which
> provides three priorities, socket priority TC_PRIO_CONTROL means
> higher than default and TC_PRIO_BULK means lower than default.
>=20
> Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>

Applied to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pB2fvL8e78ibb1S0ml5NKIfO23EESOaKo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLmJQkACgkQjTAFq1RaXHPLnwCfRzigr4nGhPT5p0cyBhuuP6Ui
8+sAn0xt7Kp3R3c/2qdK7vfHjXDcBQfp
=mVsX
-----END PGP SIGNATURE-----

--pB2fvL8e78ibb1S0ml5NKIfO23EESOaKo--
