From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: avoid repeated frame bug
Date: Mon, 03 Sep 2012 19:59:52 +0200
Message-ID: <5044F018.50808@pengutronix.de>
References: <1346674649-10181-1-git-send-email-mkl@pengutronix.de> <5044E54F.7020507@pouic.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9DC9F2B85AF7857552AA1C9B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50960 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab2ICR7z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Sep 2012 13:59:55 -0400
In-Reply-To: <5044E54F.7020507@pouic.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Beno=EEt?= <benoit@pouic.eu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9DC9F2B85AF7857552AA1C9B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/03/2012 07:13 PM, Beno=EEt wrote:
[...]

>> Hello Benoit,
>>
>> can you please test this patch, if it still fixes your problem. In
>> order to
>> integrate this patch into the kernel, I need you Signed-off-by [1]
>> with you
>> real name.
>=20
> I just carefully ran some before/after tests with your updated patch an=
d
> I confirm the problem is still fixed with it.

Thanks.

>=20
> As for my "Signed-off-by", here it goes:
>=20
> Signed-off-by: Beno=EEt Locher <Benoit.Locher@skf.com>

I'll change the author of the patch to that address then.

> By the way, about using spi_write()instead of mcp251x_spi_trans(): I
> innocently thought it would make less function call nesting,
> trying to improve response time of the driver particularly on my
> Raspberry Pi.

Ahh, I see. but the mcp251x_spi_trans() function takes does the setup
thats needed for DMA.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9DC9F2B85AF7857552AA1C9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBE8BgACgkQjTAFq1RaXHP0iwCfTeNel2LhIU1vCcHFEDEKiK7W
U8wAnAtVn7zJB7OAG/regefRzgp63L5k
=LnRV
-----END PGP SIGNATURE-----

--------------enig9DC9F2B85AF7857552AA1C9B--
