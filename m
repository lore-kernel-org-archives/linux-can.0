From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RFC] libsocketcan: Fix return value for get{set}_link()
 function
Date: Thu, 06 Feb 2014 11:47:06 +0100
Message-ID: <52F3682A.9080609@pengutronix.de>
References: <1391420421-20930-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Go4kWBHxGelX9cwggfwoVkRRR0LcFMJEO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34192 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706AbaBFKrM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2014 05:47:12 -0500
In-Reply-To: <1391420421-20930-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Go4kWBHxGelX9cwggfwoVkRRR0LcFMJEO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2014 10:40 AM, Alexander Shiyan wrote:
> This patch makes return value negative when open_nl_sock() function
> fail and removes excess labels.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Go4kWBHxGelX9cwggfwoVkRRR0LcFMJEO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLzaCoACgkQjTAFq1RaXHM75gCfTB0jXdj6cfv/1jWBK43P/KbY
UXMAoI2+YuC1H9vHG0udCye1wGOM1Myg
=DkxH
-----END PGP SIGNATURE-----

--Go4kWBHxGelX9cwggfwoVkRRR0LcFMJEO--
