From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v11] usb_8dev: Add support for USB2CAN interface from
 8 devices
Date: Tue, 22 Jan 2013 22:54:20 +0100
Message-ID: <50FF0A8C.2010509@pengutronix.de>
References: <1358577045-5252-1-git-send-email-krumboeck@universalnet.at> <50FF05D5.1010909@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QVKPDAEXRSOEACWEFHPM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48306 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab3AVVyZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jan 2013 16:54:25 -0500
In-Reply-To: <50FF05D5.1010909@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com, Bernd Krumboeck <krumboeck@universalnet.at>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QVKPDAEXRSOEACWEFHPM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/22/2013 10:34 PM, Marc Kleine-Budde wrote:
> On 01/19/2013 07:30 AM, Bernd Krumboeck wrote:
>> Add device driver for USB2CAN interface from "8 devices" (http://www.8=
devices.com).
>>
>> changes since v10:
>> * small cleanups
>>
>> changes since v9:
>> * fixed syslog messages
>> * fixed crc error number
>> * increased MAX_RX_URBS and MAX_TX_URBS
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
>> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> Thanks for you patience :) Applied to can-next.

I've tweaked some comments to make checkpatch a bit more quiet.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QVKPDAEXRSOEACWEFHPM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD/CowACgkQjTAFq1RaXHPmpgCfcFdhKUC4V25v9IQM/nyOveTW
nw0AoJocKj4RhkOtN9hqyhv2whfQbcvw
=MpsK
-----END PGP SIGNATURE-----

------enig2QVKPDAEXRSOEACWEFHPM--
