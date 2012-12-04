From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 04 Dec 2012 11:14:51 +0100
Message-ID: <50BDCD1B.2010306@pengutronix.de>
References: <50BBF73F.9080208@universalnet.at> <50BC5ECB.9070206@grandegger.com> <50BD0C52.6010606@universalnet.at> <50BD0858.3020707@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig269F07CD76F01C24FEC38965"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45034 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2LDKOz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Dec 2012 05:14:55 -0500
In-Reply-To: <50BD0858.3020707@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "krumboeck@universalnet.at" <krumboeck@universalnet.at>, linux-can@vger.kernel.org, linux-usb@vger.kernel.org, gediminas@8devices.com, info@gerhard-bertelsmann.de

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig269F07CD76F01C24FEC38965
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/03/2012 09:15 PM, Wolfgang Grandegger wrote:
> On 12/03/2012 09:32 PM, krumboeck@universalnet.at wrote:
>> Hi Wolfgang!
>>
>>>
>>> And please also drop the remaining sysfs files for firmware and
>>> hardware. I thinks it's enough that the versions are printed when the=

>>> device is probed.
>>
>> Systemadministrators often use versions for configuration scripts.
>> If you insist I will remove.
>=20
> Marc?

Are these values exported via lsusb -v (e.g. iSerial)?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig269F07CD76F01C24FEC38965
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC9zRwACgkQjTAFq1RaXHOOjwCfdexZjKscsykLibNUNmn7P94f
YhEAnA8SaKIPosfXDhKfyc/bZH3RTi4y
=Zew/
-----END PGP SIGNATURE-----

--------------enig269F07CD76F01C24FEC38965--
