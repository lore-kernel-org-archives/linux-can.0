From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: sunxi: Allwinner A10/A20 CAN Controller
Date: Mon, 28 Sep 2015 08:47:37 +0200
Message-ID: <5608E289.1080507@pengutronix.de>
References: <1443200319-16655-1-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6PmrHvh5GIhmFCr1IXhCUGmdlpk5vvrSD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40866 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690AbbI1Grs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Sep 2015 02:47:48 -0400
In-Reply-To: <1443200319-16655-1-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6PmrHvh5GIhmFCr1IXhCUGmdlpk5vvrSD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2015 06:58 PM, Gerhard Bertelsmann wrote:
> fixes a bug in arbitration error reporting
>=20
> e9d2d74 sun4i_can_err: fix arbitration lost error reporting
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

Both applied to can-next. For the next patches, please don't include the
git commit id in the patch, as it will change anyway. Please format the
subject of the patch like this: "can: sun4i: <short description>" and in
the patch itself, please provide a longer description. I've changed this
while applying the patches.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6PmrHvh5GIhmFCr1IXhCUGmdlpk5vvrSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWCOKJAAoJEP5prqPJtc/Hs6EIALWlnpEaJB9lZG6JwS5qTIdk
IlyVoEJfiu25JFwCjAm2LSVWexXtdMvPec+siyRnj2fiMS/Xaih05rLrQECZQd5f
8cyU+ChqYH4UqoUVVvkCxPAR0YIzAh7uvPY/3hIoE7oYgdC+iOvpDaHXH157P2kg
NsyiSZ4e7egp5JJKb0e3HqbUE9AJDCOkj1l4xMhXPAMR8jsmRM+b58t2aaxY7meI
Uy7wb9eKzGD6G2Jo7IZZSIhDhwUYhOaFfJ7V7qblOWnFVuexA+ZkOpk26AcxXpBB
cFdLaCwcUgS1zAMvtwwevU6VpkLtyY8DqJG8a/tf1PLWCo1uog+nZh8idAcv4po=
=aoaE
-----END PGP SIGNATURE-----

--6PmrHvh5GIhmFCr1IXhCUGmdlpk5vvrSD--
