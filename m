From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Softing Firmware on gitorious
Date: Wed, 11 Jan 2012 17:57:52 +0100
Message-ID: <4F0DBF90.5050906@pengutronix.de>
References: <4F0DB66F.50509@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8F06FBEED765F45A2755A4CA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34453 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab2AKQ6C (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 11:58:02 -0500
In-Reply-To: <4F0DB66F.50509@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F06FBEED765F45A2755A4CA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/11/2012 05:18 PM, Oliver Hartkopp wrote:
> Hello Kurt,
>=20
> i just uploaded the Softing firmware from BerliOS to our new=20
>=20
> https://gitorious.org/linux-can/can-misc
>=20
> git repository.
>=20
> See at=20
>=20
> https://gitorious.org/linux-can/can-misc/blobs/master/firmware/softing-=
fw-4.6-binaries.tar.gz
>=20
> Currently the only reference is in the Linux Kernel in the Softing Kcon=
fig:
>=20
> config CAN_SOFTING_CS
>         tristate "Softing Gmbh CAN pcmcia cards"
>         depends on PCMCIA
>         depends on CAN_SOFTING
>         ---help---
>           Support for PCMCIA cards from Softing Gmbh & some cards
>           from Vector Gmbh.
>           You need firmware for these, which you can get at
>           http://developer.berlios.de/projects/socketcan/
>           This version of the driver is written against
>           firmware version 4.6 (softing-fw-4.6-binaries.tar.gz)
>           In order to use the card as CAN device, you need the Softing =
generic
>           support too.
>=20
>=20
> The question is now:
>=20
> 1. change the link in the Kconfig
> 2. Add the PCMCIA firmware to the Linux Kernel (linux/firmware/*.ihex)
> 3. 1 & 2

3.

It would be nice to have a license statement on that files. As these are
in binary form, the driver would be removed from the debian kernel.
What's the official source of that firmware? Do we have a contact to
softing?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8F06FBEED765F45A2755A4CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8Nv5QACgkQjTAFq1RaXHO98gCfXnthV0qFJcf5MgzPjQfLfWZ4
V/oAn1YpZodaK7CCFK3KnYh2xKCuXDsQ
=pTBf
-----END PGP SIGNATURE-----

--------------enig8F06FBEED765F45A2755A4CA--
