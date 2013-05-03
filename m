From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH, RFC 01/22] can: move CONFIG_HAVE_CAN_FLEXCAN out of CAN_DEV
Date: Fri, 03 May 2013 11:53:47 +0200
Message-ID: <5183892B.8020400@pengutronix.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de> <1367507786-505303-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2RLNQFBWPGEEENDMLDLME"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42860 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282Ab3ECJxu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 May 2013 05:53:50 -0400
In-Reply-To: <1367507786-505303-2-git-send-email-arnd@arndb.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2RLNQFBWPGEEENDMLDLME
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/02/2013 05:16 PM, Arnd Bergmann wrote:
> CONFIG_HAVE_CAN_FLEXCAN is a silect symbol that is meant to be selected=

> by platforms that support this driver, but that is not possible without=

> also selecting CAN_DEV, unless we move it out of the "if CAN_DEV"
> section of the Kconfig file.
>=20
> warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 &&
>  IMX_HAVE_PLATFORM_FLEXCAN && SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_=
FLEXCAN
>  which has unmet direct dependencies (NET && CAN && CAN_DEV)

With the advent of multi platform kernels I like to get rid of
HAVE_CAN_FLEXCAN completely.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2RLNQFBWPGEEENDMLDLME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGDiSsACgkQjTAFq1RaXHPmjACfRDYRA0AqYwoOhxMHTIf4wwGR
kdMAniOfggzXZYyEnm8BpusfWOkAUnAM
=TRIL
-----END PGP SIGNATURE-----

------enig2RLNQFBWPGEEENDMLDLME--
