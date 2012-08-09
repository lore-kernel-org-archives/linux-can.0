From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Fwd: [Socketcan-users] sja1000_platform interrupt sharing
Date: Thu, 09 Aug 2012 16:00:59 +0200
Message-ID: <5023C29B.6000904@pengutronix.de>
References: <6C5A3B79888A804CAB605257CD26D37703955B60@vwagwox00032.vw.vwg> <5023B38B.80702@visionsystems.de> <5023B4BE.5000104@pengutronix.de> <5023B77C.6020108@visionsystems.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigECDAB00C465E5D8E1204066A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41205 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030292Ab2HIOBI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 10:01:08 -0400
In-Reply-To: <5023B77C.6020108@visionsystems.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegor_sub1@visionsystems.de
Cc: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigECDAB00C465E5D8E1204066A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/09/2012 03:13 PM, Yegor Yefremov wrote:
[...]

>>> O.K. Nice catch. I just picked the wrong header file
>>> include/linux/interrupt.h, it should be include/linux/ioport.h. Now
>>> I'll have to change my board file as well.
>> A quick serach showed no mainline board using shared irq, have I misse=
d one?
>=20
> You've missed one board in our own repos. We had to much of a custom
> code to try to mainline this board file.

No mainline no breakage :)


>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> You mean Acked-by?
>=20
> Yes.
>=20
> Acked-by: Yegor Yefremov <yegorslists@googlemail.com>

Thanks, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigECDAB00C465E5D8E1204066A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAjwqIACgkQjTAFq1RaXHNbVACfZh1OlYMoOOFEet+6pCO5/vPY
FO8AoIe4OZ6R/9m+ezSntq8vCtW/mtKc
=9uYz
-----END PGP SIGNATURE-----

--------------enigECDAB00C465E5D8E1204066A--
