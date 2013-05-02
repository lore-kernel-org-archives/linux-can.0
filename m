From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Thu, 02 May 2013 13:09:50 +0200
Message-ID: <5182497E.5050606@pengutronix.de>
References: <1366737302.3325.36.camel@blackbox>   <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox>  <51780336.5060800@pengutronix.de> <1366839193.7226.8.camel@blackbox> <5182490F.2080707@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2JUHSAQECCJEMPIHDGKBH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48676 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3EBLJy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 May 2013 07:09:54 -0400
In-Reply-To: <5182490F.2080707@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>, Sven Geggus <lists@fuchsschwanzdomain.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2JUHSAQECCJEMPIHDGKBH
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/02/2013 01:07 PM, Marc Kleine-Budde wrote:
> On 04/24/2013 11:33 PM, Max S. wrote:
>> From 8a83080bcddc558cd016e58e408b56ca68bc5bc8 Mon Sep 17 00:00:00 2001=

>> From: Maximilian Schneider <max@schneidersoft.net>
>> Date: Wed, 24 Apr 2013 21:03:31 +0000
>> Subject: [PATCH] Added ss_usb source.
>=20
> Comments inline.
>=20
>> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
>> ---
>>  drivers/net/can/usb/Makefile |    1 +
>=20
> You should add your driver to Kconfig, too.
>=20
>>  drivers/net/can/usb/ss_usb.c |  944 +++++++++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 945 insertions(+)
>>  create mode 100644 drivers/net/can/usb/ss_usb.c
>>
>> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefi=
le
>> index becef46..c341a1b 100644
>> --- a/drivers/net/can/usb/Makefile
>> +++ b/drivers/net/can/usb/Makefile
>> @@ -7,5 +7,6 @@ obj-$(CONFIG_CAN_ESD_USB2) +=3D esd_usb2.o
>>  obj-$(CONFIG_CAN_KVASER_USB) +=3D kvaser_usb.o
>>  obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb/
>>  obj-$(CONFIG_CAN_8DEV_USB) +=3D usb_8dev.o
>> +obj-$(CONFIG_CAN_SS_USB) +=3D ss_usb.o
>> =20
>>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
>> diff --git a/drivers/net/can/usb/ss_usb.c b/drivers/net/can/usb/ss_usb=
=2Ec
>> new file mode 100644
>> index 0000000..69710ff
>> --- /dev/null
>> +++ b/drivers/net/can/usb/ss_usb.c
>> @@ -0,0 +1,944 @@
>=20
> Please add a header stating your license.
>=20
>> +#include <linux/init.h>
>> +#include <linux/signal.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/usb.h>
>> +
>> +#include <linux/can.h>
>> +#include <linux/can/dev.h>
>> +#include <linux/can/error.h>
>> +
>> +/* Device specific constants */
>> +#define USB_SSUSB_VENDOR_ID         0xbeef
>> +#define USB_SSUSB_AT32_PRODUCT_ID   0x1234
>=20
> Please get in touch with the Openmoko people for a real vendor/product
> id as Sven suggested. Sven can you arrange a contect?
>=20
>> +
>> +#define SS_USB_ENDPOINT_IN          1
>> +#define SS_USB_ENDPOINT_OUT         2
>> +
>> +#define SS_USB_BREQ_HOST_FORMAT     0
>> +#define SS_USB_BREQ_BITTIMING       1
>> +#define SS_USB_BREQ_MODE            2
>> +#define SS_USB_BREQ_BERR            3
>> +#define SS_USB_BREQ_BT_CONST        4
>> +
>> +
>> +#define SS_CAN_MODE_RESET           0
>> +#define SS_CAN_MODE_START           1
>> +
>> +#define SS_CAN_STATE_ERROR_ACTIVE   0
>> +#define SS_CAN_STATE_ERROR_WARNING  1
>> +#define SS_CAN_STATE_ERROR_PASSIVE  2
>> +#define SS_CAN_STATE_BUS_OFF        3
>> +#define SS_CAN_STATE_STOPPED        4
>> +#define SS_CAN_STATE_SLEEPING       5
>=20
> Can you pelase create an enum for each of these.
>=20
>> +
>> +/* data types passed between host and device */
>> +struct __packed device_config {
>> +	u16 byte_order;
>=20
> u32, byteorder please, so that you have natural alignment for this stru=
ct.
>=20
>> +
>> +	u32 hf_size;	/* size of a host frame */
>> +	u32 hf_can_id;
>> +	u32 hf_can_dlc;
>> +	u32 hf_data;
>> +	u32 hf_echo_id;
>> +	u32 hf_channel;
>> +};

Please give your struct a common prefix "ss_" like your defines already
have.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2JUHSAQECCJEMPIHDGKBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGCSX4ACgkQjTAFq1RaXHMTMQCffPJNmEjYY3IIOv1pX9SKiGpV
/pAAn2HhjwzYQgyEfs9tM/u3pIrukf5t
=RyIy
-----END PGP SIGNATURE-----

------enig2JUHSAQECCJEMPIHDGKBH--
