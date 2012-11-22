From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] peak_usb: fix hwtstamp assignment
Date: Thu, 22 Nov 2012 11:35:58 +0100
Message-ID: <50AE000E.4040208@pengutronix.de>
References: <50AD4B1F.4070806@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE4E9FDD12868C38C5D488B5C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48604 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab2KVTT4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:56 -0500
In-Reply-To: <50AD4B1F.4070806@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE4E9FDD12868C38C5D488B5C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/21/2012 10:43 PM, Oliver Hartkopp wrote:
> The skb->tstamp is set to the hardware timestamp when available in the =
USB
> urb message. This leads to user visible timestamps which contain the 'u=
ptime'
> of the USB adapter - and not the usual system generated timestamp.
>=20
> Fix this wrong assignment by applying the available hardware timestamp =
to the
> skb_shared_hwtstamps data structure - which is intended for this purpos=
e.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> ---
>=20
> Hello Marc, hello Stephane,
>=20
> i think we would generally need to support a hwtstamp_ioctl() for CAN
> interfaces which are controlled with a struct hwtstamp_config in the fu=
ture.
>=20
> For now this patch fixes the current issue much better than a simple re=
moval
> of the skb->tstamp assignment.

Sure, making it work correctly is better than removing the broken stuff.
But removing the broken code is better than having wrong code in the driv=
er.

> I'm currently on a business trip and i accidentally missed to take two =
PEAK
> USB interfaces with me to test this patch. It's compile tested ...

:)

> So let's wait for an Acked-by from Stephane.

yep,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE4E9FDD12868C38C5D488B5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCuAA4ACgkQjTAFq1RaXHPL6QCdEplwQ9609bHNZWC5j9BOjn82
aNgAoJLGy0weVplqjNT+Mx9dxCMcsW5e
=q4Z3
-----END PGP SIGNATURE-----

--------------enigE4E9FDD12868C38C5D488B5C--
