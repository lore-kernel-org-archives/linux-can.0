From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: fix handling of unmodifiable configuration
 options
Date: Sun, 27 Mar 2016 17:54:25 +0200
Message-ID: <56F80231.1010005@pengutronix.de>
References: <1458587901-7565-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="b3RrXnSuJVeHCib0laS232KCshcgqcGF8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60000 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751377AbcC0PzL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 27 Mar 2016 11:55:11 -0400
In-Reply-To: <1458587901-7565-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: ramesh.shanmugasundaram@bp.renesas.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b3RrXnSuJVeHCib0laS232KCshcgqcGF8
Content-Type: multipart/mixed; boundary="bvVv5vvve6pVWV3bAUIbDRkakpgPgeGf7"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: ramesh.shanmugasundaram@bp.renesas.com
Message-ID: <56F80231.1010005@pengutronix.de>
Subject: Re: [PATCH v5] can: fix handling of unmodifiable configuration
 options
References: <1458587901-7565-1-git-send-email-socketcan@hartkopp.net>
In-Reply-To: <1458587901-7565-1-git-send-email-socketcan@hartkopp.net>

--bvVv5vvve6pVWV3bAUIbDRkakpgPgeGf7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2016 08:18 PM, Oliver Hartkopp wrote:
> As described in 'can: m_can: tag current CAN FD controllers as non-ISO'=

> (6cfda7fbebe) it is possible to define fixed configuration options by
> setting the according bit in 'ctrlmode' and clear it in 'ctrlmode_suppo=
rted'.
> This leads to the incovenience that the fixed configuration bits can no=
t be
> passed by netlink even when they have the correct values (e.g. non-ISO,=
 FD).
>=20
> This patch fixes that issue and not only allows fixed set bit values to=
 be set
> again but now requires(!) to provide these fixed values at configuratio=
n time.
> A valid CAN FD configuration consists of a nominal/arbitration bittimin=
g, a
> data bittiming and a control mode with CAN_CTRLMODE_FD set - which is n=
ow
> enforced by a new can_validate() function. This fix additionally remove=
d the
> inconsistency that was prohibiting the support of 'CANFD-only' controll=
er
> drivers, like the RCar CAN FD.
>=20
> For this reason a new helper can_set_static_ctrlmode() has been introdu=
ced to
> provide a proper interface to handle static enabled CAN controller opti=
ons.
>=20
> Reported-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesa=
s.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c         | 56 +++++++++++++++++++++++++++++++++++=
++++----
>  drivers/net/can/m_can/m_can.c |  2 +-
>  include/linux/can/dev.h       | 22 +++++++++++++++--
>  3 files changed, 73 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 141c2a4..9bec2cd 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -696,11 +696,17 @@ int can_change_mtu(struct net_device *dev, int ne=
w_mtu)
>  	/* allow change of MTU according to the CANFD ability of the device *=
/
>  	switch (new_mtu) {
>  	case CAN_MTU:
> +		/* 'CANFD-only' controllers can not switch to CAN_MTU */
> +		if (priv->ctrlmode_static & CAN_CTRLMODE_FD)
> +			return -EINVAL;
> +
>  		priv->ctrlmode &=3D ~CAN_CTRLMODE_FD;
>  		break;
> =20
>  	case CANFD_MTU:
> -		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD))
> +		/* check for potential CANFD ability */
> +		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
> +		    !(priv->ctrlmode_static & CAN_CTRLMODE_FD))
>  			return -EINVAL;
> =20
>  		priv->ctrlmode |=3D CAN_CTRLMODE_FD;
> @@ -782,6 +788,35 @@ static const struct nla_policy can_policy[IFLA_CAN=
_MAX + 1] =3D {
>  				=3D { .len =3D sizeof(struct can_bittiming_const) },
>  };
> =20
> +static int can_validate(struct nlattr *tb[], struct nlattr *data[])
> +{
> +	u32 is_can_fd =3D 0;
        ^^^
I've made this bool.

> +
> +	/* Make sure that valid CAN FD configurations always consist of
> +	 * - nominal/arbitration bittiming
> +	 * - data bittiming
> +	 * - control mode with CAN_CTRLMODE_FD set
> +	 */
> +
> +	if (data[IFLA_CAN_CTRLMODE]) {
> +		struct can_ctrlmode *cm =3D nla_data(data[IFLA_CAN_CTRLMODE]);
> +
> +		is_can_fd =3D cm->flags & cm->mask & CAN_CTRLMODE_FD;
> +	}
> +
> +	if (is_can_fd) {
> +		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
> +			return -EOPNOTSUPP;
> +	}
> +
> +	if (data[IFLA_CAN_DATA_BITTIMING]) {
> +		if (!is_can_fd || !data[IFLA_CAN_BITTIMING])
> +			return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static int can_changelink(struct net_device *dev,
>  			  struct nlattr *tb[], struct nlattr *data[])
>  {
> @@ -813,19 +848,31 @@ static int can_changelink(struct net_device *dev,=

> =20
>  	if (data[IFLA_CAN_CTRLMODE]) {
>  		struct can_ctrlmode *cm;
> +		u32 ctrlstatic;
> +		u32 maskedflags;
> =20
>  		/* Do not allow changing controller mode while running */
>  		if (dev->flags & IFF_UP)
>  			return -EBUSY;
>  		cm =3D nla_data(data[IFLA_CAN_CTRLMODE]);
> +		ctrlstatic =3D priv->ctrlmode_static;
> +		maskedflags =3D cm->flags & cm->mask;
> +
> +		/* check whether provided bits are allowed to be passed */
> +		if (cm->mask & ~(priv->ctrlmode_supported | ctrlstatic))
> +			return -EOPNOTSUPP;
> +
> +		/* do not check for static fd-non-iso if 'fd' is disabled */
> +		if (!(maskedflags & CAN_CTRLMODE_FD))
> +			ctrlstatic &=3D ~CAN_CTRLMODE_FD_NON_ISO;
> =20
> -		/* check whether changed bits are allowed to be modified */
> -		if (cm->mask & ~priv->ctrlmode_supported)
> +		/* make sure static options are provided by configuration */
> +		if ((maskedflags & ctrlstatic) !=3D ctrlstatic)
>  			return -EOPNOTSUPP;
> =20
>  		/* clear bits to be modified and copy the flag values */
>  		priv->ctrlmode &=3D ~cm->mask;
> -		priv->ctrlmode |=3D (cm->flags & cm->mask);
> +		priv->ctrlmode |=3D maskedflags;
> =20
>  		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
>  		if (priv->ctrlmode & CAN_CTRLMODE_FD)
> @@ -966,6 +1013,7 @@ static struct rtnl_link_ops can_link_ops __read_mo=
stly =3D {
>  	.maxtype	=3D IFLA_CAN_MAX,
>  	.policy		=3D can_policy,
>  	.setup		=3D can_setup,
> +	.validate	=3D can_validate,
>  	.newlink	=3D can_newlink,
>  	.changelink	=3D can_changelink,
>  	.get_size	=3D can_get_size,
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index 39cf911..195f15e 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -955,7 +955,7 @@ static struct net_device *alloc_m_can_dev(void)
>  	priv->can.do_get_berr_counter =3D m_can_get_berr_counter;
> =20
>  	/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.1 */
> -	priv->can.ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO;
> +	can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> =20
>  	/* CAN_CTRLMODE_FD_NON_ISO can not be changed with M_CAN IP v3.0.1 */=

>  	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 735f9f8..098243b 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -40,8 +40,11 @@ struct can_priv {
>  	struct can_clock clock;
> =20
>  	enum can_state state;
> -	u32 ctrlmode;
> -	u32 ctrlmode_supported;
> +
> +	/* CAN controller features - see include/uapi/linux/can/netlink.h */
> +	u32 ctrlmode;		/* current options setting */
> +	u32 ctrlmode_supported;	/* options that can be modified by netlink */=

> +	u32 ctrlmode_static;	/* static enabled options for driver/hardware */=

> =20
>  	int restart_ms;
>  	struct timer_list restart_timer;
> @@ -108,6 +111,21 @@ static inline bool can_is_canfd_skb(const struct s=
k_buff *skb)
>  	return skb->len =3D=3D CANFD_MTU;
>  }
> =20
> +/* helper to define static CAN controller features at device creation =
time */
> +static inline void can_set_static_ctrlmode(struct net_device *dev,
> +					   const u32 static_mode)
                                           ^^^^^

I've removed the const here.

> +{
> +	struct can_priv *priv =3D netdev_priv(dev);
> +
> +	/* alloc_candev() succeeded =3D> netdev_priv() is valid at this point=
 */
> +	priv->ctrlmode =3D static_mode;
> +	priv->ctrlmode_static =3D static_mode;
> +
> +	/* override MTU which was set by default in can_setup()? */
> +	if (static_mode & CAN_CTRLMODE_FD)
> +		dev->mtu =3D CANFD_MTU;
> +}
> +
>  /* get data length from can_dlc with sanitized can_dlc */
>  u8 can_dlc2len(u8 can_dlc);
> =20
>=20

Applied with these changes to can-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bvVv5vvve6pVWV3bAUIbDRkakpgPgeGf7--

--b3RrXnSuJVeHCib0laS232KCshcgqcGF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJW+AIzAAoJED07qiWsqSVqhEEIAL8h6MvavWJy18id+y0Sb7A9
YGsPqCabaMByZRUu5Rr23lggqup29FuJNhdDriP+nsVLCHR9hqHbjoi6mpxjlWY+
4p1awAwVcOV6O1PGF+fkWSyGA7JxoZS6+0LFNLbJlGrt2jbq0hl7+Bc+swrKth8q
B7SKGUvR962GRD1KhGpJmqNKHzOxHlZ0ql440avXzLvjsc4t3/rp/QXS70sCh1KU
ZMszgi2yEVTJnTr6tq0BwRJcwkdKyaLM/f9SOOYShKt9zvM6dY2LzZ+PKZv3NfGl
eZ2yc+gplWvBsv3f0K+sYKNSHwN8Fdgf0WhVWX+we1O8NKWpy/fnAUWQY2R1S00=
=le3T
-----END PGP SIGNATURE-----

--b3RrXnSuJVeHCib0laS232KCshcgqcGF8--
