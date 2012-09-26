From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: can_oc: Add driver for CAN_OC cores from Aeroflex
 Gaisler
Date: Wed, 26 Sep 2012 14:58:51 +0200
Message-ID: <5062FC0B.4050309@pengutronix.de>
References: <1348552379-3909-1-git-send-email-andreas@gaisler.com> <5062CD27.3090803@pengutronix.de> <5062D13F.1090908@grandegger.com> <5062E99B.8020700@gaisler.com> <5062E9EE.2020300@pengutronix.de> <5062FB2B.2030700@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig776FDB1372F33C480DEB1980"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50918 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab2IZM7H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Sep 2012 08:59:07 -0400
In-Reply-To: <5062FB2B.2030700@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig776FDB1372F33C480DEB1980
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/26/2012 02:55 PM, Andreas Larsson wrote:
[...]

>>>> Right, at least I do not see anything special. The following DTS ent=
ry
>>>> should do the jobs:
>>>> [...]
>>>
>>> I'll look into this. Note that this is a SPARC device and not a Power=
PC
>>> device.
>>
>> The driver doesn't care about your processor :)
>=20
> The driver doesn't care per se, but how the device tree is generated
> differs compared to how it is done in PowerPC, at least for Leon SPARC.=


What difference do you mean? For example the flexcan driver works
perfectly for ARM (DT and non-DT) and PowerPC (DT).

> I'll look into it. At the very least the Kconfig entry for
> sja1000_of_platform could not solely depend on PPC_OF, but the more
> important issue is the device tree differences.

Sure send a patch, or better send a patch that integrates the OF
Bindings into the existing platform driver and remove the of_platform
driver completely.

regards, Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig776FDB1372F33C480DEB1980
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBi/A0ACgkQjTAFq1RaXHMZHgCeN2Mt2eqy2CosZqcj2aBZqIPb
d4UAn3JL6k9rpPq2mho+RXvJp/S5TGbA
=PBYC
-----END PGP SIGNATURE-----

--------------enig776FDB1372F33C480DEB1980--
