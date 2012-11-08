From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Thu, 08 Nov 2012 10:27:58 +0100
Message-ID: <509B7B1E.5040509@pengutronix.de>
References: <509A5A3E.4090505@gaisler.com> <1352301634-12668-1-git-send-email-andreas@gaisler.com> <509B6D77.3090707@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE2F3498444E1627E8CD71742"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45480 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab2KHJ2T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Nov 2012 04:28:19 -0500
In-Reply-To: <509B6D77.3090707@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Andreas Larsson <andreas@gaisler.com>, linux-can@vger.kernel.org, software@gaisler.com, devicetree-discuss@lists.ozlabs.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2F3498444E1627E8CD71742
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/08/2012 09:29 AM, Wolfgang Grandegger wrote:
> On 11/07/2012 04:20 PM, Andreas Larsson wrote:
>> This driver supports GRCAN and CRHCAN CAN controllers available in the=
 GRLIB
>> VHDL IP core library.
>>
>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>=20
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>=20
> Looks good now. Thanks for your patience.

I'm still fighting against the flexcan, I'll have a look at the driver
this afternoon.

regards, Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE2F3498444E1627E8CD71742
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCbeyIACgkQjTAFq1RaXHO3OwCglUqk4Fp3bCQQAozGlgbya4Dc
IzYAn3Brk+Inox0SImHtI/eKd8qzh9jB
=Z7wM
-----END PGP SIGNATURE-----

--------------enigE2F3498444E1627E8CD71742--
