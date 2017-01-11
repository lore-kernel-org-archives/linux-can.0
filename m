From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] [RFCv3] can: add CAN interface termination API
Date: Wed, 11 Jan 2017 16:20:54 +0100
Message-ID: <83c1d026-4f60-e0f3-dba9-abfcf17087ea@pengutronix.de>
References: <20170110175206.22733-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gWIK1rjJdKu4HHJltbkUGk3OcvlsrAC6G"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36803 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750890AbdAKPVB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2017 10:21:01 -0500
In-Reply-To: <20170110175206.22733-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gWIK1rjJdKu4HHJltbkUGk3OcvlsrAC6G
Content-Type: multipart/mixed; boundary="f7qcn61hnx1XmgDdWK6qvl7Xv2Qg5Ihs5";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <83c1d026-4f60-e0f3-dba9-abfcf17087ea@pengutronix.de>
Subject: Re: [PATCH] [RFCv3] can: add CAN interface termination API
References: <20170110175206.22733-1-socketcan@hartkopp.net>
In-Reply-To: <20170110175206.22733-1-socketcan@hartkopp.net>

--f7qcn61hnx1XmgDdWK6qvl7Xv2Qg5Ihs5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2017 06:52 PM, Oliver Hartkopp wrote:
> This patch adds a netlink interface to configure the CAN bus terminatio=
n of
> CAN interfaces.
>=20
> Inside the driver an array of supported termination values is defined:
>=20
> const u16 drvname_termination[] =3D { 60, 120, CAN_TERMINATION_DISABLED=
 };
>=20
> struct drvname_priv *priv;
> priv =3D netdev_priv(dev);
>=20
> priv->termination_const =3D &drvname_termination;
> priv->termination_const_cnt =3D ARRAY_SIZE(drvname_termination);
> priv->termination =3D CAN_TERMINATION_DISABLED;
>=20
> And the funtion to set the value has to be defined:
>=20
> priv->do_set_termination =3D drvname_set_termination;
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c            | 37 ++++++++++++++++++++++++++++++++=
++++-
>  include/linux/can/dev.h          |  4 ++++
>  include/uapi/linux/can/netlink.h |  5 +++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 8d6208c0b400..900feacaf0ac 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -958,6 +958,30 @@ static int can_changelink(struct net_device *dev,
>  		}
>  	}
> =20
> +	if (data[IFLA_CAN_TERMINATION]) {
> +		u16 termval =3D nla_get_u16(data[IFLA_CAN_TERMINATION]);
> +		int num_term =3D priv->termination_const_cnt;
> +		int i;
> +
> +		if (!priv->do_set_termination)
> +			return -EOPNOTSUPP;
> +
> +		/* check whether given value is supported by the interface */
> +		for (i =3D 0; i < num_term; i++) {
> +			if (termval =3D=3D priv->termination_const[i])
> +				break;
> +		}
> +		if (i >=3D num_term)
> +			return -EINVAL;
> +
> +		/* Finally, set the termination value */
> +		err =3D priv->do_set_termination(dev, termval);
> +		if (err)
> +			return err;
> +
> +		priv->termination =3D termval;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -980,6 +1004,11 @@ static size_t can_get_size(const struct net_devic=
e *dev)
>  		size +=3D nla_total_size(sizeof(struct can_bittiming));
>  	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST *=
/
>  		size +=3D nla_total_size(sizeof(struct can_bittiming_const));
> +	if (priv->termination_const &&
> +	    priv->termination_const_cnt) {			/* IFLA_CAN_TERMINATION_CONST */=

> +		size +=3D nla_total_size(priv->termination_const_cnt * sizeof(u16));=

> +		size +=3D nla_total_size(sizeof(u16));		/* IFLA_CAN_TERMINATION */
> +	}

I've converted the sizeof(u16) to sizeof(priv->termination) and
sizeof(*priv->termination_const). The code looks like this:

> +       if (priv->termination_const) {
> +               size +=3D nla_total_size(sizeof(priv->termination));   =
           /* IFLA_CAN_TERMINATION */
> +               size +=3D nla_total_size(sizeof(*priv->termination_cons=
t) *       /* IFLA_CAN_TERMINATION_CONST */
> +                                      priv->termination_const_cnt);
> +       }

> =20
>  	return size;
>  }
> @@ -1018,7 +1047,13 @@ static int can_fill_info(struct sk_buff *skb, co=
nst struct net_device *dev)
>  	    (priv->data_bittiming_const &&
>  	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
>  		     sizeof(*priv->data_bittiming_const),
> -		     priv->data_bittiming_const)))
> +		     priv->data_bittiming_const)) ||
> +
> +	    (priv->termination_const && priv->termination_const_cnt &&
> +	     nla_put(skb, IFLA_CAN_TERMINATION_CONST,
> +		     priv->termination_const_cnt * sizeof(u16),
> +		     priv->termination_const) &&
                                              ^^

This must be an ||, as nla_put return 0 on success.

I've converted the sizeof(u16) here, too:

> +           (priv->termination_const &&
> +            (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination)=
 ||
> +             nla_put(skb, IFLA_CAN_TERMINATION_CONST,
> +                     sizeof(*priv->termination_const) *
> +                     priv->termination_const_cnt,
> +                     priv->termination_const))))

> +	     nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination)))
>  		return -EMSGSIZE;
> =20
>  	return 0;
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 5f5270941ba0..cba7f4b5a722 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -38,6 +38,9 @@ struct can_priv {
>  	struct can_bittiming bittiming, data_bittiming;
>  	const struct can_bittiming_const *bittiming_const,
>  		*data_bittiming_const;
> +	const u16 *termination_const;
> +	const int termination_const_cnt;
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

Also, I've added a check for consistency, so a lot of "termination_const
&& termination_const_cnt" can be reduced to just a check for
termination_const.

>  int register_candev(struct net_device *dev)
>  {
> +       struct can_priv *priv =3D netdev_priv(dev);
> +
> +       /* Ensure termination_cost and termination_const_cnt
> +        * consistency. Both must be either set or unset.
> +        */
> +       if ((priv->termination_const && priv->termination_const_cnt <=3D=
 0) ||
> +           (!priv->termination_const && priv->termination_const_cnt !=3D=
 0))
> +               return -EINVAL;
> +

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--f7qcn61hnx1XmgDdWK6qvl7Xv2Qg5Ihs5--

--gWIK1rjJdKu4HHJltbkUGk3OcvlsrAC6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh2TVYACgkQPTuqJayp
JWrMWwfzB2VEwmEo+GasQ6Dza1H5l4nORTLiobR+grBmwh8bSsctUhqIWEeVYakg
bgE4vLJif3iDhzr1P1IfJiDKPCRjdKVTC21cXYaXOOlAl1YMxqokwpTXcim8sGrG
Ts3UysSb5iO69mjGHWlaBjoHh1Skhj/5XVm+opKi284pfvDlTobZtvUWrAUhGXho
ebp1Et7qYloXHjuf5eEwWzznU4u9eFgGXAi8V+WUpz9ZsR4UupGpNaCLQUtEmjoP
P/cikGf69jf6z4P2c3XiuVlOnd7Ndbcp3f1vEf3FZ+mVu+3Dkh+6Tur/dri/P1b1
n8PzzssTmN8yn66Hvfxux8ZbAKOb
=myKi
-----END PGP SIGNATURE-----

--gWIK1rjJdKu4HHJltbkUGk3OcvlsrAC6G--
