From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] flexcan.c: avoid calling usleep_range from interrupt
 context
Date: Tue, 02 Sep 2014 12:54:10 +0200
Message-ID: <5405A1D2.5040406@pengutronix.de>
References: <1409133736-23526-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FRvIJPiRxMoDrwTPJlGSBup2EJc2rn76G"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54501 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaIBKyN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 06:54:13 -0400
In-Reply-To: <1409133736-23526-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, wg@grandegger.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FRvIJPiRxMoDrwTPJlGSBup2EJc2rn76G
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2014 12:02 PM, David Jander wrote:
> Apparently can_restart() runs from a (timer-) interrupt and can call
> flexcan_chip_[en|dis]able(), so avoid using usleep_range()
>=20
> Signed-off-by: David Jander <david@protonic.nl>

Applied to can-master.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FRvIJPiRxMoDrwTPJlGSBup2EJc2rn76G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQFodIACgkQjTAFq1RaXHP45gCeLjo6CJ1p2DH8ZwdZlBXTTbW+
0ncAnA93g9eKPXHNGKsP8HA374aKiTTe
=IZFa
-----END PGP SIGNATURE-----

--FRvIJPiRxMoDrwTPJlGSBup2EJc2rn76G--
