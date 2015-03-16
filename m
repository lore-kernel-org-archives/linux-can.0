From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] can: esd_usb2: Fix sparse warnings
Date: Mon, 16 Mar 2015 14:24:41 +0100
Message-ID: <5506D999.8000609@pengutronix.de>
References: <1426495709-10810-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="99fieoOsxt2uIEsDKntjxufLlMQohWAL2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54944 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbCPNYv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Mar 2015 09:24:51 -0400
In-Reply-To: <1426495709-10810-1-git-send-email-thomas.koerper@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Thomas_K=c3=b6rper?= <thomas.koerper@esd.eu>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--99fieoOsxt2uIEsDKntjxufLlMQohWAL2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2015 09:48 AM, Thomas K=C3=B6rper wrote:
> The hnd field of the structs does not need to be __le32: the
> device just returns the value without using it itself.
>=20
> Signed-off-by: Thomas K=C3=B6rper <thomas.koerper@esd.eu>

Applied to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--99fieoOsxt2uIEsDKntjxufLlMQohWAL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVBtmgAAoJECte4hHFiupUId4P/ROIUdpHQ5W7PJYNWiuBhnls
Qz3aXg8HjIPr1PUWewTyCGLKuHCPTNir20PPXppdJrZp2A3zZdJlcQCL88yx4xTN
D/otCtmwQhR20gw3p12X7prZTC2CVnKIwpt7baGolGGKvyAipAMKJKkLEGUBG9e+
zWmYoIuwUSXLqPcm6lcZBR8BKlPjqkCTbf9/GfuXP1dJbPZtiJs/wWzUNNl/fVC7
IFGoZ/zwMKtrxXDgVh6jvr7r4KFWEPnVhyKpuBVFIdz0ZsS0XzkaHgD2VvY/QF+I
LKcaaSkmWGweF6B8q3dZVSCwbLkfTUvi127tvNoItysQ3N9efzEyOCATxS8oFNA+
BxrcD6w8dQ2etRliJE2dO54hI0sz6nCQ5BNIJAzKdhs9us+l7VjSs5u4wa6g27Zu
BiNDfNbne/cGbRCwm7DII9NrOSrx93Y2xut05MttL8eWdc6jCPgPp+6aLxw4F7hY
hTZzFq6VrEWlb2MLyO9tc6AUgYvNg8x8CVSNSzIufkOkZsc6aEjeZAmqo8Zc+AZz
ebqhf+VWs0oQEPY23IksAd0XdsQJ60hC5jPUx8uAgAUnpxo9oZOPKsqMtWHM12MQ
smW4IzTD3uLV4cb3Itrwwj+pG0ZJRFk2XuOSTcfAfc0SsszTy4W8FHbJcDPqZQqy
I7sGxkct0ZdVkTIqXPdC
=0e5t
-----END PGP SIGNATURE-----

--99fieoOsxt2uIEsDKntjxufLlMQohWAL2--
