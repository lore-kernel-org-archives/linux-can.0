From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/5] can: slcan: Convert to can_dev interface
Date: Thu, 17 Apr 2014 21:10:35 +0200
Message-ID: <5350272B.70703@pengutronix.de>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com> <1397573468-7619-3-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Rh7Hakre1UHOTvXSngf2pUVxSo8Uf8alX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38246 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbaDQTKl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 15:10:41 -0400
In-Reply-To: <1397573468-7619-3-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rh7Hakre1UHOTvXSngf2pUVxSo8Uf8alX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/15/2014 04:51 PM, Alexander Stein wrote:
> No actual feature change despite the interface name. This is just a
> preparation for additional CAN related features.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/net/can/Kconfig |  40 +++++++++----------
>  drivers/net/can/slcan.c | 104 +++++++++++++++++++++-------------------=
--------
>  2 files changed, 65 insertions(+), 79 deletions(-)
>=20
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index 9e7d95d..daea043 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -9,26 +9,6 @@ config CAN_VCAN
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called vcan.
> =20
> -config CAN_SLCAN
> -	tristate "Serial / USB serial CAN Adaptors (slcan)"
> -	depends on TTY
> -	---help---
> -	  CAN driver for several 'low cost' CAN interfaces that are attached
> -	  via serial lines or via USB-to-serial adapters using the LAWICEL
> -	  ASCII protocol. The driver implements the tty linediscipline N_SLCA=
N.
> -
> -	  As only the sending and receiving of CAN frames is implemented, thi=
s
> -	  driver should work with the (serial/USB) CAN hardware from:
> -	  www.canusb.com / www.can232.com / www.mictronics.de / www.canhack.d=
e
> -
> -	  Userspace tools to attach the SLCAN line discipline (slcan_attach,
> -	  slcand) can be found in the can-utils at the SocketCAN SVN, see
> -	  http://developer.berlios.de/projects/socketcan for details.
> -
> -	  The slcan driver supports up to 10 CAN netdevices by default which
> -	  can be changed by the 'maxdev=3Dxx' module option. This driver can
> -	  also be built as a module. If so, the module will be called slcan.
> -
>  config CAN_DEV
>  	tristate "Platform CAN drivers with Netlink support"
>  	default y
> @@ -125,6 +105,26 @@ config CAN_GRCAN
>  	  endian syntheses of the cores would need some modifications on
>  	  the hardware level to work.
> =20
> +config CAN_SLCAN
> +	tristate "Serial / USB serial CAN Adaptors (slcan)"
> +	depends on TTY
> +	---help---
> +	  CAN driver for several 'low cost' CAN interfaces that are attached
> +	  via serial lines or via USB-to-serial adapters using the LAWICEL
> +	  ASCII protocol. The driver implements the tty linediscipline N_SLCA=
N.
> +
> +	  As only the sending and receiving of CAN frames is implemented, thi=
s
> +	  driver should work with the (serial/USB) CAN hardware from:
> +	  www.canusb.com / www.can232.com / www.mictronics.de / www.canhack.d=
e
> +
> +	  Userspace tools to attach the SLCAN line discipline (slcan_attach,
> +	  slcand) can be found in the can-utils at the SocketCAN SVN, see
> +	  http://developer.berlios.de/projects/socketcan for details.
> +
> +	  The slcan driver supports up to 10 CAN netdevices by default which
> +	  can be changed by the 'maxdev=3Dxx' module option. This driver can
> +	  also be built as a module. If so, the module will be called slcan.
> +
>  source "drivers/net/can/mscan/Kconfig"
> =20
>  source "drivers/net/can/sja1000/Kconfig"
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index 2577c1e..337e6e3 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -53,6 +53,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/can.h>
> +#include <linux/can/dev.h>
>  #include <linux/can/skb.h>
> =20
>  static __initconst const char banner[] =3D
> @@ -79,6 +80,7 @@ MODULE_PARM_DESC(maxdev, "Maximum number of slcan int=
erfaces");
>  #define SLC_EFF_ID_LEN 8
> =20
>  struct slcan {
> +	struct can_priv		can;	/* must be the first member */
>  	int			magic;
> =20
>  	/* Various fields. */
> @@ -99,6 +101,7 @@ struct slcan {
>  };
> =20
>  static struct net_device **slcan_devs;
> +static DEFINE_MUTEX(slcan_mutex);
> =20
>   /********************************************************************=
****
>    *			SLCAN ENCAPSULATION FORMAT			 *
> @@ -143,31 +146,33 @@ static struct net_device **slcan_devs;
>  static void slc_bump(struct slcan *sl)
>  {
>  	struct sk_buff *skb;
> -	struct can_frame cf;
> +	struct can_frame *cf;
> +	canid_t can_id;
> +	u8 can_dlc;
>  	int i, tmp;
>  	u32 tmpid;
>  	char *cmd =3D sl->rbuff;
> =20
> -	cf.can_id =3D 0;
> +	can_id =3D 0;
> =20
>  	switch (*cmd) {
>  	case 'r':
> -		cf.can_id =3D CAN_RTR_FLAG;
> +		can_id =3D CAN_RTR_FLAG;
>  		/* fallthrough */
>  	case 't':
>  		/* store dlc ASCII value and terminate SFF CAN ID string */
> -		cf.can_dlc =3D sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN];
> +		can_dlc =3D sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN];
>  		sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN] =3D 0;
>  		/* point to payload data behind the dlc */
>  		cmd +=3D SLC_CMD_LEN + SLC_SFF_ID_LEN + 1;
>  		break;
>  	case 'R':
> -		cf.can_id =3D CAN_RTR_FLAG;
> +		can_id =3D CAN_RTR_FLAG;
>  		/* fallthrough */
>  	case 'T':
> -		cf.can_id |=3D CAN_EFF_FLAG;
> +		can_id |=3D CAN_EFF_FLAG;
>  		/* store dlc ASCII value and terminate EFF CAN ID string */
> -		cf.can_dlc =3D sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN];
> +		can_dlc =3D sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN];
>  		sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN] =3D 0;
>  		/* point to payload data behind the dlc */
>  		cmd +=3D SLC_CMD_LEN + SLC_EFF_ID_LEN + 1;
> @@ -179,49 +184,39 @@ static void slc_bump(struct slcan *sl)
>  	if (kstrtou32(sl->rbuff + SLC_CMD_LEN, 16, &tmpid))
>  		return;
> =20
> -	cf.can_id |=3D tmpid;
> +	can_id |=3D tmpid;
> =20
>  	/* get can_dlc from sanitized ASCII value */
> -	if (cf.can_dlc >=3D '0' && cf.can_dlc < '9')
> -		cf.can_dlc -=3D '0';
> +	if (can_dlc >=3D '0' && can_dlc < '9')
> +		can_dlc -=3D '0';
>  	else
>  		return;
> =20
> -	*(u64 *) (&cf.data) =3D 0; /* clear payload */
> +	skb =3D alloc_can_skb(sl->dev, &cf);
> +	if (!skb)
> +		return;
> +	cf->can_id =3D can_id;
> +	cf->can_dlc =3D can_dlc;
> =20
>  	/* RTR frames may have a dlc > 0 but they never have any data bytes *=
/
> -	if (!(cf.can_id & CAN_RTR_FLAG)) {
> -		for (i =3D 0; i < cf.can_dlc; i++) {
> +	if (!(cf->can_id & CAN_RTR_FLAG)) {
> +		for (i =3D 0; i < cf->can_dlc; i++) {
>  			tmp =3D hex_to_bin(*cmd++);
>  			if (tmp < 0)
>  				return;
> -			cf.data[i] =3D (tmp << 4);
> +			cf->data[i] =3D (tmp << 4);
>  			tmp =3D hex_to_bin(*cmd++);
>  			if (tmp < 0)
>  				return;
> -			cf.data[i] |=3D tmp;
> +			cf->data[i] |=3D tmp;
>  		}
>  	}
> -
> -	skb =3D dev_alloc_skb(sizeof(struct can_frame) +
> -			    sizeof(struct can_skb_priv));
> -	if (!skb)
> -		return;
> -
>  	skb->dev =3D sl->dev;

I think this is not needed anymore, as alloc_can_skb() sets this already.=


> -	skb->protocol =3D htons(ETH_P_CAN);
> -	skb->pkt_type =3D PACKET_BROADCAST;
> -	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> -
> -	can_skb_reserve(skb);
> -	can_skb_prv(skb)->ifindex =3D sl->dev->ifindex;
> =20
> -	memcpy(skb_put(skb, sizeof(struct can_frame)),
> -	       &cf, sizeof(struct can_frame));
>  	netif_rx_ni(skb);
> =20
>  	sl->dev->stats.rx_packets++;
> -	sl->dev->stats.rx_bytes +=3D cf.can_dlc;
> +	sl->dev->stats.rx_bytes +=3D cf->can_dlc;

Please don't touch the skb (and this cf) after netif_rx_ni

>  }
> =20
>  /* parse tty input stream */
> @@ -385,6 +380,10 @@ static int slc_close(struct net_device *dev)
>  	netif_stop_queue(dev);
>  	sl->rcount   =3D 0;
>  	sl->xleft    =3D 0;
> +	sl->can.state =3D CAN_STATE_STOPPED;
> +
> +	close_candev(dev);
> +
>  	spin_unlock_bh(&sl->lock);
> =20
>  	return 0;
> @@ -394,12 +393,19 @@ static int slc_close(struct net_device *dev)
>  static int slc_open(struct net_device *dev)
>  {
>  	struct slcan *sl =3D netdev_priv(dev);
> +	int err;
> =20
>  	if (sl->tty =3D=3D NULL)
>  		return -ENODEV;
> =20
> +	err =3D open_candev(dev);
> +	if (err)
> +		return err;
> +
> +	sl->can.state =3D CAN_STATE_ERROR_ACTIVE;
>  	sl->flags &=3D (1 << SLF_INUSE);
>  	netif_start_queue(dev);
> +
>  	return 0;
>  }
> =20
> @@ -407,7 +413,7 @@ static int slc_open(struct net_device *dev)
>  static void slc_free_netdev(struct net_device *dev)
>  {
>  	int i =3D dev->base_addr;
> -	free_netdev(dev);
> +	free_candev(dev);
>  	slcan_devs[i] =3D NULL;
>  }
> =20
> @@ -417,23 +423,6 @@ static const struct net_device_ops slc_netdev_ops =
=3D {
>  	.ndo_start_xmit         =3D slc_xmit,
>  };
> =20
> -static void slc_setup(struct net_device *dev)
> -{
> -	dev->netdev_ops		=3D &slc_netdev_ops;
> -	dev->destructor		=3D slc_free_netdev;
> -
> -	dev->hard_header_len	=3D 0;
> -	dev->addr_len		=3D 0;
> -	dev->tx_queue_len	=3D 10;
> -
> -	dev->mtu		=3D sizeof(struct can_frame);
> -	dev->type		=3D ARPHRD_CAN;
> -
> -	/* New-style flags. */
> -	dev->flags		=3D IFF_NOARP;
> -	dev->features           =3D NETIF_F_HW_CSUM;
> -}
> -
>  /******************************************
>    Routines looking at TTY side.
>   ******************************************/
> @@ -495,7 +484,6 @@ static void slc_sync(void)
>  static struct slcan *slc_alloc(dev_t line)
>  {
>  	int i;
> -	char name[IFNAMSIZ];
>  	struct net_device *dev =3D NULL;
>  	struct slcan       *sl;
> =20
> @@ -510,12 +498,13 @@ static struct slcan *slc_alloc(dev_t line)
>  	if (i >=3D maxdev)
>  		return NULL;
> =20
> -	sprintf(name, "slcan%d", i);
> -	dev =3D alloc_netdev(sizeof(*sl), name, slc_setup);
> +	dev =3D alloc_candev(sizeof(*sl), 1);
>  	if (!dev)
>  		return NULL;
> =20
>  	dev->base_addr  =3D i;
> +	dev->netdev_ops =3D &slc_netdev_ops;
> +	dev->destructor =3D slc_free_netdev;
>  	sl =3D netdev_priv(dev);
> =20
>  	/* Initialize channel control data */
> @@ -548,11 +537,8 @@ static int slcan_open(struct tty_struct *tty)
>  	if (tty->ops->write =3D=3D NULL)
>  		return -EOPNOTSUPP;
> =20
> -	/* RTnetlink lock is misused here to serialize concurrent
> -	   opens of slcan channels. There are better ways, but it is
> -	   the simplest one.
> -	 */
> -	rtnl_lock();
> +	/* Serialize concurrent opens of slcan channels. */
> +	mutex_lock(&slcan_mutex);
> =20
>  	/* Collect hanged up channels. */
>  	slc_sync();
> @@ -580,13 +566,13 @@ static int slcan_open(struct tty_struct *tty)
> =20
>  		set_bit(SLF_INUSE, &sl->flags);
> =20
> -		err =3D register_netdevice(sl->dev);
> +		err =3D register_candev(sl->dev);
>  		if (err)
>  			goto err_free_chan;
>  	}
> =20
>  	/* Done.  We have linked the TTY line to a channel. */
> -	rtnl_unlock();
> +	mutex_unlock(&slcan_mutex);
>  	tty->receive_room =3D 65536;	/* We don't flow control */
> =20
>  	/* TTY layer expects 0 on success */
> @@ -598,7 +584,7 @@ err_free_chan:
>  	clear_bit(SLF_INUSE, &sl->flags);
> =20
>  err_exit:
> -	rtnl_unlock();
> +	mutex_unlock(&slcan_mutex);
> =20
>  	/* Count references from TTY module */
>  	return err;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Rh7Hakre1UHOTvXSngf2pUVxSo8Uf8alX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQJysACgkQjTAFq1RaXHPkVACdFAFyyyLB0mWOaKT7YYkhyDB9
3BQAniLi+PK9k4/bPbvcZKbeD8EIRAcb
=Ume5
-----END PGP SIGNATURE-----

--Rh7Hakre1UHOTvXSngf2pUVxSo8Uf8alX--
