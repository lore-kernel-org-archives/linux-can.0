From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: flexcan: use of_property_read_u32 to get
 DT entry value
Date: Thu, 28 Jun 2012 12:22:48 +0200
Message-ID: <4FEC3078.2090706@pengutronix.de>
References: <1340871695-26327-1-git-send-email-jason77.wang@gmail.com> <1340871695-26327-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE23D49DEC8F7CB21CD2424EC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33192 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932865Ab2F1KWw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 06:22:52 -0400
In-Reply-To: <1340871695-26327-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: wg@grandegger.com, shawn.guo@linaro.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE23D49DEC8F7CB21CD2424EC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2012 10:21 AM, Hui Wang wrote:
> of_property_read_u32() can auto handle endian problems, use this
> function can make code clean and simple.
>=20
> No need to check return value here since the following got value
> check will handle this.

Should this go to v3.5 or to net-next? If it goes via net-next, I have
to delay it until David merges net (which has the be32_to_cpup fix).

Marc

>=20
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> ---
>  drivers/net/can/flexcan.c |   11 +++--------
>  1 files changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 81d4741..f63f826 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -938,14 +938,9 @@ static int __devinit flexcan_probe(struct platform=
_device *pdev)
>  	if (IS_ERR(pinctrl))
>  		return PTR_ERR(pinctrl);
> =20
> -	if (pdev->dev.of_node) {
> -		const __be32 *clock_freq_p;
> -
> -		clock_freq_p =3D of_get_property(pdev->dev.of_node,
> -						"clock-frequency", NULL);
> -		if (clock_freq_p)
> -			clock_freq =3D be32_to_cpup(clock_freq_p);
> -	}
> +	if (pdev->dev.of_node)
> +		of_property_read_u32(pdev->dev.of_node,
> +						"clock-frequency", &clock_freq);
> =20
>  	if (!clock_freq) {
>  		clk =3D clk_get(&pdev->dev, NULL);


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE23D49DEC8F7CB21CD2424EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/sMHgACgkQjTAFq1RaXHOP2wCfWiOOlsZRWQLPa4B6G0yblyW6
X20An1gvZVnJv7+dQ3S5+rLXZ7j1dbj/
=I18i
-----END PGP SIGNATURE-----

--------------enigE23D49DEC8F7CB21CD2424EC--
