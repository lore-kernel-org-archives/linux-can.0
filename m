From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/4] can: flexcan: add hardware controller version support
Date: Wed, 27 Jun 2012 10:27:27 +0200
Message-ID: <4FEAC3EF.3060606@pengutronix.de>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4A947672FAB244E7870DDFE7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50212 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab2F0I1m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:27:42 -0400
In-Reply-To: <1340785161-3598-3-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A947672FAB244E7870DDFE7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/27/2012 10:19 AM, Hui Wang wrote:
> At least in the i.MX series, the flexcan contrller divides into ver_3
> and ver_10, current driver is for ver_3 controller.
>=20
> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
> Its reset value is 0xffffffff, this means ID Filter Table must be
> checked when receive a packet, but the driver is designed to accept
> everything during the chip start, we need to clear this register to
> follow this design.
>=20
> Add a hw_ver entry in the device tree, this can let us distinguish
> which version the controller is, if we don't set value to this entry,
> the hw_ver is 3 by default, this is backward compatible for existing
> platforms like powerpc and imx35.

Is it possible to read this value from the hardware?
Another possibility would be to introduce a new compatible device in the
device tree.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4A947672FAB244E7870DDFE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/qw+8ACgkQjTAFq1RaXHPQjACeKvbpnFF3WUmzOH4wJlEzpAf3
IfIAniGd5ZIYqb3wP06WKV6dgfyZasP2
=aD+K
-----END PGP SIGNATURE-----

--------------enig4A947672FAB244E7870DDFE7--
