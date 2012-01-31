From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can/sja1000: Add PEAK-System PCIe/PCIeC and miniPCI
 boards
Date: Tue, 31 Jan 2012 17:55:28 +0100
Message-ID: <4F281D00.8070909@pengutronix.de>
References: <1328015960-14744-1-git-send-email-s.grosjean@peak-system.com> <1328015960-14744-2-git-send-email-s.grosjean@peak-system.com> <4F27EBC5.3060805@pengutronix.de> <4F280245.60809@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCF23DCB9AB783CD2D70BCCE0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57252 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab2AaQza (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 11:55:30 -0500
In-Reply-To: <4F280245.60809@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF23DCB9AB783CD2D70BCCE0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/31/2012 04:01 PM, Stephane Grosjean wrote:
> Hi Marc,
>=20
> What do you mean please? You want me to post 4 patches? One for each ne=
w
> board, plus one for the channels list management? For 2 of the 3 boards=
,
> this is as simple as adding a line into the device ids table, excepting=

> the ExpressCard for which I added the management of the funky leds.
> Thanks for any clarification.

[...]

Your patch states to fix a problem:

>>> This patch also fixes the management of the channels list.
>> Without looking further at the patch, please make it a seperate patch.=
 A
>> detailed review will follow.

It would be better to fix the problem before adding new features.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCF23DCB9AB783CD2D70BCCE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8oHQAACgkQjTAFq1RaXHNvkQCggoMONzZgMZD+iBCS+qg6O6n6
mUgAoIRwdOAOwZ7Mv12Y5UPj8zOwUi+y
=e6Yr
-----END PGP SIGNATURE-----

--------------enigCF23DCB9AB783CD2D70BCCE0--
