From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can: flexcan: disable clocks during stop mode
Date: Tue, 10 Dec 2019 09:31:47 +0100
Message-ID: <3ccfc7ac-b860-8254-ad39-66e2f50a5f3c@pengutronix.de>
References: <20191210071252.26165-1-qiangqing.zhang@nxp.com>
 <20191210071252.26165-2-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lnW7fl0OROBhIE49JrvV35DXoVT6kEWG6"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191210071252.26165-2-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lnW7fl0OROBhIE49JrvV35DXoVT6kEWG6
Content-Type: multipart/mixed; boundary="jK4mD1wBQRjuOpIGsEtNuO9txxU9hNrzI";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <3ccfc7ac-b860-8254-ad39-66e2f50a5f3c@pengutronix.de>
Subject: Re: [PATCH 2/2] can: flexcan: disable clocks during stop mode
References: <20191210071252.26165-1-qiangqing.zhang@nxp.com>
 <20191210071252.26165-2-qiangqing.zhang@nxp.com>
In-Reply-To: <20191210071252.26165-2-qiangqing.zhang@nxp.com>

--jK4mD1wBQRjuOpIGsEtNuO9txxU9hNrzI
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/10/19 8:16 AM, Joakim Zhang wrote:
> Disable clocks during CAN in stop mode.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/flexcan.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 6c1ccf9f6c08..d767f85c80d3 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1786,10 +1786,16 @@ static int __maybe_unused flexcan_noirq_suspend=
(struct device *device)
>  {
>  	struct net_device *dev =3D dev_get_drvdata(device);
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	int err;
> =20
> -	if (netif_running(dev) && device_may_wakeup(device))
> +	if (netif_running(dev) && device_may_wakeup(device)) {
>  		flexcan_enable_wakeup_irq(priv, true);
> =20
> +		err =3D pm_runtime_force_suspend(device);
> +		if (err)
> +			return err;
> +	}

What about moving the pm_runtime_force_suspend() call for both cases
"device_may_wakeup()" and "!device_may_wakeup()" into the
flexcan_noirq_suspend() handler?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--jK4mD1wBQRjuOpIGsEtNuO9txxU9hNrzI--

--lnW7fl0OROBhIE49JrvV35DXoVT6kEWG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3vV/MACgkQWsYho5Hk
nSC9FQf/c5s7hkfr8XM4tHz8Oet950Rfzdp94c/sbauUbbXx5VmVnd+IpsLbpiga
WhsSOrEHZBFU++Pk+AP323n3yqbbou9X5g7G/oV5d/5Z/o5gAtHPzvhuGcg5HEdZ
uzUoVc14SY8QvYhUD0CU5bcmMYq6QhYf/9ySGWwsSQaRy6s5RDmbzFfooZ0pFjL0
BVPdoXZHS74s8N0OQi0HeJvYXIDopzUcTt/1nLunFIEWdDkjzGcXamMBjgJI2QBg
289oIFNwm89y+uM0mS1EAOi02hbFnEiJV7lvRCw9GIsuqpvHZA1PVb3M7sGp+bWo
Do7jAhfa2jUW0WzOBaBXJrYKR8fCTQ==
=uXSH
-----END PGP SIGNATURE-----

--lnW7fl0OROBhIE49JrvV35DXoVT6kEWG6--
