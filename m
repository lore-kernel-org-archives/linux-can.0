From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: gs_usb: Modify the usb device table to use only the
 first usb interface
Date: Sun, 8 May 2016 19:53:02 +0200
Message-ID: <572F7CFE.60707@pengutronix.de>
References: <1461574459.1383.10.camel@schneidersoft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rSxkCFUf4Pftu9VND24h0XtWow84vLIVB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46019 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849AbcEHRxJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 May 2016 13:53:09 -0400
In-Reply-To: <1461574459.1383.10.camel@schneidersoft.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maximilian Schneider <max@schneidersoft.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rSxkCFUf4Pftu9VND24h0XtWow84vLIVB
Content-Type: multipart/mixed; boundary="ds39Vja8uFglbc4rq6STnckBpE2r7jaO7"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maximilian Schneider <max@schneidersoft.net>, linux-can@vger.kernel.org
Message-ID: <572F7CFE.60707@pengutronix.de>
Subject: Re: [PATCH] can: gs_usb: Modify the usb device table to use only the
 first usb interface
References: <1461574459.1383.10.camel@schneidersoft.net>
In-Reply-To: <1461574459.1383.10.camel@schneidersoft.net>

--ds39Vja8uFglbc4rq6STnckBpE2r7jaO7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2016 10:54 AM, Maximilian Schneider wrote:
> From 24680c50e6b07292e7ee6ebfec0a826a32d5bcb9 Mon Sep 17 00:00:00 2001
> From: Maximilian Schneider <max@schneidersoft.net>
> Date: Sun, 24 Apr 2016 01:10:01 +0000
> Subject: [PATCH] Modified the USB device table to use only the first US=
B
>  interface, as is the case with GS USB devices. This allows other GS US=
B
>  compatible devices to be more flexible with their remaining interfaces=
=2E
>=20
> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>

Applied to can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ds39Vja8uFglbc4rq6STnckBpE2r7jaO7--

--rSxkCFUf4Pftu9VND24h0XtWow84vLIVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXL3z+AAoJED07qiWsqSVqBrsH/RcvOlEhUScqWTP58O7jTBZ8
1kVGgut0QXkW21qY1q1r/b3pG1K58au/0lMbS2HM/E9mFyJXUDaEL1FdlaXuopsD
q0XhDWgInXDzR/fH30mh17jcrlVQM1ppagDIZiXRTC67fD1CPPPwhCpzSoEKdaFa
DqFbFYgV1UYN3Srgf91xzOlHGsvIkINQQyX686JEjsU0DSLcZZsjJhwWl8FuQivY
vnFbRoFU3rrNcOUB9SY3p0wWQjl1y1izlwKshPSut2xB3fPIIoseInwBfH77tExi
NrOqk5L+MBpbn8m+sX0/Zg8nYFupZwmwZZ7vBMAnnq4MJlws90HlMXui0BkSx80=
=Vmn7
-----END PGP SIGNATURE-----

--rSxkCFUf4Pftu9VND24h0XtWow84vLIVB--
