From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Fri, 07 Dec 2012 11:09:12 +0100
Message-ID: <50C1C048.4080708@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4036287.fuKZ6k5idx@ws-stein> <50C0AC38.8080405@grandegger.com> <9545085.epYbjMqEeA@ws-stein> <50C12B77.1060501@pengutronix.de> <50C1B64D.8030209@grandegger.com> <50C1BD1C.9090108@pengutronix.de> <D5ECB3C7A6F99444980976A8C6D896384FB4B25519@EAPEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A18F4CD088D1B916DC7A630"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49632 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab2LGKJT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Dec 2012 05:09:19 -0500
In-Reply-To: <D5ECB3C7A6F99444980976A8C6D896384FB4B25519@EAPEX1MAIL1.st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bhupesh SHARMA <bhupesh.sharma@st.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "tomoya.rohm@gmail.com" <tomoya.rohm@gmail.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A18F4CD088D1B916DC7A630
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/07/2012 11:00 AM, Bhupesh SHARMA wrote:
>> We have at least 3 drivers with the same algorithm. I'm thinking if
>> it is possible to create a library helper for this.
>>=20
>=20
> A library helper seems sensible, but don't forget that different
> cores have different priority schemes (higher to lower and lower to
> higher) when they service RX packets, so the library helper should
> also accommodate this.

Sure. There are some quite sophisticated abstractions in the kernel,
like irq chips, that I should look at.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3A18F4CD088D1B916DC7A630
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDBwEsACgkQjTAFq1RaXHMrgQCfU76tWOCqpaziAMe0x1BRw6zy
WiUAnjoqPkoPkc0sbixxI6ZgnonKBJ6k
=mpCi
-----END PGP SIGNATURE-----

--------------enig3A18F4CD088D1B916DC7A630--
