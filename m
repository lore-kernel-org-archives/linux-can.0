From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: use kbuild magic to inherit debug settings
Date: Mon, 18 Aug 2014 01:04:31 +0200
Message-ID: <53F134FF.2090407@pengutronix.de>
References: <1408315120-8422-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="h5d5iCLAD7e2dKWIP85Qeg5loWH09ceQD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53038 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbaHQXGg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 17 Aug 2014 19:06:36 -0400
In-Reply-To: <1408315120-8422-1-git-send-email-wsa@the-dreams.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, netdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h5d5iCLAD7e2dKWIP85Qeg5loWH09ceQD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/18/2014 12:38 AM, Wolfram Sang wrote:
> No need to manually copy debug settings into subdir Makefiles. kbuild
> has a mechanism for inheriting, so let's use it.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to can-next.

Thanks, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--h5d5iCLAD7e2dKWIP85Qeg5loWH09ceQD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPxNQwACgkQjTAFq1RaXHM45ACffLzL5mvfXaILVHb03kALjOQD
IuYAmwSMhEHyvP1q1aC5+Ka4yzhMQjXP
=agEi
-----END PGP SIGNATURE-----

--h5d5iCLAD7e2dKWIP85Qeg5loWH09ceQD--
