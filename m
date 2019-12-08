From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ensure an initialized headroom in outgoing CAN
 sk_buffs
Date: Sun, 8 Dec 2019 11:48:14 +0100
Message-ID: <cc102c3b-d9d3-6447-7581-a36795259cc2@pengutronix.de>
References: <20191207183418.28868-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="sPZNIYWNvq8CiKiMEosT6oyoeWVyH2LXo"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191207183418.28868-1-socketcan@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, dvyukov@google.com
Cc: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com, glider@google.com, syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org, o.rempel@pengutronix.de, eric.dumazet@gmail.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sPZNIYWNvq8CiKiMEosT6oyoeWVyH2LXo
Content-Type: multipart/mixed; boundary="R0Hs5YjYhTQdBp8AtdaEg1JaEOCSSqjQk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 dvyukov@google.com
Cc: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com, glider@google.com,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org,
 o.rempel@pengutronix.de, eric.dumazet@gmail.com
Message-ID: <cc102c3b-d9d3-6447-7581-a36795259cc2@pengutronix.de>
Subject: Re: [PATCH] can: ensure an initialized headroom in outgoing CAN
 sk_buffs
References: <20191207183418.28868-1-socketcan@hartkopp.net>
In-Reply-To: <20191207183418.28868-1-socketcan@hartkopp.net>

--R0Hs5YjYhTQdBp8AtdaEg1JaEOCSSqjQk
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/7/19 7:34 PM, Oliver Hartkopp wrote:
> KMSAN sysbot detected a read access to an untinitialized value in the h=
eadroom
> of an outgoing CAN related sk_buff. When using CAN sockets this area is=
 filled
> appropriately - but when using a packet socket this initialization is m=
issing.
>=20
> The problematic read access occurs in the CAN receive path which can on=
ly be
> triggered when the sk_buff is sent through a (virtual) CAN interface. S=
o we
> check in the sending path whether we need to perform the missing
> initializations.
>=20
> Fixes: d3b58c47d330d ("can: replace timestamp as unique skb attribute")=

> Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can/dev.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 9b3c720a31b1..8f86e7a1f8e9 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -18,6 +18,7 @@
>  #include <linux/can/error.h>
>  #include <linux/can/led.h>
>  #include <linux/can/netlink.h>
> +#include <linux/can/skb.h>
>  #include <linux/netdevice.h>
> =20
>  /*
> @@ -91,6 +92,37 @@ struct can_priv {
>  #define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
>  #define get_canfd_dlc(i)	(min_t(__u8, (i), CANFD_MAX_DLC))
> =20
> +/* Check for outgoing skbs that have not been created by the CAN subsy=
stem */
> +static inline bool can_check_skb_headroom(struct net_device *dev,
> +					  struct sk_buff *skb)

Do we want to have such a big function as a static inline?

> +{
> +	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */=

> +	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
> +		return true;
> +
> +	/* af_packet does not apply CAN skb specific settings */
> +	if (skb->ip_summed =3D=3D CHECKSUM_NONE) {

Is it possible to set the ip_summed via the packet socket or is it
always 0 (=3D=3D CHECKSUM_NONE)?

> +

Please remove that empty line.

> +		/* init headroom */
> +		can_skb_prv(skb)->ifindex =3D dev->ifindex;
> +		can_skb_prv(skb)->skbcnt =3D 0;
> +
> +		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +
> +		/* preform proper loopback on capable devices */
> +		if (dev->flags & IFF_ECHO)
> +			skb->pkt_type =3D PACKET_LOOPBACK;
> +		else
> +			skb->pkt_type =3D PACKET_HOST;
> +
> +		skb_reset_mac_header(skb);
> +		skb_reset_network_header(skb);
> +		skb_reset_transport_header(skb);
> +	}
> +
> +	return false;
> +}
> +
>  /* Drop a given socketbuffer if it does not contain a valid CAN frame.=
 */
>  static inline bool can_dropped_invalid_skb(struct net_device *dev,
>  					  struct sk_buff *skb)
> @@ -108,6 +140,9 @@ static inline bool can_dropped_invalid_skb(struct n=
et_device *dev,
>  	} else
>  		goto inval_skb;
> =20
> +	if (can_check_skb_headroom(dev, skb))

Can you rename the function, so that it's clear that returning false
means it's an invalid skb?

> +		goto inval_skb;
> +
>  	return false;
> =20
>  inval_skb:
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--R0Hs5YjYhTQdBp8AtdaEg1JaEOCSSqjQk--

--sPZNIYWNvq8CiKiMEosT6oyoeWVyH2LXo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3s1PEACgkQWsYho5Hk
nSCKdAf/bjw9kubsVxu3iOzE16IWBVIZOJwWSBrP2fdB8BbQtFKsxJJaqWVqbTIe
TIILQbIkLy+W0KZGSPvBCc7ECHP/cP61vrwbwNE15Twt5y/m2idB6Aq3n0l4olRt
hzVLPDnw9lVuiEF4k6F9W7Zo8nscl/RGp/PaeaFjILptg4utjmiH6rP7UdlXu2kT
5zx1sqDnxPfCHYhIaIi0ix1nWFuwQekF9Iv80cVMqbuf9tpPHNZ/rg8q4LStEaRG
1z/dqKF20OgZ/dKHulWsNbBQwcHdcBf2akLeqBR7uiynK/gVYRjrth9fDtMgbYNh
DVuR87FtHtpmrP4EkXlIEHQeYL8gCQ==
=TZxU
-----END PGP SIGNATURE-----

--sPZNIYWNvq8CiKiMEosT6oyoeWVyH2LXo--
