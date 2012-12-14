From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v7] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Fri, 14 Dec 2012 19:30:34 +0100
Message-ID: <50CB704A.8050704@pengutronix.de>
References: <1355424053-608-1-git-send-email-krumboeck@universalnet.at>    <50CB148F.7030002@pengutronix.de> <95c24a1d2b44b779fc4022a4f5ea6961.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig177DD3837B4C2E461FCD5F82"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53954 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab2LNSam (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Dec 2012 13:30:42 -0500
In-Reply-To: <95c24a1d2b44b779fc4022a4f5ea6961.squirrel@webmail.universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Bernd_Krumb=F6ck?= <krumboeck@universalnet.at>
Cc: Bernd Krumboeck <b.krumboeck@gmail.com>, linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig177DD3837B4C2E461FCD5F82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/14/2012 07:22 PM, "Bernd Krumb=F6ck" wrote:
> Hello Marc!
>=20
>> Looks good to me. Minor style issue inline. Please provide a
>> documentation for the sysfs entries and place it under:
>> Documentation/ABI/testing/sysfs-platform.
>=20
> Should I change the sysfs path to /sys/devices/platform/usb_8dev? At th=
e
> moment the path is /sys/bus/usb/devices/<busnum>:<devnum>.

Sorry, my fault. I copied the sysfs path from the at91 driver, which is
a platform, not a USB driver. There are several usb descriptions under
Documentation/ABI/testing/ see which way to describe your device fits bes=
t.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig177DD3837B4C2E461FCD5F82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDLcE0ACgkQjTAFq1RaXHP0WwCdFpVsxucwWHrQa+clSTps6rq6
k+UAmgNMDOLGsylQzQ9OJTse7j5WExuK
=ZK0d
-----END PGP SIGNATURE-----

--------------enig177DD3837B4C2E461FCD5F82--
