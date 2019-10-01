From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: D_CAN: perform a sofware reset on open
Date: Tue, 1 Oct 2019 16:32:03 +0200
Message-ID: <b30e9834-a324-ad97-2050-df9600a95347@pengutronix.de>
References: <20190926085005.24805-1-jhofstee@victronenergy.com>
 <20190926085005.24805-2-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CxEYVO550M7s3e8MDS4Ep5pJEHYG80ajY"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190926085005.24805-2-jhofstee@victronenergy.com>
Sender: netdev-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CxEYVO550M7s3e8MDS4Ep5pJEHYG80ajY
Content-Type: multipart/mixed; boundary="3ZbNhm0xQ9KhHL5eB4JjdEL0J6uGELmxM";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jeroen Hofstee <jhofstee@victronenergy.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <b30e9834-a324-ad97-2050-df9600a95347@pengutronix.de>
Subject: Re: [PATCH 1/2] can: D_CAN: perform a sofware reset on open
References: <20190926085005.24805-1-jhofstee@victronenergy.com>
 <20190926085005.24805-2-jhofstee@victronenergy.com>
In-Reply-To: <20190926085005.24805-2-jhofstee@victronenergy.com>

--3ZbNhm0xQ9KhHL5eB4JjdEL0J6uGELmxM
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/26/19 10:50 AM, Jeroen Hofstee wrote:
> When the C_CAN interface is closed it is put in power down mode, but
> does not reset the error counters / state. So reset the D_CAN on open,
> so the reported state and the actual state match.
>=20
> According to [1], the C_CAN module doesn't have the software reset.
>=20
> [1] http://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd=
8/users_manual_c_can_fd8_r210_1.pdf
>=20
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> ---
>  drivers/net/can/c_can/c_can.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
> index 606b7d8ffe13..502a181d02e7 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -52,6 +52,7 @@
>  #define CONTROL_EX_PDR		BIT(8)
> =20
>  /* control register */
> +#define CONTROL_SWR		BIT(15)
>  #define CONTROL_TEST		BIT(7)
>  #define CONTROL_CCE		BIT(6)
>  #define CONTROL_DISABLE_AR	BIT(5)
> @@ -569,6 +570,26 @@ static void c_can_configure_msg_objects(struct net=
_device *dev)
>  				   IF_MCONT_RCV_EOB);
>  }
> =20
> +static int software_reset(struct net_device *dev)

Please add the common prefix "c_can_" to the function

> +{
> +	struct c_can_priv *priv =3D netdev_priv(dev);
> +	int retry =3D 0;
> +
> +	if (priv->type !=3D BOSCH_D_CAN)
> +		return 0;
> +
> +	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_SWR | CONTROL_INIT);
> +	while (priv->read_reg(priv, C_CAN_CTRL_REG) & CONTROL_SWR) {
> +		msleep(20);
> +		if (retry++ > 100) {
> +			netdev_err(dev, "CCTRL: software reset failed\n");
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Configure C_CAN chip:
>   * - enable/disable auto-retransmission
> @@ -578,6 +599,11 @@ static void c_can_configure_msg_objects(struct net=
_device *dev)
>  static int c_can_chip_config(struct net_device *dev)
>  {
>  	struct c_can_priv *priv =3D netdev_priv(dev);
> +	int err;
> +
> +	err =3D software_reset(dev);
> +	if (err)
> +		return err;
> =20
>  	/* enable automatic retransmission */
>  	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3ZbNhm0xQ9KhHL5eB4JjdEL0J6uGELmxM--

--CxEYVO550M7s3e8MDS4Ep5pJEHYG80ajY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2TY2MACgkQWsYho5Hk
nSCnNQf/fxP6RyApeEeqNzd2tEzG8NZnyfj8qcFnLbEt8R/6DbhV/7a2gZ0RQiTN
ZypaH/G/JOX8Vf7dKOUrB0OfSYg9ep3zWm5K4iNsvugOB8WmoXRMgnt6qXBRBE1j
hZehejAMuERtPqOX7qFVh8YsksVlkJKQtZi5gSVYiDJ3f/7ZivLmfDA4UKKvD1a9
eeNNPLu6DS658FQcMmkel90cVh+PMMlvRkhAWUtJzfVYRfZvxIBKapZFIWiEh15s
25bwQ697aTj5taKsSpaHFIDRAsheLInWPi/ziAjimeB0RsrQEncfw9LfqddiLNB+
QnEHZoNXFMhnnekcHO2FzFkG66QW/g==
=by5s
-----END PGP SIGNATURE-----

--CxEYVO550M7s3e8MDS4Ep5pJEHYG80ajY--
