From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: add documentation about CAN FD controller specific
 configuration
Date: Thu, 17 Sep 2015 22:32:15 +0200
Message-ID: <55FB234F.1090008@pengutronix.de>
References: <1442519926-4506-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mbV5V7KErpWcf6NuihRMLo1AuHnBeH64m"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38656 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbIQUcX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Sep 2015 16:32:23 -0400
In-Reply-To: <1442519926-4506-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mbV5V7KErpWcf6NuihRMLo1AuHnBeH64m
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/17/2015 09:58 PM, Oliver Hartkopp wrote:

Please give short commit message.

> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  Documentation/networking/can.txt | 75 +++++++++++++++++++++++++++++---=
--------
>  1 file changed, 55 insertions(+), 20 deletions(-)
>=20
> diff --git a/Documentation/networking/can.txt b/Documentation/networkin=
g/can.txt

Please add Jonathan (Cc'ed) for the next round, he usually takes
Documentation related patches.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mbV5V7KErpWcf6NuihRMLo1AuHnBeH64m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV+yNPAAoJEP5prqPJtc/H97gIALFg9N+3VvW9HeQ77OQspQEY
UZVK9cwQUJg6K08AzpM4jr6Wc7g659vGBRlVtvhvpVWVrXPBfdwFeSZaLKP9jzvU
CaatV9B6WdpzT3F1G8OpVYdnOgg8wf4AdO8nfvGMH4bwL3wDH/mKr+Kd4lEB4Dpz
38tBxelHfngyG4oBvWdzbVkuQ+YF91CuqH/nDlCRcwz86C4RshUmFqbKp3KQZPDO
yiOMEwfBwRsYyOK1la0rzm3DiDkcnW57MnG3RzlAg314A74t4IXDvHNoMpFJy8Lr
fftKQJ1QFxdHuzSpTlKXFHrbODWmMwt+mxm87kEsi0BzWdQJDek5tVeY/T+ErQ4=
=e4qT
-----END PGP SIGNATURE-----

--mbV5V7KErpWcf6NuihRMLo1AuHnBeH64m--
