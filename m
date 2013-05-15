From: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen?= Oertel <hj.oertel@t-online.de>
Subject: Re: CAN driver for the Holt HI-3110
Date: Wed, 15 May 2013 15:11:29 +0200
Message-ID: <4792173.AorC3MCra4@heinz.site>
References: <5039321.EyQMEif55R@heinz.site> <519337CE.1010505@pengutronix.de> <51933826.80205@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1522417.xL2hePzdjz"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56959 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab3EONLp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 09:11:45 -0400
In-Reply-To: <51933826.80205@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org


--nextPart1522417.xL2hePzdjz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch 15 Mai 2013, 09:24:22 schrieb Marc Kleine-Budde:
> On 05/15/2013 09:22 AM, Marc Kleine-Budde wrote:
> > On 05/15/2013 12:18 AM, Heinz-J=FCrgen Oertel wrote:
> >> does someone know if it exists for the Holt Integrated Circuits In=
c.
> >> CAN controller HI-311[03]? It has an SPI host interface.
> >> http://www.holtic.com/documents/371-hi-3110_v-rev-dpdf.do
> >=20
> > I don't think so. The only mainline spi driver is for the mcp251x.
>=20
> And it's sloooow. Don't use an SPI CAN controller if possible. Do you=

> have the option to use an USB CAN adapter instead?
>=20
> Marc

I know :-)
but at least the HI-3110 has a bigger receive FIFO.

--=20
mit freundlichen Gr=FC=DFen
       Heinz-J=FCrgen Oertel
--nextPart1522417.xL2hePzdjz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJRk4mHAAoJENViPQy9fcm7goIIAOZT+4a//5Fji6w1XVjvmDWj
jQGnfP9AGa6DAHfzTB4eOLaK84FDuH3/YSX3D06P2OC1xiVQvMS7VqMDeCC1C/B9
GAYshA0damQkAfmZUdn2RIYyceMUf+i3Yc4gli3wvp8sqP6QBfnrf0uBUp2XIRdU
WD817VEU8vbD5Vo1MmHHc+jcUwl9aSgGUdbaKY7qYlNoaVgeNsGfHPnurmLxZi7y
rRLEV9Cn2vQO3mhZq9KSER10GyZLjhwI8mmbvlJUWCcFkTbNqh9+MmDygNpVqz/5
vIHZ748wKicGSkSpBzKi+kOL8KPPtJh+8X8nOu/A6kM9/FHpqn8M1G1mue37vJA=
=4s8z
-----END PGP SIGNATURE-----

--nextPart1522417.xL2hePzdjz--

