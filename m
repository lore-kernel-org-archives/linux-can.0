From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_usb: upgrade core to new CANFD extension
Date: Tue, 20 Jan 2015 15:17:45 +0100
Message-ID: <54BE6389.6040007@pengutronix.de>
References: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="nlGb6evNJqf9GvjoiA1mVa3i6kEPrbXod"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53302 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbATOR5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:17:57 -0500
In-Reply-To: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nlGb6evNJqf9GvjoiA1mVa3i6kEPrbXod
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2015 05:15 PM, Stephane Grosjean wrote:
> Upgrade PEAK-System USB adapters core to the new data structures (names=
)
> and callbacks added for the support of the CANFD extension.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 59 ++++++++++++++++++++=
++++----
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  9 ++++-
>  2 files changed, 58 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.c
> index c62f48a..be267af 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -165,6 +165,21 @@ void peak_usb_get_ts_tv(struct peak_time_ref *time=
_ref, u32 ts,
>  }
> =20
>  /*
> + * post received skb after having set any hw timestamp
> + */
> +int peak_usb_netif_rx(struct sk_buff *skb,
> +		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high)
> +{

Why do we have this function? It's only used in pcan_usb_fd.c.
I've moved it into a seperate patch.

> +	struct skb_shared_hwtstamps *hwts =3D skb_hwtstamps(skb);
> +	struct timeval tv;
> +
> +	peak_usb_get_ts_tv(time_ref, ts_low, &tv);
> +	hwts->hwtstamp =3D timeval_to_ktime(tv);
> +
> +	return netif_rx(skb);
> +}
> +
> +/*
>   * callback for bulk Rx urb
>   */
>  static void peak_usb_read_bulk_callback(struct urb *urb)
> @@ -253,7 +268,7 @@ static void peak_usb_write_bulk_callback(struct urb=
 *urb)
>  	case 0:
>  		/* transmission complete */
>  		netdev->stats.tx_packets++;
> -		netdev->stats.tx_bytes +=3D context->dlc;
> +		netdev->stats.tx_bytes +=3D context->data_len;
> =20
>  		/* prevent tx timeout */
>  		netdev->trans_start =3D jiffies;
> @@ -289,7 +304,7 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct s=
k_buff *skb,
>  	struct peak_usb_device *dev =3D netdev_priv(netdev);
>  	struct peak_tx_urb_context *context =3D NULL;
>  	struct net_device_stats *stats =3D &netdev->stats;
> -	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
>  	struct urb *urb;
>  	u8 *obuf;
>  	int i, err;
> @@ -322,7 +337,9 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct s=
k_buff *skb,
>  	}
> =20
>  	context->echo_index =3D i;
> -	context->dlc =3D cf->can_dlc;
> +
> +	/* Note: this works with CANFD frames too */
> +	context->data_len =3D cfd->len;
> =20
>  	usb_anchor_urb(urb, &dev->tx_submitted);
> =20
> @@ -679,19 +696,43 @@ static int peak_usb_set_mode(struct net_device *n=
etdev, enum can_mode mode)
>  }
> =20
>  /*
> - * candev callback used to set device bitrate.
> + * candev callback used to set device nominal/arbitration bitrate.
>   */
>  static int peak_usb_set_bittiming(struct net_device *netdev)
>  {
>  	struct peak_usb_device *dev =3D netdev_priv(netdev);
> -	struct can_bittiming *bt =3D &dev->can.bittiming;
> +	struct peak_usb_adapter *pa =3D dev->adapter;
> =20
> -	if (dev->adapter->dev_set_bittiming) {
> -		int err =3D dev->adapter->dev_set_bittiming(dev, bt);
> +	if (pa->dev_set_bittiming) {
> +		struct can_bittiming *bt =3D &dev->can.bittiming;
> +		int err =3D pa->dev_set_bittiming(dev, bt);
> =20
>  		if (err)
>  			netdev_info(netdev, "couldn't set bitrate (err %d)\n",
> -				err);
> +				    err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * candev callback used to set device data bitrate.
> + */
> +static int peak_usb_set_data_bittiming(struct net_device *netdev)
> +{
> +	struct peak_usb_device *dev =3D netdev_priv(netdev);
> +	struct peak_usb_adapter *pa =3D dev->adapter;
> +
> +	if (pa->dev_set_data_bittiming) {
> +		struct can_bittiming *bt =3D &dev->can.data_bittiming;
> +		int err =3D pa->dev_set_data_bittiming(dev, bt);
> +
> +		if (err)
> +			netdev_info(netdev,
> +				    "couldn't set data bitrate (err %d)\n",
> +				    err);
> +
>  		return err;
>  	}

I've moved the bittiming changes into a seperate patch.

> =20
> @@ -750,6 +791,8 @@ static int peak_usb_create_dev(struct peak_usb_adap=
ter *peak_usb_adapter,
>  	dev->can.clock =3D peak_usb_adapter->clock;
>  	dev->can.bittiming_const =3D &peak_usb_adapter->bittiming_const;
>  	dev->can.do_set_bittiming =3D peak_usb_set_bittiming;
> +	dev->can.data_bittiming_const =3D &peak_usb_adapter->data_bittiming_c=
onst;
> +	dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
>  	dev->can.do_set_mode =3D peak_usb_set_mode;
>  	dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
>  				      CAN_CTRLMODE_LISTENONLY;
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.h
> index 073b47f..928012f 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> @@ -46,6 +46,7 @@ struct peak_usb_adapter {
>  	u32 device_id;
>  	struct can_clock clock;
>  	const struct can_bittiming_const bittiming_const;
> +	const struct can_bittiming_const data_bittiming_const;
>  	unsigned int ctrl_count;
> =20
>  	int (*intf_probe)(struct usb_interface *intf);
> @@ -57,6 +58,8 @@ struct peak_usb_adapter {
>  	int (*dev_close)(struct peak_usb_device *dev);
>  	int (*dev_set_bittiming)(struct peak_usb_device *dev,
>  					struct can_bittiming *bt);
> +	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
> +				      struct can_bittiming *bt);
>  	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
>  	int (*dev_get_device_id)(struct peak_usb_device *dev, u32 *device_id)=
;
>  	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
> @@ -92,7 +95,7 @@ struct peak_time_ref {
>  struct peak_tx_urb_context {
>  	struct peak_usb_device *dev;
>  	u32 echo_index;
> -	u8 dlc;
> +	u8 data_len;
>  	struct urb *urb;
>  };
> =20
> @@ -139,7 +142,9 @@ void peak_usb_update_ts_now(struct peak_time_ref *t=
ime_ref, u32 ts_now);
>  void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
>  void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
>  			struct timeval *tv);
> -
> +int peak_usb_netif_rx(struct sk_buff *skb,
> +		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high);
>  void peak_usb_async_complete(struct urb *urb);
>  void peak_usb_restart_complete(struct peak_usb_device *dev);
> +
>  #endif
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nlGb6evNJqf9GvjoiA1mVa3i6kEPrbXod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUvmORAAoJECte4hHFiupUiuEP/1gQBIRwS6c03pBz/GrAttUm
ISweCj07BDo5GO2KEEhWJLHkQS7TzFp/A8snvTvZkxo33GufCA5ZXQ/m3uPb5S3X
YsWZjv6b7wMZ9DsfqTrqk+nFvy4cp5bH+XaGEwSpbS4CjwG2H5bVl4qdbqFyWKX5
v0X8eo5rbkLGj+9OElJmia6XjEAbjEQgerCzlXctRvkX4PvPUzwPlrFY69U79wDH
9uXBkMDCOzE4D6rjdkMu/ASF8glRNI0WlvfYRJ6rI7xOrRF4UHqDZEec0RTNMIV7
Ou5Bd9lPOWHZy5UDTAFjrGzFi+cv395lgCX+KveuK+B0PDtXItO+n3k7GUUw4bsb
X4gsArSRk+gRQBflzyvb/v333K0aOAX3Ar8uhQOLtK+QfhVFTbMKGGG6oCNIN7Py
jQdNxznqz4S0EyAWixHF1IziCY0d4GXQK7SML3ruea282PcGRo+GUv/dxlyI91M8
gTt421UC6HmmmWTuYGyGRKorsu5KOhYDXD5y5GoLKG/woIankHEPT+MEe/l0sF/b
HnQD9BkNant3PIpB3emTRm1qBQzfSJc5abCXj3BeUMeQXiXFviBMrRee32dEbUB6
oACSQiNvS6wL9ugC6SO5JFLDRIjP2mmFuUSp2ck/29Tm5H4Fd+lG7QyhqgQJFrzR
OZrUxNGJwNZBgQP9MCD1
=pvy5
-----END PGP SIGNATURE-----

--nlGb6evNJqf9GvjoiA1mVa3i6kEPrbXod--
