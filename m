From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: ip -details link fails
Date: Wed, 27 May 2015 21:16:32 +0200
Message-ID: <55661810.3050407@pengutronix.de>
References: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>,<5565F98E.5010101@hartkopp.net>
 <BAY176-W119C53753111D23AE6FA39D3CB0@phx.gbl> <5565FDE5.1040908@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="REu5TK1JQu9WDulqdA6k9da1TRnStHE8s"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51304 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbbE0TQt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 May 2015 15:16:49 -0400
In-Reply-To: <5565FDE5.1040908@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--REu5TK1JQu9WDulqdA6k9da1TRnStHE8s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/27/2015 07:24 PM, Oliver Hartkopp wrote:
>> # ip -details link show wlan0
>> RTNETLINK answers: Invalid argument
>> Cannot send link get request: Invalid argument
>=20
> The fact that your 'ip' tool doesn't work with wlan0 too your problem i=
s
> probably not CAN related.

BTW: the busybox version of ip doesn't talk can.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--REu5TK1JQu9WDulqdA6k9da1TRnStHE8s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVZhgQAAoJEP5prqPJtc/HJ3QIAJtQvdlk4oCekDsmDx+V2zAK
CCc1Fd6bouxI1NCdyaFhy6d2NUVT2EdTXSolBb3wZfB2teyEyvw2aauxUHyRfcb7
J+XpR7rlT3lK1/6t8x0/kgV7dFYu55mokCQTIaKCY+YeLITkh9bicXYn9nxmsmC0
gRs0FbdxbnQc3NI+rkVH9uIdq4ohIAQL6bPvVC1UKwJUYLQNYkcmpGHZVEogyIsR
22pnarqcOb76vfJzmg20xVXvTProM9dvW6pelJXDev1tqe5dnE48p6tHoV+clYiC
ma0/4Il47aubHY+DbGjkfRuc7amLuEqXeMVMCDGSIrQkDopv0wiErk3dg8KL4F4=
=o/K0
-----END PGP SIGNATURE-----

--REu5TK1JQu9WDulqdA6k9da1TRnStHE8s--
