From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v9] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 15 Jan 2013 21:23:15 +0100
Message-ID: <50F5BAB3.3090902@pengutronix.de>
References: <1355641315-15739-1-git-send-email-krumboeck@universalnet.at> <50F471AC.50902@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DCHSMXCOMRKCAWQEQPPU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59010 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756644Ab3AOUXW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Jan 2013 15:23:22 -0500
In-Reply-To: <50F471AC.50902@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Bernd Krumboeck <b.krumboeck@gmail.com>, linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com, Bernd Krumboeck <krumboeck@universalnet.at>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DCHSMXCOMRKCAWQEQPPU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/14/2013 09:59 PM, Oliver Hartkopp wrote:
> Hi Bernd,
>=20
> On 16.12.2012 08:01, Bernd Krumboeck wrote:
>=20
>> Add device driver for USB2CAN interface from "8 devices" (http://www.8=
devices.com).
>>
>> changes since v8:
>> * remove all sysfs files
>>
>> changes since v7:
>> * add sysfs documentation
>> * fix minor styling issue
>> * fixed can state for passive mode
>> * changed handling for crc errors
>>
>> changes since v6:
>> * changed some variable types to big endian equivalent
>> * small cleanups
>>
>> changes since v5:
>> * unlock mutex on error
>>
>> changes since v4:
>> * removed FSF address
>> * renamed struct usb_8dev
>> * removed unused variable free_slots
>> * replaced some _to_cpu functions with pointer equivalent
>> * fix return value for usb_8dev_set_mode
>> * handle can errors with separate function
>> * fix overrun error handling
>> * rewrite error handling for usb_8dev_start_xmit
>> * fix urb submit in usb_8dev_start
>> * various small fixes
>>
>> Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>=20
>=20
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> Fortunately i got my adapter today ...
>=20
> [   52.984254] usb 2-1.4: new full-speed USB device number 6 using ehci=
-pci
> [   53.078690] usb 2-1.4: New USB device found, idVendor=3D0483, idProd=
uct=3D1234
> [   53.078698] usb 2-1.4: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D3
> [   53.078703] usb 2-1.4: Product: USB2CAN converter
> [   53.078707] usb 2-1.4: Manufacturer: edevices
> [   53.078711] usb 2-1.4: SerialNumber: ED000212
> [   53.111990] usb_8dev 2-1.4:1.0 can2: firmware: 1.4, hardware: 255.25=
5
> [   53.112090] usbcore: registered new interface driver usb_8dev
>=20
> Looks good :-)
>=20
> When detaching the device from the CAN bus when sending/receiving CAN t=
raffic
> i got these dmesg infos:
>=20
> [  960.047130] usb_8dev 2-1.4:1.0 can2: Unknown status/error message (0=
)
> [  976.544343] usb_8dev 2-1.4:1.0 can2: Unknown status/error message (0=
)
>=20
> Did you check these kind of 'unfriendly user' tests?
>=20
> E.g. pulling the USB under receive load brings this output:
>=20
> [ 1343.786427] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.786640] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
>=20
> (..) another 344 of these URB aborted messages
>=20
> [ 1343.872620] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.872867] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.873124] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.873269] usb 2-1.4: USB disconnect, device number 6
> [ 1343.873363] usb_8dev 2-1.4:1.0 can2: Rx URB aborted (-32)
> [ 1343.875259] usb_8dev 2-1.4:1.0 can2: device disconnected
> [ 1343.875366] usb_8dev 2-1.4:1.0 can2: sending command message failed
> [ 1343.875371] usb_8dev 2-1.4:1.0 can2: couldn't stop device
>=20
>=20
> Tomorrow i will do some more testing.
>=20
> The LED handling of the device is really fine:
>=20
> - interface down -> red
> - interface up -> green
> - interface error passive -> green blinking
>=20
> Regards,
> Oliver

What do you suggest? Add the driver or fix the errors first?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2DCHSMXCOMRKCAWQEQPPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD1urMACgkQjTAFq1RaXHPpAwCdH3WSKuBpgjyA/5mzzoCgTTFP
lCsAnj/7DX8H3kOTeMg9S20OaPAQc5uH
=3oQW
-----END PGP SIGNATURE-----

------enig2DCHSMXCOMRKCAWQEQPPU--
