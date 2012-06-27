From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/4] can: flexcan: use be32_to_cpup to handle the value
 of dt entry
Date: Wed, 27 Jun 2012 10:38:33 +0200
Message-ID: <4FEAC689.3030902@pengutronix.de>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2E55D19BFF702EEC13729174"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46728 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2F0Iii (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:38:38 -0400
In-Reply-To: <1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2E55D19BFF702EEC13729174
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/27/2012 10:19 AM, Hui Wang wrote:
> The freescale arm i.MX series platform can support this driver, and
> usually the arm cpu works in the little endian mode by default, while
> device tree entry value is stored in big endian format, we should use
> be32_to_cpup() to handle them, after modification, it can work well
> both on the le cpu and be cpu.

good catch. We didn't notice since this clock has only been used on
powerpc so far. However you should not need to set this property, as ARM
has proper clock tree support and the clock rate is taken from the clock
tree not the device tree.

Applied to can-master.

Marc

> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> ---
>  drivers/net/can/flexcan.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 38c0690..81d4741 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -939,12 +939,12 @@ static int __devinit flexcan_probe(struct platfor=
m_device *pdev)
>  		return PTR_ERR(pinctrl);
> =20
>  	if (pdev->dev.of_node) {
> -		const u32 *clock_freq_p;
> +		const __be32 *clock_freq_p;
> =20
>  		clock_freq_p =3D of_get_property(pdev->dev.of_node,
>  						"clock-frequency", NULL);
>  		if (clock_freq_p)
> -			clock_freq =3D *clock_freq_p;
> +			clock_freq =3D be32_to_cpup(clock_freq_p);
>  	}
> =20
>  	if (!clock_freq) {


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2E55D19BFF702EEC13729174
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/qxokACgkQjTAFq1RaXHNR7QCfbZebo47FSZ/nnW6Kimdre9tc
CuYAniZJA6R5Z//cAGoyabWo4InQG1Js
=P/eU
-----END PGP SIGNATURE-----

--------------enig2E55D19BFF702EEC13729174--
