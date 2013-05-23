From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Getting error while setting bitrate in CAN interface for ICS
Date: Thu, 23 May 2013 15:28:54 +0200
Message-ID: <519E1996.70903@pengutronix.de>
References: <CAAQm8iNzoA8fiJ9swvdqH-GADuJRo6tmm1a=8JehR1qOAGcaKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WGDEQOEPOIWBNLDSEISP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36820 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758581Ab3EWN3D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2013 09:29:03 -0400
In-Reply-To: <CAAQm8iNzoA8fiJ9swvdqH-GADuJRo6tmm1a=8JehR1qOAGcaKg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Padma Chavala <padmachavala@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WGDEQOEPOIWBNLDSEISP
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Padma Chavala,

please use the linux-can mailinglist (Cc'ed)

On 05/23/2013 03:07 PM, Padma Chavala wrote:
> I'm facing issue of setting the bitrate for CAN in android(ics)
>=20
> *# /sbin/ip link set can0 type can bitrate 125000 triple-sampling on*
>=20
> below is the response I get
> *Garbage instead of arguments "bitrate ...". Try "ip link help"
> *
> But in linux same thing works fine.
> Did anybody face same issue and did you solve it.

Please ensure that you use the "ip" utility of a recent version of
iproute2. The busybox version doesn't support can.

regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2WGDEQOEPOIWBNLDSEISP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGeGZkACgkQjTAFq1RaXHNmTACgiFStPCXty38r9VP0f5YIrPma
Dc0AnReY9nfEIv2xjJrrU22V9kvn2/PX
=7o//
-----END PGP SIGNATURE-----

------enig2WGDEQOEPOIWBNLDSEISP--
