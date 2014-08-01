From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [patch] can: c_can: checking IS_ERR() instead of NULL
Date: Fri, 01 Aug 2014 11:01:36 +0200
Message-ID: <53DB5770.7040808@pengutronix.de>
References: <20140801085344.GA31702@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6BLxRpcpsNgXWP5Oh269vgoQTTCA4Atkb"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20140801085344.GA31702@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Wolfgang Grandegger <wg@grandegger.com>, George Cherian <george.cherian@ti.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thor Thayer <tthayer@altera.com>, Pavel Machek <pavel@denx.de>, Mugunthan V N <mugunthanvnm@ti.com>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-can@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6BLxRpcpsNgXWP5Oh269vgoQTTCA4Atkb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2014 10:53 AM, Dan Carpenter wrote:
> devm_ioremap() returns NULL on error, not an ERR_PTR().
>=20
> Fixes: 33cf75656923 ('can: c_can_platform: Fix raminit, use devm_iorema=
p() instead of devm_ioremap_resource()')

Doh!

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This will need to go to -stable because the patch which introduces the
> bug is going to be pushed to -stable.
>=20
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index 5dede6e..109cb44 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -280,7 +280,7 @@ static int c_can_plat_probe(struct platform_device =
*pdev)
> =20
>  		priv->raminit_ctrlreg =3D devm_ioremap(&pdev->dev, res->start,
>  						     resource_size(res));
> -		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
> +		if (!priv->raminit_ctrlreg || priv->instance < 0)

What about using PTR_ERR_OR_ZERO()?

>  			dev_info(&pdev->dev, "control memory is not used for raminit\n");
>  		else
>  			priv->raminit =3D c_can_hw_raminit_ti;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6BLxRpcpsNgXWP5Oh269vgoQTTCA4Atkb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPbV3AACgkQjTAFq1RaXHOIlwCdFepKXuSbO1Axg7oG34OvV1eA
5bQAn2IEajmAiteDDLJRu1dDCA8y3WRS
=VpUw
-----END PGP SIGNATURE-----

--6BLxRpcpsNgXWP5Oh269vgoQTTCA4Atkb--
