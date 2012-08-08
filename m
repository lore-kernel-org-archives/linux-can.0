From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Wed, 08 Aug 2012 11:55:10 +0200
Message-ID: <5022377E.7000606@pengutronix.de>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org> <1340853701-4488-3-git-send-email-shawn.guo@linaro.org> <502226AB.4050205@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA0901A8B574BC9E2BAAB1E6F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33724 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab2HHJzO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 Aug 2012 05:55:14 -0400
In-Reply-To: <502226AB.4050205@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0901A8B574BC9E2BAAB1E6F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

adding linux-can on Cc.

On 08/08/2012 10:43 AM, Hui Wang wrote:
> Hi Shawn,
>=20
> Any progress on this patch, has it been merged?

No, for several reasons:
- I don't want to have a "toggle transceiver gpio" function open coded
  in every CAN driver. For now it's just flexcan, but on at91 we need
  the same functionality.
- The transceiver may be shared by several CAN cores, to sharing must
  be designed in.
- Lothar Wa=DFmann posted a more generic solution:
  http://patchwork.ozlabs.org/patch/168023/

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA0901A8B574BC9E2BAAB1E6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAiN34ACgkQjTAFq1RaXHO/TwCeL/15oMlyU23YBnzbLtjLhkFI
dDAAn3hM7zcosxTRVpOnBCALa7vWcCzh
=WIN9
-----END PGP SIGNATURE-----

--------------enigA0901A8B574BC9E2BAAB1E6F--
