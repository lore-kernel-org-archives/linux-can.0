From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: Expose EAN and serial number via sysfs
Date: Thu, 15 Feb 2018 17:28:56 +0100
Message-ID: <0749979a-a060-6057-b8e1-3cbd8c24834a@pengutronix.de>
References: <20180215155851.7584-1-jimmyassarsson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8RUaBFAqALowjcOEKv6mpvU597Tym3imL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59679 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424291AbeBOQ3x (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Feb 2018 11:29:53 -0500
In-Reply-To: <20180215155851.7584-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8RUaBFAqALowjcOEKv6mpvU597Tym3imL
Content-Type: multipart/mixed; boundary="zvl4lvaZlgUJRPeiXWCnZf1OwOKh3Es0v";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org
Message-ID: <0749979a-a060-6057-b8e1-3cbd8c24834a@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: Expose EAN and serial number via sysfs
References: <20180215155851.7584-1-jimmyassarsson@gmail.com>
In-Reply-To: <20180215155851.7584-1-jimmyassarsson@gmail.com>

--zvl4lvaZlgUJRPeiXWCnZf1OwOKh3Es0v
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/15/2018 04:58 PM, Jimmy Assarsson wrote:
> The EAN (article number) combined with serial number form a unique
> identifier for any Kvaser device. This makes it possible to map netdevi=
ce
> with physical Kvaser device.
>=20
> The struct kvaser_msg_cardinfo can be simplified, since serial_number_h=
igh
> is never used in firmware, for USBcan II devices.

Please make this a separate patch -> 1/2.

>=20
> Example output for USBcan Light 2xHS:
> $ cat /sys/class/net/can0/device/ean
> 7330130007147
> $ cat /sys/class/net/can0/device/serial
> 10659
>=20
> Tested with the following Kvaser devices:
> Leaf Light HS, Leaf Light HS v2, USBcan Light 2xHS, USBcan II,
> Memorator Professional HS/HS and Memorator HS/HS.
>=20
> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
> ---
>  drivers/net/can/usb/kvaser_usb.c | 63 ++++++++++++++++++++++++++++++++=
--------
>  1 file changed, 51 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index 63587b8e6825..b03f5723a343 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -196,19 +196,11 @@ struct kvaser_msg_simple {
>  struct kvaser_msg_cardinfo {
>  	u8 tid;
>  	u8 nchannels;
> -	union {
> -		struct {
> -			__le32 serial_number;
> -			__le32 padding;
> -		} __packed leaf0;
> -		struct {
> -			__le32 serial_number_low;
> -			__le32 serial_number_high;
> -		} __packed usbcan0;
> -	} __packed;
> +	__le32 serial_number;
> +	__le32 padding0;
>  	__le32 clock_resolution;
>  	__le32 mfgdate;
> -	u8 ean[8];
> +	u32 ean[2];
>  	u8 hw_revision;
>  	union {
>  		struct {
> @@ -218,7 +210,7 @@ struct kvaser_msg_cardinfo {
>  			u8 padding;
>  		} __packed usbcan1;
>  	} __packed;
> -	__le16 padding;
> +	__le16 padding1;
>  } __packed;
> =20
>  struct kvaser_msg_cardinfo2 {
> @@ -465,6 +457,8 @@ struct kvaser_usb {
>  	 * also used as a sentinel for marking free tx contexts.
>  	 */
>  	u32 fw_version;
> +	u32 serial;
> +	u32 ean[2];
u64?
>  	unsigned int nchannels;
>  	unsigned int max_tx_urbs;
>  	enum kvaser_usb_family family;
> @@ -700,6 +694,10 @@ static int kvaser_usb_get_card_info(struct kvaser_=
usb *dev)
>  	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
>  		return -EINVAL;
> =20
> +	dev->serial =3D le32_to_cpu(msg.u.cardinfo.serial_number);
> +	dev->ean[0] =3D le32_to_cpu(msg.u.cardinfo.ean[0]);
> +	dev->ean[1] =3D le32_to_cpu(msg.u.cardinfo.ean[1]);
> +
>  	return 0;
>  }
> =20
> @@ -1985,6 +1983,38 @@ static int kvaser_usb_get_endpoints(const struct=
 usb_interface *intf,
>  	return -ENODEV;
>  }
> =20
> +static ssize_t serial_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct usb_interface *intf =3D to_usb_interface(dev);
> +	struct kvaser_usb *kvaser_dev =3D usb_get_intfdata(intf);
> +
> +	return sprintf(buf, "%u\n", kvaser_dev->serial);
> +}
> +
> +static ssize_t ean_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct usb_interface *intf =3D to_usb_interface(dev);
> +	struct kvaser_usb *kvaser_dev =3D usb_get_intfdata(intf);
> +
> +	return sprintf(buf, "%x%x\n", kvaser_dev->ean[1], kvaser_dev->ean[0])=
;

What happens if there are leading '0' in ean[0]? Using a u64 would fix
this, too.

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
> +	.name =3D NULL,
> +	.attrs =3D kvaser_usb_dev_attrs,
> +};
> +
>  static int kvaser_usb_probe(struct usb_interface *intf,
>  			    const struct usb_device_id *id)
>  {
> @@ -2048,10 +2078,18 @@ static int kvaser_usb_probe(struct usb_interfac=
e *intf,
>  		return err;
>  	}
> =20
> +	err =3D sysfs_create_group(&intf->dev.kobj, &kvaser_usb_dev_group);
> +	if (err) {
> +		dev_err(&intf->dev, "Cannot create sysfs group %d\n", err);
> +		return err;
> +	}
> +

Why don't you use the existing dev->sysfs_groups[0]?

See the at91 driver for example:

http://lxr.bootlin.com/linux/latest/source/drivers/net/can/at91_can.c#L13=
41

>  	for (i =3D 0; i < dev->nchannels; i++) {
>  		err =3D kvaser_usb_init_one(intf, id, i);
>  		if (err) {
>  			kvaser_usb_remove_interfaces(dev);
> +			sysfs_remove_group(&intf->dev.kobj,
> +					   &kvaser_usb_dev_group);
>  			return err;
>  		}
>  	}
> @@ -2063,6 +2101,7 @@ static void kvaser_usb_disconnect(struct usb_inte=
rface *intf)
>  {
>  	struct kvaser_usb *dev =3D usb_get_intfdata(intf);
> =20
> +	sysfs_remove_group(&intf->dev.kobj, &kvaser_usb_dev_group);
>  	usb_set_intfdata(intf, NULL);
> =20
>  	if (!dev)
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--zvl4lvaZlgUJRPeiXWCnZf1OwOKh3Es0v--

--8RUaBFAqALowjcOEKv6mpvU597Tym3imL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqFtUgACgkQk9IU1zQo
ZfE3Ggf9HpdXXsLRP2bVSgEJ5UcHEy9XM7yuLHZ1WwYCitpWZlfws0Wiof+ZkLwt
tz6Xep+3gZSc3AsxZZ1VhJLdvQpePyczbLZsV1CGfHiVklnQuYGxeIe+/igIjv/C
zjZ6l92pUgeDxT0mrmSgrNle3JhorR4UkvbIgPXpMEaO24CO4ywaeyRPuq/RUbPx
EW0+4UEQEwS+sG4KdpoS4y6c6HNIRMhFvAC4JnPCWsS5WcYPmKGn/eCLvaxux2ZM
McUKY6UwzoD+ydh2vhS5TCiszvNppa0ADBV97BdaNKbKbrMWTm76ZIaeN0jG7pZY
jfReprSqj8y/cFq09ZZFjM2Z6pB3XA==
=R8Va
-----END PGP SIGNATURE-----

--8RUaBFAqALowjcOEKv6mpvU597Tym3imL--
