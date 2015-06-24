From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] treewide: use if_nametoindex to avoid overflows
Date: Wed, 24 Jun 2015 20:25:36 +0200
Message-ID: <558AF620.5070800@pengutronix.de>
References: <1435170124-18081-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="S8BgDstXqrIM8QO6vBT5xJqBKvAc9oLI5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45468 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbbFXSZ7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Jun 2015 14:25:59 -0400
In-Reply-To: <1435170124-18081-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Sven Schmitt <sven.schmitt@volkswagen.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S8BgDstXqrIM8QO6vBT5xJqBKvAc9oLI5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Sven,

Thanks for your contribution. I forwarded your patch to the linux-can
mailinglist.

On 06/24/2015 08:22 PM, Marc Kleine-Budde wrote:
> From: Sven Schmitt <sven.schmitt@volkswagen.de>
>=20
> replaced strcpy(if_name, argv[x]) by if_name=3Dif_nametoindex(argv[x]) =
to avoid
> overflows caused by long user input.
>=20
> Waiting for Sob: Sven Schmitt <sven.schmitt@volkswagen.de>
> Not-yet-Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Can I add your S-o-B here? What S-o-B means is explained here [1].

Patch looks good, but the compiler throws a warning here:

> cc -O2 -Wall -Wno-parentheses -fno-strict-aliasing -Iinclude -D_FILE_OF=
FSET_BITS=3D64 -DSO_RXQ_OVFL=3D40 -DPF_CAN=3D29 -DAF_CAN=3DPF_CAN   isotp=
server.c   -o isotpserver
> isotpserver.c: In function =E2=80=98main=E2=80=99:
> isotpserver.c:140:15: warning: unused variable =E2=80=98ifr=E2=80=99 [-=
Wunused-variable]
>   struct ifreq ifr;
>                ^

Marc

[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L407=


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--S8BgDstXqrIM8QO6vBT5xJqBKvAc9oLI5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVivYgAAoJEP5prqPJtc/HQHsH/RKY34sP452e/rHpxvNL/UXa
XxFGUtpZpkS8+A1afZd6Y1OIo/dcyGGFlaK/Zcf7KXVLcd+Nkcmf1DPnAuei+UKZ
//nDdb7yiFWZXmFG0ywYhnvwk8Bhlxhkcz4EoaOblGLGZWY5JOXujxQvHh/aTJd9
3zHIyu7v4xuaE5J4bHIIO8xPnwz/c+nJX1YVTTflk005FZ/Lc/7ig6u2HBlfcNpH
skua4njso6tdaNStLQZQafL1Q83m9WM7hhTmbBI8r+RM7i7jBBFD1DyPNhC26dcV
fDkKmHb79xuBwo1Upa9yVXpTRR1CiwOSplABLo0eyU7ZVFlPL9Z3HJdaZxks9MQ=
=YOmt
-----END PGP SIGNATURE-----

--S8BgDstXqrIM8QO6vBT5xJqBKvAc9oLI5--
