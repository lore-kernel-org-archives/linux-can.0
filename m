From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/4] URB disconnect bug fixes
Date: Wed, 6 Dec 2017 10:20:02 +0100
Message-ID: <6e61f760-67af-f4b0-0cc5-97ede53216f1@pengutronix.de>
References: <20171205191550.703-1-mkelly@xevo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mjuuQ7d7M5fVGCIWWVoOw5R2emIpx78b6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60335 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753656AbdLFJUK (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Wed, 6 Dec 2017 04:20:10 -0500
In-Reply-To: <20171205191550.703-1-mkelly@xevo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kelly <mkelly@xevo.com>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>, Jimmy Assarsson <jimmyassarsson@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mjuuQ7d7M5fVGCIWWVoOw5R2emIpx78b6
Content-Type: multipart/mixed; boundary="adpd4erE0cTeXOVVuwlUqqlNGbf7MrToq";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Kelly <mkelly@xevo.com>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>,
 Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <6e61f760-67af-f4b0-0cc5-97ede53216f1@pengutronix.de>
Subject: Re: [PATCH 0/4] URB disconnect bug fixes
References: <20171205191550.703-1-mkelly@xevo.com>
In-Reply-To: <20171205191550.703-1-mkelly@xevo.com>

--adpd4erE0cTeXOVVuwlUqqlNGbf7MrToq
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 08:15 PM, Martin Kelly wrote:
> This patch series is to fix a common bug I found in mcba_usb that appea=
rs to
> also exist in these drivers. Because I don't own the hardware, I cannot=
 test the
> changes, but I wanted to send the change so that others could do so.
>=20
> The bug is that, when you disconnect the device, you get -EPIPE and -EP=
ROTO
> error codes (exactly which depends on the timing and the system) in the=
 URB read
> callback. The driver then resubmits the URB, which immediately fails be=
cause the
> device is unplugged. On a slower system like a Raspberry Pi, this can c=
ause a
> kernel stall, while on a desktop, the disconnect code runs fast enough =
to
> prevent a stall and it's easy not to notice the issue.
>=20
> Fix this by not resubmitting an URB that receives an -EPIPE/-EPROTO cod=
e.

Applied this series and the mcba patch.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--adpd4erE0cTeXOVVuwlUqqlNGbf7MrToq--

--mjuuQ7d7M5fVGCIWWVoOw5R2emIpx78b6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlontkIACgkQHv7KIOw4
HPZhTAf/bWnVpuuCSqJ0yLNVgAzKndEjrRDtQ95ppUiCniBis88x22p5h5iA21gA
5W5gfRMC9pVVXfMHNrdR+bXEqbcpcKS/5CNIeAVG9n7o2dwNYEvGtzR+zhdprPWq
5isvyzypXHEHJ0p85MPKqt3fkXqoYADYtdk2eqkR1CcEZqo69zobYAU19/mBVRPF
siJd6bsCADGAXAbuqmcEzArIPcjfBk5FePn6EUe+wgzuzSRdX+1LpQ3NUsR877Gv
LpQrTDqY3EwC6QWbdG5yVclExiAteUEWCkZsEoMNy6/DrnmejPm4J25x04UPQ0lp
lckBkteY6UW9luO0fuAe4zjMNbC99A==
=FRMD
-----END PGP SIGNATURE-----

--mjuuQ7d7M5fVGCIWWVoOw5R2emIpx78b6--
