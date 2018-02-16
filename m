From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: kvaser_usb: Expose EAN and serial number via
 sysfs
Date: Fri, 16 Feb 2018 12:01:59 +0100
Message-ID: <59774aac-2383-7eb6-fc79-43c9d53c20a4@pengutronix.de>
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
 <20180216091337.13924-2-jimmyassarsson@gmail.com>
 <dca8530d-71fb-ea0c-6e84-d21c26587227@pengutronix.de>
 <15d002bb-92a2-20d6-8d49-795785298232@kvaser.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZK9lD0lCiT0EN2c0XEFOkUuZ1Falj9Wek"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41077 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLCs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 06:02:48 -0500
In-Reply-To: <15d002bb-92a2-20d6-8d49-795785298232@kvaser.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZK9lD0lCiT0EN2c0XEFOkUuZ1Falj9Wek
Content-Type: multipart/mixed; boundary="59jk0zpOlPq34M6SDgHfqsa2Ca4Pt0pDp";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>,
 Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org
Message-ID: <59774aac-2383-7eb6-fc79-43c9d53c20a4@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: kvaser_usb: Expose EAN and serial number via
 sysfs
References: <20180216091337.13924-1-jimmyassarsson@gmail.com>
 <20180216091337.13924-2-jimmyassarsson@gmail.com>
 <dca8530d-71fb-ea0c-6e84-d21c26587227@pengutronix.de>
 <15d002bb-92a2-20d6-8d49-795785298232@kvaser.com>
In-Reply-To: <15d002bb-92a2-20d6-8d49-795785298232@kvaser.com>

--59jk0zpOlPq34M6SDgHfqsa2Ca4Pt0pDp
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/16/2018 12:01 PM, Jimmy Assarsson wrote:
> On 2018-02-16 11:38, Marc Kleine-Budde wrote:
>> On 02/16/2018 10:13 AM, Jimmy Assarsson wrote:
>>> The EAN (article number) combined with serial number form a unique
>>> identifier for any Kvaser device. This makes it possible to map netde=
vice
>>> with physical Kvaser device.
>>>
>>> Example output for USBcan Light 2xHS:
>>> $ cat /sys/class/net/can0/ean
>>> 7330130007147
>>> $ cat /sys/class/net/can0/serial
>>> 10659
>>
>> Please add sysfs Documentation to Documentation/ABI/testing/
>=20
> Will this name be OK: Documentation/ABI/testing/sysfs-class-net-kvaser_=
usb?

I tried to find a pattern, but I failed :) "sysfs-class-net-kvaser_usb"
looks good.

>=20
>>> Tested with the following Kvaser devices:
>>> Leaf Light HS, Leaf Light HS v2, USBcan Light 2xHS, USBcan II,
>>> Memorator Professional HS/HS and Memorator HS/HS.
>>>
>>> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
>>
>>> ---
>>> Changes in v2:
>>>    - Use u64 for ean, instead of u32 ean[2].
>>>    - Use the existing sysfs_groups[0], from the net_device.
>>>
>>>   drivers/net/can/usb/kvaser_usb.c | 38 +++++++++++++++++++++++++++++=
+++++++++
>>>   1 file changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/k=
vaser_usb.c
>>> index ee10beaa5da3..0436db1c5d6f 100644
>>> --- a/drivers/net/can/usb/kvaser_usb.c
>>> +++ b/drivers/net/can/usb/kvaser_usb.c
>>> @@ -457,6 +457,8 @@ struct kvaser_usb {
>>>   	 * also used as a sentinel for marking free tx contexts.
>>>   	 */
>>>   	u32 fw_version;
>>> +	u32 serial;
>>> +	u64 ean;
>>>   	unsigned int nchannels;
>>>   	unsigned int max_tx_urbs;
>>>   	enum kvaser_usb_family family;
>>> @@ -692,6 +694,10 @@ static int kvaser_usb_get_card_info(struct kvase=
r_usb *dev)
>>>   	     dev->nchannels > MAX_USBCAN_NET_DEVICES))
>>>   		return -EINVAL;
>>>  =20
>>> +	dev->serial =3D le32_to_cpu(msg.u.cardinfo.serial_number);
>>> +	dev->ean =3D (u64)(le32_to_cpu(msg.u.cardinfo.ean[1])) << 32 |
>>> +		   le32_to_cpu(msg.u.cardinfo.ean[0]);
>>> +
>>>   	return 0;
>>>   }
>>>  =20
>>> @@ -1802,6 +1808,37 @@ static const struct can_bittiming_const kvaser=
_usb_bittiming_const =3D {
>>>   	.brp_inc =3D KVASER_USB_BRP_INC,
>>>   };
>>>  =20
>>> +static ssize_t serial_show(struct device *dev,
>>> +			   struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct kvaser_usb_net_priv *priv =3D netdev_priv(to_net_dev(dev));
>>> +	struct kvaser_usb *kvaser_dev =3D priv->dev;
>>> +
>>> +	return sprintf(buf, "%u\n", kvaser_dev->serial);
>>> +}
>>> +
>>> +static ssize_t ean_show(struct device *dev,
>>> +			struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct kvaser_usb_net_priv *priv =3D netdev_priv(to_net_dev(dev));
>>> +	struct kvaser_usb *kvaser_dev =3D priv->dev;
>>> +
>>> +	return sprintf(buf, "%llx\n", kvaser_dev->ean);
>>
>> Do we want leading zeros? How's the ean written on the device?
>=20
> No, we don't. It's like this 73-30130-00714-7.

ok

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--59jk0zpOlPq34M6SDgHfqsa2Ca4Pt0pDp--

--ZK9lD0lCiT0EN2c0XEFOkUuZ1Falj9Wek
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqGuicACgkQk9IU1zQo
ZfERtwf/TThIKJZbT2xJuVfKbWlDCSwQVpQ8lseaMR3HfSOwroq6Cujuhc6En7zZ
DuT35u6s9tJjtqIz/T0PG6WMo1w/QWJ04jtSfaAHqQgXJ4OYA41qgmWzVpp8k0fJ
YmfSdspEz/HQgX6o9jCYE8lLug455KYiojn7KAJc+MM2CZsp3Dixu5kue7I1MYD4
6wKzM/WrcvMI9VKivv2Kc4OdlnK9YNRfdF+RDHPT934OAR3uI1PPP0YlapRoxQTE
UzjqHcHxumqB69QAyyKetP/vIMHMskod9OG+sZq0LdJZxBPDDo2Lta/Vttfyc9Td
4b3cxht77Nul5RSmFOiA8WiWJq4FyA==
=XO/c
-----END PGP SIGNATURE-----

--ZK9lD0lCiT0EN2c0XEFOkUuZ1Falj9Wek--
