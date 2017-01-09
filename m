From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] [RFCv2] can: add CAN interface termination API
Date: Mon, 9 Jan 2017 10:25:10 +0100
Message-ID: <762d5db6-6115-af51-bbce-8d96f3b8d947@pengutronix.de>
References: <20170108163506.30818-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="W6N2XGaNHus0vJGf8Ax5Ni2c1fE73TWnW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45697 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932627AbdAIJZS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Jan 2017 04:25:18 -0500
In-Reply-To: <20170108163506.30818-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W6N2XGaNHus0vJGf8Ax5Ni2c1fE73TWnW
Content-Type: multipart/mixed; boundary="P9Uc15529ao2clm1oDOXscNrhOND63nw3";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <762d5db6-6115-af51-bbce-8d96f3b8d947@pengutronix.de>
Subject: Re: [PATCH] [RFCv2] can: add CAN interface termination API
References: <20170108163506.30818-1-socketcan@hartkopp.net>
In-Reply-To: <20170108163506.30818-1-socketcan@hartkopp.net>

--P9Uc15529ao2clm1oDOXscNrhOND63nw3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2017 05:35 PM, Oliver Hartkopp wrote:
> This patch adds a netlink interface to configure the CAN bus terminatio=
n of
> CAN interfaces.
>=20
> Inside the driver an array of supported termination values is defined:
>=20
> const u16 drvname_termination =3D { 60, 120, CAN_TERMINATION_DISABLED }=
;

drvname_termination[]

>=20
> struct drvname_priv *priv;
> priv =3D netdev_priv(dev);
>=20
> priv->termination_const =3D &drvname_termination;
> priv->termination_const_size =3D sizeof(drvname_termination);

ARRAY_SIZE()

> priv->termination =3D CAN_TERMINATION_DISABLED;
>=20
> And the funtion to set the value has to be defined:
>=20
> priv->do_set_termination =3D drvname_set_termination;
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c            | 34 ++++++++++++++++++++++++++++++++=
+-
>  include/linux/can/dev.h          |  4 ++++
>  include/uapi/linux/can/netlink.h |  5 +++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 8d6208c0b400..f98825f6ea2e 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -958,6 +958,27 @@ static int can_changelink(struct net_device *dev,
>  		}
>  	}
> =20
> +	if (data[IFLA_CAN_TERMINATION]) {
> +		u16 t =3D nla_get_u16(data[IFLA_CAN_TERMINATION]);
> +		int num_t =3D priv->termination_const_size / sizeof(u16);

ARRAY_SIZE...or see below:

> +		int i;
> +
> +		/* check whether given value is supported by the interface */
> +		for (i =3D 0; i < num_t && t !=3D priv->termination_const[i]; i++);

Nitpick: unusual for() loop, better make more explicit what's going on:

for (i =3D 0; i < ARRAY_SIZE(priv->termination_const_size), i++) {
	if (t =3D=3D priv->termination_const[i])
		break;
}

> +		if (i >=3D num_t)
> +			return -EINVAL;
> +
> +		if (priv->do_set_termination) {

What about moving the check for priv->do_set_termination in front of the
loop?

> +			/* Finally, set the termination */
> +			err =3D priv->do_set_termination(dev, t);
> +			if (err)
> +				return err;
> +
> +			priv->termination =3D t;
> +		} else
> +			return -EOPNOTSUPP;

{ } on both legs of the else

> +	}
> +
>  	return 0;
>  }
> =20
> @@ -980,6 +1001,11 @@ static size_t can_get_size(const struct net_devic=
e *dev)
>  		size +=3D nla_total_size(sizeof(struct can_bittiming));
>  	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST *=
/
>  		size +=3D nla_total_size(sizeof(struct can_bittiming_const));
> +	if (priv->termination_const &&
> +	    priv->termination_const_size) {			/* IFLA_CAN_TERMINATION_CONST *=
/
> +		size +=3D nla_total_size(priv->termination_const_size);
> +		size +=3D nla_total_size(sizeof(u16));		/* IFLA_CAN_TERMINATION */
> +	}
> =20
>  	return size;
>  }
> @@ -1018,7 +1044,13 @@ static int can_fill_info(struct sk_buff *skb, co=
nst struct net_device *dev)
>  	    (priv->data_bittiming_const &&
>  	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
>  		     sizeof(*priv->data_bittiming_const),
> -		     priv->data_bittiming_const)))
> +		     priv->data_bittiming_const)) ||
> +
> +	    (priv->termination_const && priv->termination_const_size &&
> +	     nla_put(skb, IFLA_CAN_TERMINATION_CONST,
> +		     priv->termination_const_size,
> +		     priv->termination_const) &&
> +	     nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination)))
>  		return -EMSGSIZE;
> =20
>  	return 0;
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 5f5270941ba0..7aa0eb1a75e3 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -38,6 +38,9 @@ struct can_priv {
>  	struct can_bittiming bittiming, data_bittiming;
>  	const struct can_bittiming_const *bittiming_const,
>  		*data_bittiming_const;
> +	const u16 *termination_const;
> +	const int termination_const_size;
> +	u16 termination;
>  	struct can_clock clock;
> =20
>  	enum can_state state;
> @@ -53,6 +56,7 @@ struct can_priv {
>  	int (*do_set_bittiming)(struct net_device *dev);
>  	int (*do_set_data_bittiming)(struct net_device *dev);
>  	int (*do_set_mode)(struct net_device *dev, enum can_mode mode);
> +	int (*do_set_termination)(struct net_device *dev, u16 term);
>  	int (*do_get_state)(const struct net_device *dev,
>  			    enum can_state *state);
>  	int (*do_get_berr_counter)(const struct net_device *dev,
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/=
netlink.h
> index 94ffe0c83ce7..7414771926fb 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -127,9 +127,14 @@ enum {
>  	IFLA_CAN_BERR_COUNTER,
>  	IFLA_CAN_DATA_BITTIMING,
>  	IFLA_CAN_DATA_BITTIMING_CONST,
> +	IFLA_CAN_TERMINATION,
> +	IFLA_CAN_TERMINATION_CONST,
>  	__IFLA_CAN_MAX
>  };
> =20
>  #define IFLA_CAN_MAX	(__IFLA_CAN_MAX - 1)
> =20
> +/* u16 termination range: 1..65535 Ohms */
> +#define CAN_TERMINATION_DISABLED 0
> +
>  #endif /* !_UAPI_CAN_NETLINK_H */
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--P9Uc15529ao2clm1oDOXscNrhOND63nw3--

--W6N2XGaNHus0vJGf8Ax5Ni2c1fE73TWnW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhzVvYACgkQPTuqJayp
JWqpoggAh9Zhq/o3ZVIPyqyr5BuwrmONoBORHIuW5rI8Zu93PpIVXeXlSWlYF3Fp
8mpteele4vH+WQfJptQr45qVq23aDTFs647y7QooAlf/FInECTYaNrH3ms+AR8XE
fLNYJzcmcQj7WNREXKBnRBBlALdiO/DIkBb3UQMG9zsnvYm/nTcKNKmmWe/mC4jk
hYiuYTvzAAECOkft0YSVOPkshu9tO2Da7uYwhLbovGkYD2Tq1B+PEiWvvLYP6b4N
U/1YygcvBY1A4miEFa/R82pl7NW5ilZEj3VIjBHGkxHCHitlKtnTGLSGO0zpetLR
EA894yXMl0gKKmD2phN/1Ix2KuOZtQ==
=FiM3
-----END PGP SIGNATURE-----

--W6N2XGaNHus0vJGf8Ax5Ni2c1fE73TWnW--
