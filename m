From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] flexcan: Enable/Disable the CAN regulator in probe/remove
Date: Tue, 11 Jun 2013 01:35:50 +0200
Message-ID: <51B662D6.8080803@pengutronix.de>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com> <1370460445-15386-2-git-send-email-festevam@gmail.com> <51B606C0.1070407@pengutronix.de> <CAOMZO5CEWHTyw3s+vLtOVMdWmNWUndOZ3E4ohpCyTFXiz+VEOQ@mail.gmail.com> <51B63974.2000100@pengutronix.de> <CAOMZO5BdBr_ms1M61-k4hEmV3HnhAd6hOuUvAx6krxG95+c_Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QXPRRAAATXTNEXQJCDRK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41670 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab3FJXgC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 19:36:02 -0400
In-Reply-To: <CAOMZO5BdBr_ms1M61-k4hEmV3HnhAd6hOuUvAx6krxG95+c_Sg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QXPRRAAATXTNEXQJCDRK
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/10/2013 10:49 PM, Fabio Estevam wrote:
> On Mon, Jun 10, 2013 at 5:39 PM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
>=20
>>> It will turn off the transceiver here, which means that can1 will not=

>>> be able to operate.
>>>
>>> Currently this situation is properly handled inside mach-mxs by only
>>> disabling the CAN transceiver when both CAN ports are not used.
>>
>> Why don't you enable the regulator in can1, too?
>=20
> Since they use the same regulator (the same GPIO pin control both CAN
> ports on mx28evk), I can not have regulator disabled for can0 and
> regulator enabled for can1.

Why not? I think regulators have proper refcounts and will stay enabled
in the "disabled for CAN0 and enabled for CAN1" case.

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QXPRRAAATXTNEXQJCDRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG2YtkACgkQjTAFq1RaXHPdZgCfajrxdLIj+3ovM8tb6Fm5zp5w
ANIAoI2ldJ4YIZlXIBzA15+dBS9iihkc
=+fuF
-----END PGP SIGNATURE-----

------enig2QXPRRAAATXTNEXQJCDRK--
