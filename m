From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CANutilities
Date: Wed, 15 May 2013 10:57:35 +0200
Message-ID: <51934DFF.40700@pengutronix.de>
References: <CANdmM3MkAN9tZLUDSnVrdXTngu7CH5UESUAo7NO4u85D0Hg2tQ@mail.gmail.com> <5193360F.3040609@pengutronix.de> <CANdmM3Mo0q7OpX5-ScnLhtWGEiPBvgeKx9SPe=+KBeABodP46g@mail.gmail.com> <51933C8A.1040404@pengutronix.de> <CANdmM3OizYxY3dhUN=h2+TGmTa3D31fuXNLb5Mw9S3Lts_cpkw@mail.gmail.com> <51934649.2000103@pengutronix.de> <CANdmM3NqyKWPxrN0xZyvFzGo9trPO5ZPMtSvSMjfQf2vDcioLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2JTGBDWWWCXAXLRESLDUD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54099 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab3EOI5l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 04:57:41 -0400
In-Reply-To: <CANdmM3NqyKWPxrN0xZyvFzGo9trPO5ZPMtSvSMjfQf2vDcioLQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kedari appana <kedare06@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2JTGBDWWWCXAXLRESLDUD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/15/2013 10:52 AM, kedari appana wrote:
> if i try without triple sampling on
> and just this command #./canconfig can0 bitrate 100000 ctrlmode  loopba=
ck on
>=20
> 1c
> can0 bitrate: 100000, sample-point: 0.875
> RTNETLINK answers: Operation not supported
> can0: failed to set ctrlmode
> the same error i am getting what was the issue.

Does your hardware/driver support loopback mode?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2JTGBDWWWCXAXLRESLDUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGTTgMACgkQjTAFq1RaXHMKDACdFavRn+PDFF8+5TsKbu5iuHab
cK0An3c0vyoXrYiUDUVZer4+BJu0YQTD
=Ecs7
-----END PGP SIGNATURE-----

------enig2JTGBDWWWCXAXLRESLDUD--
