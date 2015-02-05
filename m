From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V5 2/3] bfin_can: rewrite the driver into common style
 with MMU
Date: Thu, 05 Feb 2015 12:05:31 +0100
Message-ID: <54D34E7B.9060001@pengutronix.de>
References: <1423133067-17289-1-git-send-email-Aaron.wu@analog.com> <1423133067-17289-2-git-send-email-Aaron.wu@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mGEIobs7DkFhJKLvrwJ9ofq8MLnLFiHlN"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423133067-17289-2-git-send-email-Aaron.wu@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Wu <Aaron.wu@analog.com>, wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-devel@analog.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mGEIobs7DkFhJKLvrwJ9ofq8MLnLFiHlN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2015 11:44 AM, Aaron Wu wrote:
> Rewrite the blackfin CAN driver into more common style in three ways:
> part 1/3: rewrite blackfin style of read/write into common readw/writew=

> part 2/3: introduce ioremap to be compitable with MMU enabled arch
> part 3/3: merge the header file from the blackfin arch dependent
> location to driver code directly, note the original copy of more comple=
ted
> bfin_can.h in arch depentdent location is reserved for reg test purpose=

>=20
> V5 changes: merge contents of header file into drivere code in patch 3/=
3
> V4 changes: remove unused variable in patch 2/3
> V3 changes: remove redundant cast in patch 2/3
> V2 changes: split patch into two parts
> V1 changes: rewrite code into common style
>=20
> Signed-off-by: Aaron Wu <Aaron.wu@analog.com>
> ---
>  drivers/net/can/bfin_can.c |   22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
> index 0a5eff4..0209c14 100644
> --- a/drivers/net/can/bfin_can.c
> +++ b/drivers/net/can/bfin_can.c
> @@ -551,16 +551,10 @@ static int bfin_can_probe(struct platform_device =
*pdev)
>  		goto exit;
>  	}
> =20
> -	if (!request_mem_region(res_mem->start, resource_size(res_mem),
> -				dev_name(&pdev->dev))) {
> -		err =3D -EBUSY;
> -		goto exit;
> -	}
> -
>  	/* request peripheral pins */
>  	err =3D peripheral_request_list(pdata, dev_name(&pdev->dev));
>  	if (err)
> -		goto exit_mem_release;
> +		goto exit;
> =20
>  	dev =3D alloc_bfin_candev();
>  	if (!dev) {
> @@ -569,7 +563,13 @@ static int bfin_can_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	priv =3D netdev_priv(dev);
> -	priv->membase =3D (void __iomem *)res_mem->start;
> +
> +	priv->membase =3D devm_ioremap_resource(&pdev->dev, res_mem);
> +	if (IS_ERR(priv->membase)) {
> +		dev_err(&pdev->dev, "Cannot map IO\n");

devm_ioremap_resource() already prints an error message.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mGEIobs7DkFhJKLvrwJ9ofq8MLnLFiHlN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU005+AAoJECte4hHFiupUIkUQAIHK4PWALpWt7gFNINxO4RRo
ech7WRf7yNSOV+gYdtqlKVlo/0SgSwt1UtQk7BKBTpNXRhp6CkUjAktUmK4Q67rT
twEHQRye4CMXDijIBWLOTICQUk4X+uKLGDMf15ZuRb/BhJi74HAlgAgwMIfztYp7
mFio8xLD08/qRLCAfJJWlOy4rb88Ro2qCv5HhbZUaPPtKPNjXo/oiJe30LduoMkm
km8E2qzfqIs9LXdV+b9z4j35xSEllerlPwOjFGZZOiurP+jCB08Zt4zk+O+qbnd8
4BQ5HlZdngoruQS/SasjekwVh1vgrGob2rJYS4NsdonyQb94V3lC1FBIvuhgHQHi
yo61uYnn3ccenlOcSIXLqRmieCq11WlRachNDaohg+m4i3LvOJPYnNynV7Mt5kEZ
hPphjBzgJnH8ho9n29SVsyvhx+zf8eM67JLInh2X7SUudLjcDurXg0jjlASITrNy
xi1ou6kGNfyTlR//0J1egxeIdl5m4lXV8/tzxVOidHgq/ArRUdSNpf+DlNIO3KxQ
ylBEWBbwbdNShJIwYtcjPdpr9haXI363RS0EHLWyeRN/DuCpZI5dtotqgP82JhkN
SfGmVpiuWLB8T6RqDDSxavd5M8XmrsOfmh7hzC3KBQSgj4CaAr93YyZN0i9ZMe/p
WHj/FWNvS8WKNZ5C68qA
=yTIg
-----END PGP SIGNATURE-----

--mGEIobs7DkFhJKLvrwJ9ofq8MLnLFiHlN--
