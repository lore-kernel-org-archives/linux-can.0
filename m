From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: posted PEAK PCIeC/PCMCIA/USB drivers for can-next?
Date: Thu, 01 Mar 2012 18:13:32 +0100
Message-ID: <4F4FAE3C.80200@pengutronix.de>
References: <4F4FABB2.7020303@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5DD762FDB6D382E9E8B61AC6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37477 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758799Ab2CARNv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Mar 2012 12:13:51 -0500
In-Reply-To: <4F4FABB2.7020303@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DD762FDB6D382E9E8B61AC6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/01/2012 06:02 PM, Oliver Hartkopp wrote:
> Hallo Marc, Alan, Wolfgang,
>=20
> any opinions about these patches?
>=20
> [PATCH 0/3 v7] can/usb: Add PEAK-System PCAN USB adapters driver
> http://marc.info/?l=3Dlinux-can&m=3D133035447302721&w=3D2

A review from the USB list would be fine.

> [PATCH 0/2] Add support of sja1000-based PEAK-System cards
> http://marc.info/?l=3Dlinux-can&m=3D133035780804156&w=3D2

Looks good....but it's not bisecable.

> IMO they are ready for can-next / net-next for Linux 3.4 upstream.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig5DD762FDB6D382E9E8B61AC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9PrjwACgkQjTAFq1RaXHO1qwCdFq9s/QtPP0FgEhB0hAEgBi+2
UbgAmgNaPNIROsn8gKdnE6+53BIr676p
=NfPI
-----END PGP SIGNATURE-----

--------------enig5DD762FDB6D382E9E8B61AC6--
