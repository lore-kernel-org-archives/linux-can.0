From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] Add CAN FD driver infrastructure
Date: Thu, 06 Feb 2014 12:41:16 +0100
Message-ID: <52F374DC.3000105@pengutronix.de>
References: <52F291D8.90008@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="48xaABoTW07gX2guK1utoFpGNqBxWFCJu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37777 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755949AbaBFLlY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2014 06:41:24 -0500
In-Reply-To: <52F291D8.90008@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--48xaABoTW07gX2guK1utoFpGNqBxWFCJu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2014 08:32 PM, Oliver Hartkopp wrote:
> This is a combined patch to create the CAN FD driver infrastructure.
>=20
> - add a separate configuration for data bittiming (incl. netlink)
> - the bitrate information is only provided when the bittiming const exi=
st
> - add the helper to create canfd frame skbs
> - do not overwrite the skb->protocol in can_put_echo_skb()

Can you split up the patch into the above mentioned aspects? More
comments inline.

Marc
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> ---
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index fc59bc6..485b266 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -99,10 +99,10 @@ static int can_update_spt(const struct can_bittimin=
g_const *btc,
>  	return 1000 * (tseg + 1 - *tseg2) / (tseg + 1);
>  }
> =20
> -static int can_calc_bittiming(struct net_device *dev, struct can_bitti=
ming *bt)
> +static int can_calc_bittiming(struct net_device *dev, struct can_bitti=
ming *bt,
> +			      const struct can_bittiming_const *btc)
>  {
>  	struct can_priv *priv =3D netdev_priv(dev);
> -	const struct can_bittiming_const *btc =3D priv->bittiming_const;
>  	long rate, best_rate =3D 0;
>  	long best_error =3D 1000000000, error =3D 0;
>  	int best_tseg =3D 0, best_brp =3D 0, brp =3D 0;
> @@ -110,7 +110,7 @@ static int can_calc_bittiming(struct net_device *de=
v, struct can_bittiming *bt)
>  	int spt_error =3D 1000, spt =3D 0, sampl_pt;
>  	u64 v64;
> =20
> -	if (!priv->bittiming_const)
> +	if (!btc)
>  		return -ENOTSUPP;
> =20
>  	/* Use CIA recommended sample points */
> @@ -204,7 +204,8 @@ static int can_calc_bittiming(struct net_device *de=
v, struct can_bittiming *bt)
>  	return 0;
>  }
>  #else /* !CONFIG_CAN_CALC_BITTIMING */
> -static int can_calc_bittiming(struct net_device *dev, struct can_bitti=
ming *bt)
> +static int can_calc_bittiming(struct net_device *dev, struct can_bitti=
ming *bt,
> +			      const struct can_bittiming_const *btc)
>  {
>  	netdev_err(dev, "bit-timing calculation not available\n");
>  	return -EINVAL;
> @@ -217,14 +218,14 @@ static int can_calc_bittiming(struct net_device *=
dev, struct can_bittiming *bt)
>   * prescaler value brp. You can find more information in the header
>   * file linux/can/netlink.h.
>   */
> -static int can_fixup_bittiming(struct net_device *dev, struct can_bitt=
iming *bt)
> +static int can_fixup_bittiming(struct net_device *dev, struct can_bitt=
iming *bt,
> +			       const struct can_bittiming_const *btc)
>  {
>  	struct can_priv *priv =3D netdev_priv(dev);
> -	const struct can_bittiming_const *btc =3D priv->bittiming_const;
>  	int tseg1, alltseg;
>  	u64 brp64;
> =20
> -	if (!priv->bittiming_const)
> +	if (!btc)
>  		return -ENOTSUPP;
> =20
>  	tseg1 =3D bt->prop_seg + bt->phase_seg1;
> @@ -254,21 +255,21 @@ static int can_fixup_bittiming(struct net_device =
*dev, struct can_bittiming *bt)
>  	return 0;
>  }
> =20
> -static int can_get_bittiming(struct net_device *dev, struct can_bittim=
ing *bt)
> +static int can_get_bittiming(struct net_device *dev, struct can_bittim=
ing *bt,
> +			     const struct can_bittiming_const *btc)
>  {
> -	struct can_priv *priv =3D netdev_priv(dev);
>  	int err;
> =20
>  	/* Check if the CAN device has bit-timing parameters */
> -	if (priv->bittiming_const) {
> +	if (btc) {
> =20
>  		/* Non-expert mode? Check if the bitrate has been pre-defined */
>  		if (!bt->tq)
>  			/* Determine bit-timing parameters */
> -			err =3D can_calc_bittiming(dev, bt);
> +			err =3D can_calc_bittiming(dev, bt, btc);
>  		else
>  			/* Check bit-timing params and calculate proper brp */
> -			err =3D can_fixup_bittiming(dev, bt);
> +			err =3D can_fixup_bittiming(dev, bt, btc);
>  		if (err)
>  			return err;
>  	}
> @@ -317,7 +318,9 @@ void can_put_echo_skb(struct sk_buff *skb, struct n=
et_device *dev,
>  	BUG_ON(idx >=3D priv->echo_skb_max);
> =20
>  	/* check flag whether this packet has to be looped back */
> -	if (!(dev->flags & IFF_ECHO) || skb->pkt_type !=3D PACKET_LOOPBACK) {=

> +	if (!(dev->flags & IFF_ECHO) || skb->pkt_type !=3D PACKET_LOOPBACK ||=

> +	    (skb->protocol !=3D htons(ETH_P_CAN) &&
> +	     skb->protocol !=3D htons(ETH_P_CANFD))) {
>  		kfree_skb(skb);
>  		return;
>  	}
> @@ -329,7 +332,6 @@ void can_put_echo_skb(struct sk_buff *skb, struct n=
et_device *dev,
>  			return;
> =20
>  		/* make settings for echo to reduce code in irq context */
> -		skb->protocol =3D htons(ETH_P_CAN);
>  		skb->pkt_type =3D PACKET_BROADCAST;
>  		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>  		skb->dev =3D dev;
> @@ -512,6 +514,30 @@ struct sk_buff *alloc_can_skb(struct net_device *d=
ev, struct can_frame **cf)
>  }
>  EXPORT_SYMBOL_GPL(alloc_can_skb);
> =20
> +struct sk_buff *alloc_canfd_skb(struct net_device *dev,
> +				struct canfd_frame **cfd)

Stephane already posted a patch to add this function. I've already
queued it. Please base you patch on linux-can-next/testing

> +{
> +	struct sk_buff *skb;
> +
> +	skb =3D netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> +			       sizeof(struct canfd_frame));
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	skb->protocol =3D htons(ETH_P_CANFD);
> +	skb->pkt_type =3D PACKET_BROADCAST;
> +	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +
> +	can_skb_reserve(skb);
> +	can_skb_prv(skb)->ifindex =3D dev->ifindex;
> +
> +	*cfd =3D (struct canfd_frame *)skb_put(skb, sizeof(struct canfd_frame=
));
> +	memset(*cfd, 0, sizeof(struct canfd_frame));
> +
> +	return skb;
> +}
> +EXPORT_SYMBOL_GPL(alloc_canfd_skb);
> +
>  struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_f=
rame **cf)
>  {
>  	struct sk_buff *skb;
> @@ -624,6 +650,10 @@ static const struct nla_policy can_policy[IFLA_CAN=
_MAX + 1] =3D {
>  				=3D { .len =3D sizeof(struct can_bittiming_const) },
>  	[IFLA_CAN_CLOCK]	=3D { .len =3D sizeof(struct can_clock) },
>  	[IFLA_CAN_BERR_COUNTER]	=3D { .len =3D sizeof(struct can_berr_counter=
) },
> +	[IFLA_CAN_DATA_BITTIMING]
> +				=3D { .len =3D sizeof(struct can_bittiming) },
> +	[IFLA_CAN_DATA_BITTIMING_CONST]
> +				=3D { .len =3D sizeof(struct can_bittiming_const) },
>  };
> =20
>  static int can_changelink(struct net_device *dev,
> @@ -644,7 +674,7 @@ static int can_changelink(struct net_device *dev,
>  		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
>  		if ((!bt.bitrate && !bt.tq) || (bt.bitrate && bt.tq))
>  			return -EINVAL;
> -		err =3D can_get_bittiming(dev, &bt);
> +		err =3D can_get_bittiming(dev, &bt, priv->bittiming_const);
>  		if (err)
>  			return err;
>  		memcpy(&priv->bittiming, &bt, sizeof(bt));
> @@ -657,6 +687,29 @@ static int can_changelink(struct net_device *dev,
>  		}
>  	}
> =20
> +	if (data[IFLA_CAN_DATA_BITTIMING]) {
> +		struct can_bittiming bt;
> +
> +		/* Do not allow changing bittiming while running */
> +		if (dev->flags & IFF_UP)
> +			return -EBUSY;
> +		memcpy(&bt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
> +		       sizeof(bt));
> +		if ((!bt.bitrate && !bt.tq) || (bt.bitrate && bt.tq))
> +			return -EINVAL;
> +		err =3D can_get_bittiming(dev, &bt, priv->data_bittiming_const);
> +		if (err)
> +			return err;
> +		memcpy(&priv->data_bittiming, &bt, sizeof(bt));
> +
> +		if (priv->do_set_data_bittiming) {
> +			/* Finally, set the bit-timing registers */
> +			err =3D priv->do_set_data_bittiming(dev);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
>  	if (data[IFLA_CAN_CTRLMODE]) {
>  		struct can_ctrlmode *cm;
> =20
> @@ -694,16 +747,23 @@ static size_t can_get_size(const struct net_devic=
e *dev)
>  	struct can_priv *priv =3D netdev_priv(dev);
>  	size_t size =3D 0;
> =20
> -	size +=3D nla_total_size(sizeof(struct can_bittiming));	/* IFLA_CAN_B=
ITTIMING */
> -	if (priv->bittiming_const)				/* IFLA_CAN_BITTIMING_CONST */
> +	if (priv->bittiming_const) {	/* IFLA_CAN_BITTIMING[_CONST] */
> +		size +=3D nla_total_size(sizeof(struct can_bittiming));
>  		size +=3D nla_total_size(sizeof(struct can_bittiming_const));
> +	}
> +
>  	size +=3D nla_total_size(sizeof(struct can_clock));	/* IFLA_CAN_CLOCK=
 */
>  	size +=3D nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
>  	size +=3D nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CT=
RLMODE */
>  	size +=3D nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
> +
>  	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
>  		size +=3D nla_total_size(sizeof(struct can_berr_counter));
> =20
> +	if (priv->data_bittiming_const)	{/* IFLA_CAN_DATA_BITTIMING[_CONST] *=
/
> +		size +=3D nla_total_size(sizeof(struct can_bittiming));
> +		size +=3D nla_total_size(sizeof(struct can_bittiming_const));
> +	}
>  	return size;
>  }
> =20
> @@ -716,19 +776,33 @@ static int can_fill_info(struct sk_buff *skb, con=
st struct net_device *dev)
> =20
>  	if (priv->do_get_state)
>  		priv->do_get_state(dev, &state);
> -	if (nla_put(skb, IFLA_CAN_BITTIMING,
> -		    sizeof(priv->bittiming), &priv->bittiming) ||
> +
> +	if ((priv->bittiming_const &&
> +	     nla_put(skb, IFLA_CAN_BITTIMING,
> +		     sizeof(priv->bittiming), &priv->bittiming)) ||
> +
>  	    (priv->bittiming_const &&
>  	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
>  		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
> +
>  	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(cm), &priv->clock) ||
>  	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
>  	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
>  	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
> +
>  	    (priv->do_get_berr_counter &&
>  	     !priv->do_get_berr_counter(dev, &bec) &&
> -	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)))
> +	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
> +
> +	    (priv->data_bittiming_const &&
> +	     nla_put(skb, IFLA_CAN_DATA_BITTIMING,
> +		     sizeof(priv->data_bittiming), &priv->data_bittiming)) ||
> +
> +	    (priv->data_bittiming_const &&
> +	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
> +		     sizeof(*priv->data_bittiming_const), priv->data_bittiming_const=
)))
>  		return -EMSGSIZE;
> +
>  	return 0;
>  }
> =20
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index fb0ab65..8adaee9 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -33,8 +33,9 @@ enum can_mode {
>  struct can_priv {
>  	struct can_device_stats can_stats;
> =20
> -	struct can_bittiming bittiming;
> -	const struct can_bittiming_const *bittiming_const;
> +	struct can_bittiming bittiming, data_bittiming;
> +	const struct can_bittiming_const *bittiming_const,
> +		*data_bittiming_const;
>  	struct can_clock clock;
> =20
>  	enum can_state state;
> @@ -45,6 +46,7 @@ struct can_priv {
>  	struct timer_list restart_timer;
> =20
>  	int (*do_set_bittiming)(struct net_device *dev);
> +	int (*do_set_data_bittiming)(struct net_device *dev);
>  	int (*do_set_mode)(struct net_device *dev, enum can_mode mode);
>  	int (*do_get_state)(const struct net_device *dev,
>  			    enum can_state *state);
> @@ -124,6 +126,8 @@ unsigned int can_get_echo_skb(struct net_device *de=
v, unsigned int idx);
>  void can_free_echo_skb(struct net_device *dev, unsigned int idx);
> =20
>  struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame=
 **cf);
> +struct sk_buff *alloc_canfd_skb(struct net_device *dev,
> +				struct canfd_frame **cfd);
>  struct sk_buff *alloc_can_err_skb(struct net_device *dev,
>  				  struct can_frame **cf);
> =20
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/=
netlink.h
> index df944ed..7e2e186 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -96,6 +96,7 @@ struct can_ctrlmode {
>  #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
>  #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
>  #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
> +#define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
> =20
>  /*
>   * CAN device statistics
> @@ -122,6 +123,8 @@ enum {
>  	IFLA_CAN_RESTART_MS,
>  	IFLA_CAN_RESTART,
>  	IFLA_CAN_BERR_COUNTER,
> +	IFLA_CAN_DATA_BITTIMING,
> +	IFLA_CAN_DATA_BITTIMING_CONST,
>  	__IFLA_CAN_MAX
>  };
> =20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--48xaABoTW07gX2guK1utoFpGNqBxWFCJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLzdNwACgkQjTAFq1RaXHOkLgCaAqi2t71MBb2i8ejTsDr91Zjy
YDMAoJdcQawtz+IogAj3FcUpC70KYcQN
=slxO
-----END PGP SIGNATURE-----

--48xaABoTW07gX2guK1utoFpGNqBxWFCJu--
