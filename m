From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: kvaser_usb: Expose EAN and serial number via
 sysfs
Date: Fri, 16 Feb 2018 11:38:05 +0100
Message-ID: <dca8530d-71fb-ea0c-6e84-d21c26587227@pengutronix.de>
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
 <20180216091337.13924-2-jimmyassarsson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ByZ7L0AD2XnccjfuFTrrxgecZNJMzMBLf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43015 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933559AbeBPKiw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 05:38:52 -0500
In-Reply-To: <20180216091337.13924-2-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ByZ7L0AD2XnccjfuFTrrxgecZNJMzMBLf
Content-Type: multipart/mixed; boundary="FfqW2oDqxzMP9fUY8RFEw9vuvk3KBVRPI";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org
Message-ID: <dca8530d-71fb-ea0c-6e84-d21c26587227@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: kvaser_usb: Expose EAN and serial number via
 sysfs
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
 <20180216091337.13924-2-jimmyassarsson@gmail.com>
In-Reply-To: <20180216091337.13924-2-jimmyassarsson@gmail.com>

--FfqW2oDqxzMP9fUY8RFEw9vuvk3KBVRPI
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/16/2018 10:13 AM, Jimmy Assarsson wrote:
> The EAN (article number) combined with serial number form a unique
> identifier for any Kvaser device. This makes it possible to map netdevi=
ce
> with physical Kvaser device.
>=20
> Example output for USBcan Light 2xHS:
> $ cat /sys/class/net/can0/ean
> 7330130007147
> $ cat /sys/class/net/can0/serial
> 10659

Please add sysfs Documentation to Documentation/ABI/testing/

> Tested with the following Kvaser devices:
> Leaf Light HS, Leaf Light HS v2, USBcan Light 2xHS, USBcan II,
> Memorator Professional HS/HS and Memorator HS/HS.
>=20
> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>

> ---
> Changes in v2:
>   - Use u64 for ean, instead of u32 ean[2].
>   - Use the existing sysfs_groups[0], from the net_device.
>=20
>  drivers/net/can/usb/kvaser_usb.c | 38 ++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index ee10beaa5da3..0436db1c5d6f 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -457,6 +457,8 @@ struct kvaser_usb {
>  	 * also used as a sentinel for marking free tx contexts.
>  	 */
>  	u32 fw_version;
> +	u32 serial;
> +	u64 ean;
>  	unsigned int nchannels;
>  	unsigned int max_tx_urbs;
>  	enum kvaser_usb_family family;
> @@ -692,6 +694,10 @@ static int kvaser_usb_get_card_info(struct kvaser_=
usb *dev)
>  	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
>  		return -EINVAL;
> =20
> +	dev->serial =3D le32_to_cpu(msg.u.cardinfo.serial_number);
> +	dev->ean =3D (u64)(le32_to_cpu(msg.u.cardinfo.ean[1])) << 32 |
> +		   le32_to_cpu(msg.u.cardinfo.ean[0]);
> +
>  	return 0;
>  }
> =20
> @@ -1802,6 +1808,37 @@ static const struct can_bittiming_const kvaser_u=
sb_bittiming_const =3D {
>  	.brp_inc =3D KVASER_USB_BRP_INC,
>  };
> =20
> +static ssize_t serial_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct kvaser_usb_net_priv *priv =3D netdev_priv(to_net_dev(dev));
> +	struct kvaser_usb *kvaser_dev =3D priv->dev;
> +
> +	return sprintf(buf, "%u\n", kvaser_dev->serial);
> +}
> +
> +static ssize_t ean_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct kvaser_usb_net_priv *priv =3D netdev_priv(to_net_dev(dev));
> +	struct kvaser_usb *kvaser_dev =3D priv->dev;
> +
> +	return sprintf(buf, "%llx\n", kvaser_dev->ean);

Do we want leading zeros? How's the ean written on the device?

> +}
> +
> +static DEVICE_ATTR_RO(serial);
> +static DEVICE_ATTR_RO(ean);
> +
> +static struct attribute *kvaser_usb_dev_attrs[] =3D {
> +	&dev_attr_serial.attr,
> +	&dev_attr_ean.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group kvaser_usb_dev_group =3D {
> +	.attrs =3D kvaser_usb_dev_attrs,
> +};
> +
>  static int kvaser_usb_set_bittiming(struct net_device *netdev)
>  {
>  	struct kvaser_usb_net_priv *priv =3D netdev_priv(netdev);
> @@ -1931,6 +1968,7 @@ static int kvaser_usb_init_one(struct usb_interfa=
ce *intf,
>  	netdev->flags |=3D IFF_ECHO;
> =20
>  	netdev->netdev_ops =3D &kvaser_usb_netdev_ops;
> +	netdev->sysfs_groups[0] =3D &kvaser_usb_dev_group;
> =20
>  	SET_NETDEV_DEV(netdev, &intf->dev);
>  	netdev->dev_id =3D channel;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FfqW2oDqxzMP9fUY8RFEw9vuvk3KBVRPI--

--ByZ7L0AD2XnccjfuFTrrxgecZNJMzMBLf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqGtI0ACgkQk9IU1zQo
ZfHQEQf9HaBJJhMvqenDas0mgCu1x6vEeCJ/cfvh7ALJ6SEkoeH/gS/oQM5DyUwh
y5AHwXh8tAUlazRzPlkFo7uI0hDeaU4aA9i2apjeh0jCG50Jzgtidq3fBBUa6ArM
+MOqEU+m45g5yY5Xybmrcoe48Kv6yO2KukQHZ21BO0orIMeEG40dlZeFOKuaBuyq
tpZ+13WaXcZZ6Zm/tyOx/SwfkIKs0vJMaV/LBHxUnX9dJOC3dLv3FEQQjx2h/Jld
Rp4XshoabeL7th6GJmbxmXLMdr5eS5tLN2stIUy8YmtMvWwRcxaggxQt7Fm8ATbo
CUPnB1t+jg8C2RhGQprFg8wDtmX1Nw==
=xVTN
-----END PGP SIGNATURE-----

--ByZ7L0AD2XnccjfuFTrrxgecZNJMzMBLf--
