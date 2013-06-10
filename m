From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] flexcan: Enable/Disable the CAN regulator in probe/remove
Date: Mon, 10 Jun 2013 19:02:56 +0200
Message-ID: <51B606C0.1070407@pengutronix.de>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com> <1370460445-15386-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2RKGTUVOULOUQRQBRUFOT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46542 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab3FJRDC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 13:03:02 -0400
In-Reply-To: <1370460445-15386-2-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2RKGTUVOULOUQRQBRUFOT
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/05/2013 09:27 PM, Fabio Estevam wrote:
> mx28evk has two CAN ports and they are controlled by the same GPIO.
>=20
> If can0 runs flexcan_chip_stop(), then the regulator will be disabled, =
which
> means that can1 cannot run anymore.

Are you sure? I think the regulator framework has a proper refcount.

> To overcome such scenario, let's enable the CAN regulator in flexcan_pr=
obe()
> and disabled it in flexcan_remove().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2RKGTUVOULOUQRQBRUFOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG2BsAACgkQjTAFq1RaXHMl1gCgkvReuwIuu5F32OtdrBVIUWsY
JJsAmQHMWukrXfF5tW5aOANYEKFNBiss
=rmy9
-----END PGP SIGNATURE-----

------enig2RKGTUVOULOUQRQBRUFOT--
