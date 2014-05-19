From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v1] can: gs_usb: Added support for the GS_USB CAN devices.
Date: Mon, 19 May 2014 08:49:52 +0200
Message-ID: <5379A990.1060308@pengutronix.de>
References: <1387913385.3479.5.camel@blackbox> <5342C225.7070907@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="k0c7wP4vHv6bk9V7RkgD4Mo2OG7SHQopF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50650 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbaESGuL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 02:50:11 -0400
In-Reply-To: <5342C225.7070907@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, "Max S." <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k0c7wP4vHv6bk9V7RkgD4Mo2OG7SHQopF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2014 05:20 PM, Wolfgang Grandegger wrote:
> On 12/24/2013 08:29 PM, Max S. wrote:
>> >From 11d702dac3ec1b5eadffa3435cade7fdd853c91f Mon Sep 17 00:00:00 200=
1
>> From: Maximilian Schneider <max@schneidersoft.net>
>> Date: Sun, 3 Nov 2013 16:57:06 +0000
>> Subject: [PATCH] Added support for the GS_USB CAN devices.
>>
>> ---
>> The patch is against the 'linux-can-next.git' repo.
>>
>> The Geschwister Schneider Family of devices are galvanically isolated =
USB2.0 to CAN2.0A/B adapters.
>> Currently two form factors are available, a tethered dongle in a rugge=
d enclosure, and mini-pci-e card.
>>
>> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
>=20
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>=20
> Marc, I reviewed the patch again over the weekend and did find just a
> few minor issues (see below) which I could fix with a subsequent patch.=

> From my point of view the driver can go in.

Thanks for the review. I've addressed your remarks while applying this
patch to can-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--k0c7wP4vHv6bk9V7RkgD4Mo2OG7SHQopF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlN5qZAACgkQjTAFq1RaXHNROgCePU/XS7CPP96Bj2szm5e1kEEf
/j8AnAvuOtnX5mKBxIMvFjnRMTObsGUF
=VYSs
-----END PGP SIGNATURE-----

--k0c7wP4vHv6bk9V7RkgD4Mo2OG7SHQopF--
