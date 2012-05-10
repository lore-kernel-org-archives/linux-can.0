From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2] CAN FD support
Date: Thu, 10 May 2012 22:09:13 +0200
Message-ID: <4FAC2069.3010304@pengutronix.de>
References: <4FAC1288.3090801@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5CF6DF1EC44F437C10E27842"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53250 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab2EJUJW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 May 2012 16:09:22 -0400
In-Reply-To: <4FAC1288.3090801@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5CF6DF1EC44F437C10E27842
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/10/2012 09:10 PM, Oliver Hartkopp wrote:
> Hi all,
>=20
> first thanks for the feedback for my previous post.

Thanks for your efford!

> The move from handling CAN DLCs to real payload data length made the th=
ings
> much easier and much better readable.
>=20
> Changelog:
>=20
> - move internal CAN DLC handling to payload length processing
>   - updated CAN frame structure *comments* regarding dlc/len
>   - moved dlc <-> length helpers to drivers/net/can/dev.c
>   - generally use canfd_frame.len for length checks
>   - added CAN[FD]_MAX_D[LC|LEN] defines
>=20
> - inverted the defaults in CAN FD flags (EDL & HDR is now enabled by de=
fault)
>=20
> - reduce checks of ETH_P_CAN(FD) especially in raw.c
>   - depend checks for CAN FD frames only on skb->len instead of skb->pr=
otocol
>   - commonly set ETH_P_CAN(FD) in can_send() again (depending on the MT=
U size)
>=20
> - return -EMSGSIZE when sending CAN FD frames to non CAN FD netdevices
>=20
> - vcan: allow the changing of the MTU only when interface is down
>=20
> Regarding the discussion about ETH_P_CANFD with Kurt and Felix i would =
like
> to stick on this separate ethernet protocol type. I've checked many pla=
ces in
> the Linux source code and whenever there was a different content filled=
 into
> the skb a different skb->protocol is set.
+1

>=20
> Btw. as i was able to reduce the sanity checks to skb->len checks in mo=
st
> cases the ETH_P_CANFD does not add any remarkable overhead.
>=20
> The patch should now be easier to follow than the first RFC :-)
>=20
> I generated this diff by 'git diff fb7944b' on the repository

:)

> https://gitorious.org/~hartkopp/linux-can/hartkopps-linux-can-next
>=20
> Regards,
> Oliver
>=20
>=20
>  drivers/net/can/dev.c    |   35 +++++++++++++++
>  drivers/net/can/vcan.c   |   28 +++++++++---
>  include/linux/can.h      |   51 +++++++++++++++++++++-
>  include/linux/can/core.h |    4 -
>  include/linux/can/dev.h  |   33 +++++++++++---
>  include/linux/can/raw.h  |    3 -
>  include/linux/if_ether.h |    3 -
>  net/can/af_can.c         |  106 ++++++++++++++++++++++++++++++++++++--=
---------
>  net/can/raw.c            |   41 +++++++++++++++++-
>  9 files changed, 256 insertions(+), 48 deletions(-)
>=20
> ---
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index f03d7a4..a33c00f 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -33,6 +33,39 @@ MODULE_DESCRIPTION(MOD_DESC);
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
> =20
> +/* CAN DLC to real data length conversion helpers */
> +
> +static const u8 dlc2len[16] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8,
> +			       12, 16, 20, 24, 32, 48, 64};
                           ^^
 nitpick: not really needed.

> +
> +/* get data length from can_dlc with sanitized can_dlc */
> +u8 can_dlc2len(u8 can_dlc)
> +{
> +	return dlc2len[can_dlc & 0x0F];
> +}
> +EXPORT_SYMBOL_GPL(can_dlc2len);
> +

dito
                           VV
> +static const u8 len2dlc[65] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8,	/* 0 - 8 *=
/
> +			       9, 9, 9, 9,			/* 9 - 12 */
> +			       10, 10, 10, 10,			/* 13 - 16 */
> +			       11, 11, 11, 11,			/* 17 - 20 */
> +			       12, 12, 12, 12,			/* 21 - 24 */
> +			       13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
> +			       14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
> +			       14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
> +			       15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
> +			       15, 15, 15, 15, 15, 15, 15, 15}; /* 57 - 64 */
> +
> +/* map the sanitized data length to an appropriate data length code */=
=20
> +u8 can_len2dlc(u8 len)
> +{
> +	if (unlikely(len > 64))
                         ^^^^^

ARRAY_SIZE?

> +		return 0xF;
> +
> +	return len2dlc[len];
> +}
> +EXPORT_SYMBOL_GPL(can_len2dlc);
> +
>  #ifdef CONFIG_CAN_CALC_BITTIMING
>  #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
> =20
> @@ -454,7 +487,7 @@ EXPORT_SYMBOL_GPL(can_bus_off);
>  static void can_setup(struct net_device *dev)
>  {
>  	dev->type =3D ARPHRD_CAN;
> -	dev->mtu =3D sizeof(struct can_frame);
> +	dev->mtu =3D CAN_MTU;
>  	dev->hard_header_len =3D 0;
>  	dev->addr_len =3D 0;
>  	dev->tx_queue_len =3D 10;
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index ea2d942..78967c7 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -70,13 +70,12 @@ MODULE_PARM_DESC(echo, "Echo sent frames (for testi=
ng). Default: 0 (Off)");
> =20
>  static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
>  {
> -	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
>  	struct net_device_stats *stats =3D &dev->stats;
> =20
>  	stats->rx_packets++;
> -	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_bytes +=3D cfd->len;
> =20
> -	skb->protocol  =3D htons(ETH_P_CAN);
>  	skb->pkt_type  =3D PACKET_BROADCAST;
>  	skb->dev       =3D dev;
>  	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> @@ -86,7 +85,7 @@ static void vcan_rx(struct sk_buff *skb, struct net_d=
evice *dev)
> =20
>  static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev=
)
>  {
> -	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
>  	struct net_device_stats *stats =3D &dev->stats;
>  	int loop;
> =20
> @@ -94,7 +93,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struc=
t net_device *dev)
>  		return NETDEV_TX_OK;
> =20
>  	stats->tx_packets++;
> -	stats->tx_bytes +=3D cf->can_dlc;
> +	stats->tx_bytes +=3D cfd->len;
> =20
>  	/* set flag whether this packet has to be looped back */
>  	loop =3D skb->pkt_type =3D=3D PACKET_LOOPBACK;
> @@ -108,7 +107,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, str=
uct net_device *dev)
>  			 * CAN core already did the echo for us
>  			 */
>  			stats->rx_packets++;
> -			stats->rx_bytes +=3D cf->can_dlc;
> +			stats->rx_bytes +=3D cfd->len;
>  		}
>  		kfree_skb(skb);
>  		return NETDEV_TX_OK;
> @@ -133,14 +132,29 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, s=
truct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
> =20
> +static int vcan_change_mtu(struct net_device *dev, int new_mtu)
> +{

Do we need rtnl_lock here?

> +	/* Do not allow changing the MTU while running */
> +	if (dev->flags & IFF_UP)
> +		return -EBUSY;
> +
> +	if (new_mtu =3D=3D CAN_MTU || new_mtu =3D=3D CANFD_MTU) {
> +		dev->mtu =3D new_mtu;
> +		return 0;
> +	}

I personally prefer when the:
	if (error_condition)
		return -EFOO;"

style.

> +
> +	return -EINVAL;
> +}
> +
>  static const struct net_device_ops vcan_netdev_ops =3D {
>  	.ndo_start_xmit =3D vcan_tx,
> +	.ndo_change_mtu =3D vcan_change_mtu,
>  };
> =20
>  static void vcan_setup(struct net_device *dev)
>  {
>  	dev->type		=3D ARPHRD_CAN;
> -	dev->mtu		=3D sizeof(struct can_frame);
> +	dev->mtu		=3D CAN_MTU;
>  	dev->hard_header_len	=3D 0;
>  	dev->addr_len		=3D 0;
>  	dev->tx_queue_len	=3D 0;
> diff --git a/include/linux/can.h b/include/linux/can.h
> index 9a19bcb..c8504ac 100644
> --- a/include/linux/can.h
> +++ b/include/linux/can.h
> @@ -46,18 +46,65 @@ typedef __u32 canid_t;
>   */
>  typedef __u32 can_err_mask_t;
> =20
> +#define CAN_MAX_DLC 8
> +#define CAN_MAX_DLEN 8
> +
> +#define CANFD_MAX_DLC 15
> +#define CANFD_MAX_DLEN 64
> +
>  /**
>   * struct can_frame - basic CAN frame structure
>   * @can_id:  the CAN ID of the frame and CAN_*_FLAG flags, see above.
> - * @can_dlc: the data length field of the CAN frame
> + * @can_dlc: frame payload length in byte (0 .. 8) aka data length cod=
e.
> + *           The DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
> + *           mapping of the 'data length code' to the payload length.
>   * @data:    the CAN frame payload.
>   */
>  struct can_frame {
>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> -	__u8    can_dlc; /* data length code: 0 .. 8 */
> +	__u8    can_dlc; /* frame payload length in byte (0 .. 8) */
>  	__u8    data[8] __attribute__((aligned(8)));
>  };
> =20
> +/*
> + * defined bits for canfd_frame.flags
> + *
> + * As the default for CAN FD should be to support the high data rate i=
n the
> + * payload section of the frame (HDR) and to support up to 64 byte in =
the
> + * data section (EDL) the bits are only set in the non-default case.
> + * Btw. as long as there's no real implementation for CAN FD network d=
river
> + * these bits are only preliminary.
> + *
> + * RX: NOHDR/NOEDL - info about received CAN FD frame
> + *     ESI         - bit from originating CAN controller
> + * TX: NOHDR/NOEDL - control per-frame settings if supported by CAN co=
ntroller
> + *     ESI         - bit is set by local CAN controller
> + */
> +#define CANFD_NOHDR 0x01 /* frame without high data rate */
> +#define CANFD_NOEDL 0x02 /* frame without extended data length */
> +#define CANFD_ESI   0x04 /* error state indicator */

You can make use of BIT(0), BIT(1), etc.

> +
> +/**
> + * struct canfd_frame - CAN flexible data rate frame structure
> + * @can_id: the CAN ID of the frame and CAN_*_FLAG flags, see above.
> + * @len:    frame payload length in byte (0 .. 64)
> + * @flags:  additional flags for CAN FD
> + * @__res0: reserved / padding
> + * @__res1: reserved / padding
> + * @data:   the CAN FD frame payload (up to 64 byte).
> + */
> +struct canfd_frame {
> +	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> +	__u8    len;     /* frame payload length in byte (0 .. 64) */
> +	__u8    flags;   /* additional flags for CAN FD */
> +	__u8    __res0;  /* reserved / padding */
> +	__u8    __res1;  /* reserved / padding */
> +	__u8    data[64] __attribute__((aligned(8)));
> +};
> +
> +#define CAN_MTU		(sizeof(struct can_frame))
> +#define CANFD_MTU	(sizeof(struct canfd_frame))
> +
>  /* particular protocols of the protocol family PF_CAN */
>  #define CAN_RAW		1 /* RAW sockets */
>  #define CAN_BCM		2 /* Broadcast Manager */
> diff --git a/include/linux/can/core.h b/include/linux/can/core.h
> index 0ccc1cd..9bc51c1 100644
> --- a/include/linux/can/core.h
> +++ b/include/linux/can/core.h
> @@ -17,10 +17,10 @@
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
> =20
> -#define CAN_VERSION "20090105"
> +#define CAN_VERSION "20120508"
> =20
>  /* increment this number each time you change some user-space interfac=
e */
> -#define CAN_ABI_VERSION "8"
> +#define CAN_ABI_VERSION "9"
> =20
>  #define CAN_VERSION_STRING "rev " CAN_VERSION " abi " CAN_ABI_VERSION
> =20
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 5d2efe7..a082529 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -61,23 +61,40 @@ struct can_priv {
>   * To be used in the CAN netdriver receive path to ensure conformance =
with
>   * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
>   */
> -#define get_can_dlc(i)	(min_t(__u8, (i), 8))
> +#define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
> +#define get_canfd_dlc(i)	(min_t(__u8, (i), CANFD_MAX_DLC))
> =20
>  /* Drop a given socketbuffer if it does not contain a valid CAN frame.=
 */
>  static inline int can_dropped_invalid_skb(struct net_device *dev,
>  					  struct sk_buff *skb)
>  {
> -	const struct can_frame *cf =3D (struct can_frame *)skb->data;
> -
> -	if (unlikely(skb->len !=3D sizeof(*cf) || cf->can_dlc > 8)) {
> -		kfree_skb(skb);
> -		dev->stats.tx_dropped++;
> -		return 1;
> -	}
> +	const struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> +
> +	if (skb->protocol =3D=3D htons(ETH_P_CAN)) {
> +		if (skb->len !=3D sizeof(struct can_frame) ||
> +		    cfd->len > CAN_MAX_DLEN)
> +			goto inval_skb;
> +	} else if (skb->protocol =3D=3D htons(ETH_P_CANFD)) {
> +		if (skb->len !=3D sizeof(struct canfd_frame) ||
> +		    cfd->len > CANFD_MAX_DLEN)
> +			goto inval_skb;

what about adding/keeping the unlikely to both inner ifs?

> +	} else
> +		goto inval_skb;
> =20
>  	return 0;
> +
> +inval_skb:

Please add a space before the jump label. git diff will use things which
start on the first column to give hunks more context information. See
here for example:

>> +++ b/include/linux/can/raw.h
>> @@ -23,7 +23,8 @@ enum {
                     ^^^^
>>  	CAN_RAW_FILTER =3D 1,	/* set 0 .. n can_filter(s)          */
>>  	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
>>  	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
>> -	CAN_RAW_RECV_OWN_MSGS	/* receive my own msgs (default:off) */
>> +	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
>> +	CAN_RAW_FD_FRAMES,	/* use struct canfd_frame (default:off) */
>>  };

So that you see this belongs to an enum. If you add a jumplabel on the
first column you overwrite the function name. Clever isn't it?

> +	kfree_skb(skb);
> +	dev->stats.tx_dropped++;
> +	return 1;
>  }
> =20
> +/* get data length from can_dlc with sanitized can_dlc */
> +u8 can_dlc2len(u8 can_dlc);
> +
> +/* map the sanitized data length to an appropriate data length code */=
=20
> +u8 can_len2dlc(u8 len);
> +
>  struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb=
_max);
>  void free_candev(struct net_device *dev);
> =20
> diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
> index 781f3a3..5448c0f 100644
> --- a/include/linux/can/raw.h
> +++ b/include/linux/can/raw.h
> @@ -23,7 +23,8 @@ enum {
>  	CAN_RAW_FILTER =3D 1,	/* set 0 .. n can_filter(s)          */
>  	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
>  	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
> -	CAN_RAW_RECV_OWN_MSGS	/* receive my own msgs (default:off) */
> +	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
> +	CAN_RAW_FD_FRAMES,	/* use struct canfd_frame (default:off) */
>  };
> =20
>  #endif
> diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
> index 56d907a..260138b 100644
> --- a/include/linux/if_ether.h
> +++ b/include/linux/if_ether.h
> @@ -105,7 +105,8 @@
>  #define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP fram=
es*/
>  #define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frame=
s */
>  #define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type 	*/
> -#define ETH_P_CAN	0x000C		/* Controller Area Network      */
> +#define ETH_P_CAN	0x000C		/* Controller Area Network (CAN)*/
> +#define ETH_P_CANFD	0x000D		/* CAN FD 64 byte payload frames*/
>  #define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP*/
>  #define ETH_P_TR_802_2	0x0011		/* 802.2 frames 		*/
>  #define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 0ce2ad0..414cf40 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -41,6 +41,7 @@
>   */
> =20
>  #include <linux/module.h>
> +#include <linux/stddef.h>
>  #include <linux/init.h>
>  #include <linux/kmod.h>
>  #include <linux/slab.h>
> @@ -220,30 +221,42 @@ static int can_create(struct net *net, struct soc=
ket *sock, int protocol,
>   *  -ENOBUFS on full driver queue (see net_xmit_errno())
>   *  -ENOMEM when local loopback failed at calling skb_clone()
>   *  -EPERM when trying to send on a non-CAN interface
> + *  -EMSGSIZE CAN frame size is bigger than CAN interface MTU
>   *  -EINVAL when the skb->data does not contain a valid CAN frame
>   */
>  int can_send(struct sk_buff *skb, int loop)
>  {
>  	struct sk_buff *newskb =3D NULL;
> -	struct can_frame *cf =3D (struct can_frame *)skb->data;
> -	int err;
> +	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> +	int err =3D -EINVAL;
> +
> +	if (skb->len =3D=3D CAN_MTU) {
> +		skb->protocol =3D htons(ETH_P_CAN);
> +		if (cfd->len > CAN_MAX_DLEN)
> +			goto inval_skb;
> +	} else if (skb->len =3D=3D CANFD_MTU) {
> +		skb->protocol =3D htons(ETH_P_CANFD);
> +		if (cfd->len > CANFD_MAX_DLEN)
> +			goto inval_skb;
> +	} else
> +		goto inval_skb;
> =20
> -	if (skb->len !=3D sizeof(struct can_frame) || cf->can_dlc > 8) {
> -		kfree_skb(skb);
> -		return -EINVAL;
> +	/* make sure the CAN frame can pass the selected CAN netdevice */
> +	if (skb->len > skb->dev->mtu) {
> +		err =3D -EMSGSIZE;
> +		goto inval_skb;
>  	}
> =20
>  	if (skb->dev->type !=3D ARPHRD_CAN) {
> -		kfree_skb(skb);
> -		return -EPERM;
> +		err =3D -EPERM;
> +		goto inval_skb;
>  	}
> =20
>  	if (!(skb->dev->flags & IFF_UP)) {
> -		kfree_skb(skb);
> -		return -ENETDOWN;
> +		err =3D -ENETDOWN;
> +		goto inval_skb;
>  	}
> =20
> -	skb->protocol =3D htons(ETH_P_CAN);
>  	skb_reset_network_header(skb);
>  	skb_reset_transport_header(skb);
> =20
> @@ -300,6 +313,10 @@ int can_send(struct sk_buff *skb, int loop)
>  	can_stats.tx_frames_delta++;
> =20
>  	return 0;
> +
> +inval_skb:

dito

> +	kfree_skb(skb);
> +	return err;
>  }
>  EXPORT_SYMBOL(can_send);
> =20
> @@ -632,24 +649,11 @@ static int can_rcv_filter(struct dev_rcv_lists *d=
, struct sk_buff *skb)
>  	return matches;
>  }
> =20
> -static int can_rcv(struct sk_buff *skb, struct net_device *dev,
> -		   struct packet_type *pt, struct net_device *orig_dev)
> +static void can_receive(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct dev_rcv_lists *d;
> -	struct can_frame *cf =3D (struct can_frame *)skb->data;
>  	int matches;
> =20
> -	if (!net_eq(dev_net(dev), &init_net))
> -		goto drop;
> -
> -	if (WARN_ONCE(dev->type !=3D ARPHRD_CAN ||
> -		      skb->len !=3D sizeof(struct can_frame) ||
> -		      cf->can_dlc > 8,
> -		      "PF_CAN: dropped non conform skbuf: "
> -		      "dev type %d, len %d, can_dlc %d\n",
> -		      dev->type, skb->len, cf->can_dlc))
> -		goto drop;
> -
>  	/* update statistics */
>  	can_stats.rx_frames++;
>  	can_stats.rx_frames_delta++;
> @@ -673,7 +677,49 @@ static int can_rcv(struct sk_buff *skb, struct net=
_device *dev,
>  		can_stats.matches++;
>  		can_stats.matches_delta++;
>  	}
> +}
> +
> +static int can_rcv(struct sk_buff *skb, struct net_device *dev,
> +		   struct packet_type *pt, struct net_device *orig_dev)
> +{
> +	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> +
> +	if (!net_eq(dev_net(dev), &init_net))
> +		goto drop;
> =20
> +	if (WARN_ONCE(dev->type !=3D ARPHRD_CAN ||
> +		      skb->len !=3D CAN_MTU ||
> +		      cfd->len > CAN_MAX_DLEN,
> +		      "PF_CAN: dropped non conform CAN skbuf: "
> +		      "dev type %d, len %d, datalen %d\n",
> +		      dev->type, skb->len, cfd->len))
> +		goto drop;
> +
> +	can_receive(skb, dev);
> +	return NET_RX_SUCCESS;
> +
> +drop:
dito
> +	kfree_skb(skb);
> +	return NET_RX_DROP;
> +}
> +
> +static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
> +		   struct packet_type *pt, struct net_device *orig_dev)
> +{
> +	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> +
> +	if (!net_eq(dev_net(dev), &init_net))
> +		goto drop;
> +
> +	if (WARN_ONCE(dev->type !=3D ARPHRD_CAN ||
> +		      skb->len !=3D CANFD_MTU ||
> +		      cfd->len > CANFD_MAX_DLEN,
> +		      "PF_CAN: dropped non conform CAN FD skbuf: "
> +		      "dev type %d, len %d, datalen %d\n",
> +		      dev->type, skb->len, cfd->len))
> +		goto drop;
> +
> +	can_receive(skb, dev);
>  	return NET_RX_SUCCESS;
> =20
>  drop:
> @@ -811,6 +857,12 @@ static struct packet_type can_packet __read_mostly=
 =3D {
>  	.func =3D can_rcv,
>  };
> =20
> +static struct packet_type canfd_packet __read_mostly =3D {
> +	.type =3D cpu_to_be16(ETH_P_CANFD),
> +	.dev  =3D NULL,
> +	.func =3D canfd_rcv,
> +};
> +
>  static const struct net_proto_family can_family_ops =3D {
>  	.family =3D PF_CAN,
>  	.create =3D can_create,
> @@ -824,6 +876,10 @@ static struct notifier_block can_netdev_notifier _=
_read_mostly =3D {
> =20
>  static __init int can_init(void)
>  {
> +	/* check for correct padding that can_dlc owns always the same positi=
on */
> +	BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=3D
> +		     offsetof(struct canfd_frame, len));
> +
>  	printk(banner);
> =20
>  	memset(&can_rx_alldev_list, 0, sizeof(can_rx_alldev_list));
> @@ -846,6 +902,7 @@ static __init int can_init(void)
>  	sock_register(&can_family_ops);
>  	register_netdevice_notifier(&can_netdev_notifier);
>  	dev_add_pack(&can_packet);
> +	dev_add_pack(&canfd_packet);
> =20
>  	return 0;
>  }
> @@ -861,6 +918,7 @@ static __exit void can_exit(void)
> =20
>  	/* protocol unregister */
>  	dev_remove_pack(&can_packet);
> +	dev_remove_pack(&canfd_packet);

nitpick: please keep it symetric, and unregister canfd first.

>  	unregister_netdevice_notifier(&can_netdev_notifier);
>  	sock_unregister(PF_CAN);
> =20
> diff --git a/net/can/raw.c b/net/can/raw.c
> index cde1b4a..dea52da 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -82,6 +82,7 @@ struct raw_sock {
>  	struct notifier_block notifier;
>  	int loopback;
>  	int recv_own_msgs;
> +	int fd_frames;

hmmm: does it make sense to replace these three bool like variables by a
bitfiled or a generic flags varibale?

>  	int count;                 /* number of active filters */
>  	struct can_filter dfilter; /* default/single filter */
>  	struct can_filter *filter; /* pointer to filter(s) */
> @@ -119,6 +120,15 @@ static void raw_rcv(struct sk_buff *oskb, void *da=
ta)
>  	if (!ro->recv_own_msgs && oskb->sk =3D=3D sk)
>  		return;
> =20
> +	/* only pass correct frames to the socket */
> +	if (ro->fd_frames) {
> +		if (oskb->len !=3D CANFD_MTU)
> +			return;
> +	} else {
> +		if (oskb->len !=3D CAN_MTU)
> +			return;
> +	}
> +
>  	/* clone the given skb to be able to enqueue it into the rcv queue */=

>  	skb =3D skb_clone(oskb, GFP_ATOMIC);
>  	if (!skb)
> @@ -291,6 +301,7 @@ static int raw_init(struct sock *sk)
>  	/* set default loopback behaviour */
>  	ro->loopback         =3D 1;
>  	ro->recv_own_msgs    =3D 0;
> +	ro->fd_frames        =3D 0;
> =20
>  	/* set notifier */
>  	ro->notifier.notifier_call =3D raw_notifier;
> @@ -569,6 +580,15 @@ static int raw_setsockopt(struct socket *sock, int=
 level, int optname,
> =20
>  		break;
> =20
> +	case CAN_RAW_FD_FRAMES:
> +		if (optlen !=3D sizeof(ro->fd_frames))
> +			return -EINVAL;
> +
> +		if (copy_from_user(&ro->fd_frames, optval, optlen))
> +			return -EFAULT;
> +
> +		break;
> +
>  	default:
>  		return -ENOPROTOOPT;
>  	}
> @@ -627,6 +647,12 @@ static int raw_getsockopt(struct socket *sock, int=
 level, int optname,
>  		val =3D &ro->recv_own_msgs;
>  		break;
> =20
> +	case CAN_RAW_FD_FRAMES:
> +		if (len > sizeof(int))
> +			len =3D sizeof(int);
> +		val =3D &ro->fd_frames;
> +		break;
> +
>  	default:
>  		return -ENOPROTOOPT;
>  	}
> @@ -662,13 +688,24 @@ static int raw_sendmsg(struct kiocb *iocb, struct=
 socket *sock,
>  	} else
>  		ifindex =3D ro->ifindex;
> =20
> -	if (size !=3D sizeof(struct can_frame))
> -		return -EINVAL;
> +	if (ro->fd_frames) {
> +		if (size !=3D CANFD_MTU)
> +			return -EINVAL;
> +	} else {
> +		if (size !=3D CAN_MTU)
> +			return -EINVAL;
> +	}
> =20
>  	dev =3D dev_get_by_index(&init_net, ifindex);
>  	if (!dev)
>  		return -ENXIO;
> =20
> +	/* make sure the created CAN frame can pass the CAN netdevice */
> +	if (size > dev->mtu) {
> +		err =3D -EMSGSIZE;
> +		goto put_dev;
> +	}
> +
>  	skb =3D sock_alloc_send_skb(sk, size, msg->msg_flags & MSG_DONTWAIT,
>  				  &err);
>  	if (!skb)
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig5CF6DF1EC44F437C10E27842
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+sIG0ACgkQjTAFq1RaXHP2OACfSNcRerXu3u36QEz56siL8i8A
OkIAnj8/C4I4kPlvWaOSlamtI2vmXf/n
=5SY1
-----END PGP SIGNATURE-----

--------------enig5CF6DF1EC44F437C10E27842--
