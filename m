From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: Re: [PATCH RFC] can: replace timestamp as unique skb attribute
Date: Mon, 13 Jul 2015 11:26:09 +0200
Message-ID: <55A38431.9040004@gmx.at>
References: <1435312699-25999-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uv9uofGbUUCCh41drdJmfDpMqlgcOnMBu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:50254 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbbGMJ0a (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 13 Jul 2015 05:26:30 -0400
In-Reply-To: <1435312699-25999-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: tom_usenet@optusnet.com.au, s.grosjean@peak-system.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uv9uofGbUUCCh41drdJmfDpMqlgcOnMBu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2015-06-26 11:58, Oliver Hartkopp wrote:
> Commit 514ac99c64b "can: fix multiple delivery of a single CAN frame fo=
r
> overlapping CAN filters" requires the skb->tstamp to be set to check fo=
r
> identical CAN skbs.
>=20
> Without timestamping to be required by user space applications this tim=
estamp
> was not generated which lead to commit 36c01245eb8 "can: fix loss of CA=
N
> frames in raw_rcv" - which forces the timestamp to be set in all CAN re=
lated
> skbuffs by introducing several __net_timestamp() calls.
>=20
> This forces e.g. out of tree drivers to add __net_timestamp() after skb=
uff
> creation to prevent the frame loss fixed in mainline Linux.
>=20
> This patch removes the timestamp dependency and uses an atomic counter =
to
> create an unique identifier together with the skbuff pointer.
>=20
> Btw. the new skbcnt element introduced in struct can_skb_priv has to be=

> initialized with zero in out-of-tree drivers too.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c   |  7 ++-----
>  drivers/net/can/slcan.c |  2 +-
>  drivers/net/can/vcan.c  |  3 ---
>  include/linux/can/skb.h |  2 ++
>  net/can/af_can.c        | 12 +++++++-----
>  net/can/bcm.c           |  2 ++
>  net/can/raw.c           |  7 ++++---
>  7 files changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index e9b1810..aede704 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -440,9 +440,6 @@ unsigned int can_get_echo_skb(struct net_device *de=
v, unsigned int idx)
>  		struct can_frame *cf =3D (struct can_frame *)skb->data;
>  		u8 dlc =3D cf->can_dlc;
> =20
> -		if (!(skb->tstamp.tv64))
> -			__net_timestamp(skb);
> -
>  		netif_rx(priv->echo_skb[idx]);
>  		priv->echo_skb[idx] =3D NULL;
> =20
> @@ -578,7 +575,6 @@ struct sk_buff *alloc_can_skb(struct net_device *de=
v, struct can_frame **cf)
>  	if (unlikely(!skb))
>  		return NULL;
> =20
> -	__net_timestamp(skb);
>  	skb->protocol =3D htons(ETH_P_CAN);
>  	skb->pkt_type =3D PACKET_BROADCAST;
>  	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> @@ -589,6 +585,7 @@ struct sk_buff *alloc_can_skb(struct net_device *de=
v, struct can_frame **cf)
> =20
>  	can_skb_reserve(skb);
>  	can_skb_prv(skb)->ifindex =3D dev->ifindex;
> +	can_skb_prv(skb)->skbcnt =3D 0;
> =20
>  	*cf =3D (struct can_frame *)skb_put(skb, sizeof(struct can_frame));
>  	memset(*cf, 0, sizeof(struct can_frame));
> @@ -607,7 +604,6 @@ struct sk_buff *alloc_canfd_skb(struct net_device *=
dev,
>  	if (unlikely(!skb))
>  		return NULL;
> =20
> -	__net_timestamp(skb);
>  	skb->protocol =3D htons(ETH_P_CANFD);
>  	skb->pkt_type =3D PACKET_BROADCAST;
>  	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> @@ -618,6 +614,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *=
dev,
> =20
>  	can_skb_reserve(skb);
>  	can_skb_prv(skb)->ifindex =3D dev->ifindex;
> +	can_skb_prv(skb)->skbcnt =3D 0;
> =20
>  	*cfd =3D (struct canfd_frame *)skb_put(skb, sizeof(struct canfd_frame=
));
>  	memset(*cfd, 0, sizeof(struct canfd_frame));
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index f64f529..a23a7af 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -207,7 +207,6 @@ static void slc_bump(struct slcan *sl)
>  	if (!skb)
>  		return;
> =20
> -	__net_timestamp(skb);
>  	skb->dev =3D sl->dev;
>  	skb->protocol =3D htons(ETH_P_CAN);
>  	skb->pkt_type =3D PACKET_BROADCAST;
> @@ -215,6 +214,7 @@ static void slc_bump(struct slcan *sl)
> =20
>  	can_skb_reserve(skb);
>  	can_skb_prv(skb)->ifindex =3D sl->dev->ifindex;
> +	can_skb_prv(skb)->skbcnt =3D 0;
> =20
>  	memcpy(skb_put(skb, sizeof(struct can_frame)),
>  	       &cf, sizeof(struct can_frame));
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index 0ce868d..674f367 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -78,9 +78,6 @@ static void vcan_rx(struct sk_buff *skb, struct net_d=
evice *dev)
>  	skb->dev       =3D dev;
>  	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> =20
> -	if (!(skb->tstamp.tv64))
> -		__net_timestamp(skb);
> -
>  	netif_rx_ni(skb);
>  }
> =20
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index b6a52a4..51bb653 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -27,10 +27,12 @@
>  /**
>   * struct can_skb_priv - private additional data inside CAN sk_buffs
>   * @ifindex:	ifindex of the first interface the CAN frame appeared on
> + * @skbcnt:	atomic counter to have an unique id together with skb poin=
ter
>   * @cf:		align to the following CAN frame at skb->data
>   */
>  struct can_skb_priv {
>  	int ifindex;
> +	int skbcnt;
>  	struct can_frame cf[0];
>  };
> =20
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 689c818..62c635f 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -89,6 +89,8 @@ struct timer_list can_stattimer;   /* timer for stati=
stics update */
>  struct s_stats    can_stats;       /* packet statistics */
>  struct s_pstats   can_pstats;      /* receive list statistics */
> =20
> +static atomic_t skbcounter =3D ATOMIC_INIT(0);
> +
>  /*
>   * af_can socket functions
>   */
> @@ -310,12 +312,8 @@ int can_send(struct sk_buff *skb, int loop)
>  		return err;
>  	}
> =20
> -	if (newskb) {
> -		if (!(newskb->tstamp.tv64))
> -			__net_timestamp(newskb);
> -
> +	if (newskb)
>  		netif_rx_ni(newskb);
> -	}
> =20
>  	/* update statistics */
>  	can_stats.tx_frames++;
> @@ -683,6 +681,10 @@ static void can_receive(struct sk_buff *skb, struc=
t net_device *dev)
>  	can_stats.rx_frames++;
>  	can_stats.rx_frames_delta++;
> =20
> +	/* create non-zero unique skb identifier together with *skb */
> +	while (!(can_skb_prv(skb)->skbcnt))
> +		can_skb_prv(skb)->skbcnt =3D atomic_inc_return(&skbcounter);
> +
>  	rcu_read_lock();
> =20
>  	/* deliver the packet to sockets listening on all devices */
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b523453..a1ba687 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -261,6 +261,7 @@ static void bcm_can_tx(struct bcm_op *op)
> =20
>  	can_skb_reserve(skb);
>  	can_skb_prv(skb)->ifindex =3D dev->ifindex;
> +	can_skb_prv(skb)->skbcnt =3D 0;
> =20
>  	memcpy(skb_put(skb, CFSIZ), cf, CFSIZ);
> =20
> @@ -1217,6 +1218,7 @@ static int bcm_tx_send(struct msghdr *msg, int if=
index, struct sock *sk)
>  	}
> =20
>  	can_skb_prv(skb)->ifindex =3D dev->ifindex;
> +	can_skb_prv(skb)->skbcnt =3D 0;
>  	skb->dev =3D dev;
>  	can_skb_set_owner(skb, sk);
>  	err =3D can_send(skb, 1); /* send with loopback */
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 31b9748..2e67b14 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -75,7 +75,7 @@ MODULE_ALIAS("can-proto-1");
>   */
> =20
>  struct uniqframe {
> -	ktime_t tstamp;
> +	int skbcnt;
>  	const struct sk_buff *skb;
>  	unsigned int join_rx_count;
>  };
> @@ -133,7 +133,7 @@ static void raw_rcv(struct sk_buff *oskb, void *dat=
a)
> =20
>  	/* eliminate multiple filter matches for the same skb */
>  	if (this_cpu_ptr(ro->uniq)->skb =3D=3D oskb &&
> -	    ktime_equal(this_cpu_ptr(ro->uniq)->tstamp, oskb->tstamp)) {
> +	    this_cpu_ptr(ro->uniq)->skbcnt =3D=3D can_skb_prv(oskb)->skbcnt) =
{
>  		if (ro->join_filters) {
>  			this_cpu_inc(ro->uniq->join_rx_count);
>  			/* drop frame until all enabled filters matched */
> @@ -144,7 +144,7 @@ static void raw_rcv(struct sk_buff *oskb, void *dat=
a)
>  		}
>  	} else {
>  		this_cpu_ptr(ro->uniq)->skb =3D oskb;
> -		this_cpu_ptr(ro->uniq)->tstamp =3D oskb->tstamp;
> +		this_cpu_ptr(ro->uniq)->skbcnt =3D can_skb_prv(oskb)->skbcnt;
>  		this_cpu_ptr(ro->uniq)->join_rx_count =3D 1;
>  		/* drop first frame to check all enabled filters? */
>  		if (ro->join_filters && ro->count > 1)
> @@ -749,6 +749,7 @@ static int raw_sendmsg(struct socket *sock, struct =
msghdr *msg, size_t size)
> =20
>  	can_skb_reserve(skb);
>  	can_skb_prv(skb)->ifindex =3D dev->ifindex;
> +	can_skb_prv(skb)->skbcnt =3D 0;
> =20
>  	err =3D memcpy_from_msg(skb_put(skb, size), msg, size);
>  	if (err < 0)
>=20

I've tested this in my original situation on i.MX6Q so I can give a

Tested-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>

best regards,
manfred


--uv9uofGbUUCCh41drdJmfDpMqlgcOnMBu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVo4Q0AAoJEGS1eKPM78Wh1t4QAKTxG7Wp1K3T0JBxIgg088We
Z8UUX/vwB9/QAwo5dZg5mVGpOB5pwSZ6XTr62Em+S3dGFfVMtflCp9NPc+gpYR3i
Upfb/JDT5uFgX48q1cdVruIxozGLurVXBzhllGed0Dr8nrYuUYmyi4lFU3nuBuje
dE/IFsG7Mtxwzo6dQ3T+P+fI2F+fBCJZewz2+kS4kxxU9fKBrR9HDzogVYYIqJPZ
W9abHmyOraalx0CrH1QfAQ2WlvkLe02J/EUoB5Qrc1XgwxwmY6ZVG1BWMZMliJtl
HP9NC73AHHYNtRuw1C/aIHBfSvx/yBSLp75A8dG+t4iLyO+CAU6urcZEsQeCFu3N
Fz/EciHuR52PhJ9FRlV8rC5+KSG8lS2rYMiDiotdvSHeqd91iCSjcwPOvr6QpzeI
NbB/PhMxrZvVrse1CxxfKnoeEcCfvR8GRemOYIzpUtQXEegWAey2Lp2touUQCwtV
CksgO4RbEK6439LmYN0rbVlOBz3ARCoTMlQVayZFS5MCnd930LtL3GtqyU38ztjt
kG3RMkXqFU8epH6d/92Bxdut8LRna3Dio+4lHfkpWyaX+1DBMRHZuh2ycxcrg1Iu
HoUxeIkb236d3pL5UzlGXQIt/Pzel7RzjpTbmjM90Xqq7Dr7+QrzAp8YAnJMoIft
GC75XeBsi+1k6popIA+A
=dTkI
-----END PGP SIGNATURE-----

--uv9uofGbUUCCh41drdJmfDpMqlgcOnMBu--
