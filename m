From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Implement ethtool set_phys_id callback to ease locating
 specific physical devices.
Date: Fri, 17 Jun 2016 11:46:26 +0200
Message-ID: <9b9492cc-2776-60f7-ea38-ee29b1955192@pengutronix.de>
References: <1465591162.2164.2.camel@schneidersoft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TxmjpfGaMFANqiHBu1qwW4iOfHXhlI9Nx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42074 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753211AbcFQJqh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 05:46:37 -0400
In-Reply-To: <1465591162.2164.2.camel@schneidersoft.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maximilian Schneider <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TxmjpfGaMFANqiHBu1qwW4iOfHXhlI9Nx
Content-Type: multipart/mixed; boundary="bJ0hBlIu246JPsEBDT4FgcobpLCHosrQb"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maximilian Schneider <max@schneidersoft.net>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <9b9492cc-2776-60f7-ea38-ee29b1955192@pengutronix.de>
Subject: Re: [PATCH] Implement ethtool set_phys_id callback to ease locating
 specific physical devices.
References: <1465591162.2164.2.camel@schneidersoft.net>
In-Reply-To: <1465591162.2164.2.camel@schneidersoft.net>

--bJ0hBlIu246JPsEBDT4FgcobpLCHosrQb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/10/2016 10:39 PM, Maximilian Schneider wrote:
> From a58480fb1c7bb86c11c0d861f3f2997941a84a65 Mon Sep 17 00:00:00 2001
> From: Maximilian Schneider <max@schneidersoft.net>
> Date: Fri, 10 Jun 2016 16:50:16 +0000
> Subject: [PATCH] Implement ethtool set_phys_id callback to ease locatin=
g
>  specific physical devices.
>=20
> currently supported on candleLight interfaces.

Does the LED blink automatically or do you switch it on and off via a
USB msg?

Please move the coding style enhancements into a separate patch.

>=20
> Signed-off-by: Hubert Denkmair <hubert@denkmair.de>
> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
> ---
>  drivers/net/can/usb/gs_usb.c | 140 ++++++++++++++++++++++++++++++-----=
--------
>  1 file changed, 98 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.=
c
> index acb0c84..b6a9fef 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -44,7 +44,9 @@ enum gs_usb_breq {
>  	GS_USB_BREQ_MODE,
>  	GS_USB_BREQ_BERR,
>  	GS_USB_BREQ_BT_CONST,
> -	GS_USB_BREQ_DEVICE_CONFIG
> +	GS_USB_BREQ_DEVICE_CONFIG,
> +	GS_USB_BREQ_TIMESTAMP,
> +	GS_USB_BREQ_IDENTIFY
>  };
> =20
>  enum gs_can_mode {
> @@ -63,6 +65,11 @@ enum gs_can_state {
>  	GS_CAN_STATE_SLEEPING
>  };
> =20
> +enum gs_can_identify_mode {
> +	GS_CAN_IDENTIFY_OFF =3D 0,
> +	GS_CAN_IDENTIFY_ON
> +};
> +
>  /* data types passed between host and device */
>  struct gs_host_config {
>  	u32 byte_order;
> @@ -82,10 +89,10 @@ struct gs_device_config {
>  } __packed;
> =20
>  #define GS_CAN_MODE_NORMAL               0
> -#define GS_CAN_MODE_LISTEN_ONLY          (1<<0)
> -#define GS_CAN_MODE_LOOP_BACK            (1<<1)
> -#define GS_CAN_MODE_TRIPLE_SAMPLE        (1<<2)
> -#define GS_CAN_MODE_ONE_SHOT             (1<<3)
> +#define GS_CAN_MODE_LISTEN_ONLY          BIT(0)
> +#define GS_CAN_MODE_LOOP_BACK            BIT(1)
> +#define GS_CAN_MODE_TRIPLE_SAMPLE        BIT(2)
> +#define GS_CAN_MODE_ONE_SHOT             BIT(3)
> =20
>  struct gs_device_mode {
>  	u32 mode;
> @@ -106,10 +113,16 @@ struct gs_device_bittiming {
>  	u32 brp;
>  } __packed;
> =20
> -#define GS_CAN_FEATURE_LISTEN_ONLY      (1<<0)
> -#define GS_CAN_FEATURE_LOOP_BACK        (1<<1)
> -#define GS_CAN_FEATURE_TRIPLE_SAMPLE    (1<<2)
> -#define GS_CAN_FEATURE_ONE_SHOT         (1<<3)
> +struct gs_identify_mode {
> +	u32 mode;
> +} __packed;
> +
> +#define GS_CAN_FEATURE_LISTEN_ONLY      BIT(0)
> +#define GS_CAN_FEATURE_LOOP_BACK        BIT(1)
> +#define GS_CAN_FEATURE_TRIPLE_SAMPLE    BIT(2)
> +#define GS_CAN_FEATURE_ONE_SHOT         BIT(3)
> +#define GS_CAN_FEATURE_HW_TIMESTAMP     BIT(4)
> +#define GS_CAN_FEATURE_IDENTIFY         BIT(5)
> =20
>  struct gs_device_bt_const {
>  	u32 feature;
> @@ -214,7 +227,8 @@ static void gs_free_tx_context(struct gs_tx_context=
 *txc)
> =20
>  /* Get a tx context by id.
>   */
> -static struct gs_tx_context *gs_get_tx_context(struct gs_can *dev, uns=
igned int id)
> +static struct gs_tx_context *gs_get_tx_context(struct gs_can *dev,
> +					       unsigned int id)
>  {
>  	unsigned long flags;
> =20
> @@ -457,7 +471,8 @@ static void gs_usb_xmit_callback(struct urb *urb)
>  		netif_wake_queue(netdev);
>  }
> =20
> -static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb, struct net_d=
evice *netdev)
> +static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
> +				     struct net_device *netdev)
>  {
>  	struct gs_can *dev =3D netdev_priv(netdev);
>  	struct net_device_stats *stats =3D &dev->netdev->stats;
> @@ -661,9 +676,12 @@ static int gs_can_open(struct net_device *netdev)
>  	/* finally start device */
>  	dm->mode =3D GS_CAN_MODE_START;
>  	rc =3D usb_control_msg(interface_to_usbdev(dev->iface),
> -			     usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
> +			     usb_sndctrlpipe(interface_to_usbdev(dev->iface),
> +					     0),
>  			     GS_USB_BREQ_MODE,
> -			     USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			     USB_DIR_OUT |
> +			     USB_TYPE_VENDOR |
> +			     USB_RECIP_INTERFACE,
>  			     dev->channel,
>  			     0,
>  			     dm,
> @@ -726,7 +744,56 @@ static const struct net_device_ops gs_usb_netdev_o=
ps =3D {
>  	.ndo_change_mtu =3D can_change_mtu,
>  };
> =20
> -static struct gs_can *gs_make_candev(unsigned int channel, struct usb_=
interface *intf)
> +static int gs_usb_set_identify(struct net_device *netdev, bool do_iden=
tify)
> +{
> +	int rc;
> +	struct gs_identify_mode imode;
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +
> +	imode.mode =3D do_identify ? GS_CAN_IDENTIFY_ON : GS_CAN_IDENTIFY_OFF=
;
> +	rc =3D usb_control_msg(interface_to_usbdev(dev->iface),
> +			     usb_sndctrlpipe(interface_to_usbdev(dev->iface),
> +					     0),
> +			     GS_USB_BREQ_IDENTIFY,
> +			     USB_DIR_OUT |
> +			     USB_TYPE_VENDOR |
> +			     USB_RECIP_INTERFACE,
> +			     dev->channel,
> +			     0,
> +			     &imode,
> +			     sizeof(imode),
> +			     100);
> +
> +	return (rc > 0) ? 0 : -1;

please return a proper error value here. What about:

    return (rc > 0) ? 0 : rc;

> +}
> +
> +/* blink LED's for finding the this interface */
> +static int gs_usb_set_phys_id(struct net_device *dev,
> +			      enum ethtool_phys_id_state state)
> +{
> +	int rv =3D 0;

nitpick please use "int rc" as the rest of the driver does.

> +
> +	switch (state) {
> +	case ETHTOOL_ID_ACTIVE:
> +		rv =3D gs_usb_set_identify(dev, GS_CAN_IDENTIFY_ON);
> +		break;
> +	case ETHTOOL_ID_INACTIVE:
> +		rv =3D gs_usb_set_identify(dev, GS_CAN_IDENTIFY_OFF);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return rv;
> +}
> +
> +static const struct ethtool_ops gs_usb_ethtool_ops =3D {
> +	.set_phys_id =3D gs_usb_set_phys_id,
> +};
> +
> +static struct gs_can *gs_make_candev(unsigned int channel,
> +				     struct usb_interface *intf,
> +				     struct gs_device_config *dconf)
>  {
>  	struct gs_can *dev;
>  	struct net_device *netdev;
> @@ -814,10 +881,14 @@ static struct gs_can *gs_make_candev(unsigned int=
 channel, struct usb_interface
>  	if (bt_const->feature & GS_CAN_FEATURE_ONE_SHOT)
>  		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_ONE_SHOT;
> =20
> -	kfree(bt_const);
> -
>  	SET_NETDEV_DEV(netdev, &intf->dev);
> =20
> +	if (dconf->sw_version > 1)
> +		if (bt_const->feature & GS_CAN_FEATURE_IDENTIFY)
> +			netdev->ethtool_ops =3D &gs_usb_ethtool_ops;
> +
> +	kfree(bt_const);
> +
>  	rc =3D register_candev(dev->netdev);
>  	if (rc) {
>  		free_candev(dev->netdev);
> @@ -835,19 +906,16 @@ static void gs_destroy_candev(struct gs_can *dev)=

>  	free_candev(dev->netdev);
>  }
> =20
> -static int gs_usb_probe(struct usb_interface *intf, const struct usb_d=
evice_id *id)
> +static int gs_usb_probe(struct usb_interface *intf,
> +			const struct usb_device_id *id)
>  {
>  	struct gs_usb *dev;
>  	int rc =3D -ENOMEM;
>  	unsigned int icount, i;
> -	struct gs_host_config *hconf;
> -	struct gs_device_config *dconf;
> -
> -	hconf =3D kmalloc(sizeof(*hconf), GFP_KERNEL);
> -	if (!hconf)
> -		return -ENOMEM;
> +	struct gs_host_config hconf;
> +	struct gs_device_config dconf;
> =20
> -	hconf->byte_order =3D 0x0000beef;
> +	hconf.byte_order =3D 0x0000beef;
> =20
>  	/* send host config */
>  	rc =3D usb_control_msg(interface_to_usbdev(intf),
> @@ -856,22 +924,16 @@ static int gs_usb_probe(struct usb_interface *int=
f, const struct usb_device_id *
>  			     USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
>  			     1,
>  			     intf->altsetting[0].desc.bInterfaceNumber,
> -			     hconf,
> -			     sizeof(*hconf),
> +			     &hconf,
> +			     sizeof(hconf),
>  			     1000);
> =20
> -	kfree(hconf);
> -
>  	if (rc < 0) {
>  		dev_err(&intf->dev, "Couldn't send data format (err=3D%d)\n",
>  			rc);
>  		return rc;
>  	}
> =20
> -	dconf =3D kmalloc(sizeof(*dconf), GFP_KERNEL);
> -	if (!dconf)
> -		return -ENOMEM;
> -
>  	/* read device config */
>  	rc =3D usb_control_msg(interface_to_usbdev(intf),
>  			     usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
> @@ -879,22 +941,16 @@ static int gs_usb_probe(struct usb_interface *int=
f, const struct usb_device_id *
>  			     USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
>  			     1,
>  			     intf->altsetting[0].desc.bInterfaceNumber,
> -			     dconf,
> -			     sizeof(*dconf),
> +			     &dconf,
> +			     sizeof(dconf),
>  			     1000);
>  	if (rc < 0) {
>  		dev_err(&intf->dev, "Couldn't get device config: (err=3D%d)\n",
>  			rc);
> -
> -		kfree(dconf);
> -
>  		return rc;
>  	}
> =20
> -	icount =3D dconf->icount+1;
> -
> -	kfree(dconf);
> -
> +	icount =3D dconf.icount + 1;
>  	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
> =20
>  	if (icount > GS_MAX_INTF) {
> @@ -915,7 +971,7 @@ static int gs_usb_probe(struct usb_interface *intf,=
 const struct usb_device_id *
>  	dev->udev =3D interface_to_usbdev(intf);
> =20
>  	for (i =3D 0; i < icount; i++) {
> -		dev->canch[i] =3D gs_make_candev(i, intf);
> +		dev->canch[i] =3D gs_make_candev(i, intf, &dconf);
>  		if (IS_ERR_OR_NULL(dev->canch[i])) {
>  			/* save error code to return later */
>  			rc =3D PTR_ERR(dev->canch[i]);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bJ0hBlIu246JPsEBDT4FgcobpLCHosrQb--

--TxmjpfGaMFANqiHBu1qwW4iOfHXhlI9Nx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY8bzAAoJED07qiWsqSVqT9UIAKJr4O3h/QhY9uAPd3us9XUY
6e+KY+gAvXOGXpPmGo54H33z0azOFDcLGcr3VKztI0M3m+ZHVricg6WHiDefuud0
KmONf7YyL5xWd0yS77lTJqj6R1rL77ZYE/EnXfjV+x4fNFUsqae8kPcg66R/jW/G
H9lYmeR5/vrtDAHtpaGUieD5gvG7prtcsLBfE72/3MxxIPCqt4Zk4+MfNPVLe5DT
NFENaPvHDiA4Zc9z1j3ptJHmndFwUgZe6SAZf+HIXI7w9gTcYalA7CXcdOq8bj84
9c3OZ8Lte6KsF+16cVKz3ZASAsp0oYvImie9N7MsPvF9qAaTsnPEmWh3uC+fl1M=
=QtQu
-----END PGP SIGNATURE-----

--TxmjpfGaMFANqiHBu1qwW4iOfHXhlI9Nx--
