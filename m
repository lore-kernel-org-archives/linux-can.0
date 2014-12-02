From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/3] can/peak_usb: CAN-FD: existing source files modifications
Date: Tue, 02 Dec 2014 13:14:29 +0100
Message-ID: <547DAD25.10706@pengutronix.de>
References: <1417516314-17486-1-git-send-email-s.grosjean@peak-system.com> <1417516314-17486-2-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oCVe9lq0xAOfqhlFaA9ET0jSvqxAGjTfa"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59383 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932556AbaLBMOo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 07:14:44 -0500
In-Reply-To: <1417516314-17486-2-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oCVe9lq0xAOfqhlFaA9ET0jSvqxAGjTfa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/02/2014 11:31 AM, Stephane Grosjean wrote:
> This patch does some modifications to the existing files that support t=
he
> PEAK-System Technik CAN 2.0b USB adapters, for preparing the support of=
 CAN-FD.
>=20
> In particular, this patch changes some static identifiers into global o=
nes, to
> share common functionalities with the further incoming CAN-FD specific =
source
> files.

Have you read my review of the v1?
https://www.marc.info/?l=3Dlinux-can&m=3D141712364917425&w=3D2

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oCVe9lq0xAOfqhlFaA9ET0jSvqxAGjTfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfa0lAAoJECte4hHFiupU9MIQAJ+fNjXKUpu+/szKVzECCxwL
Yz1wsJwLxsyREpABaQdmBZJwYHUPkckhDLFmoo0XZPoYitNxsuAGlfD3uFB7zZhe
BXU96apsTGtcWrHOzTygM18B4RMElf+xQGRABV82VohpAX8vc127f5uaJ5LY+nOE
IWeueVg/5ikx0kXTPIhE4xxthckbLLn/8qtyMH7VumLwIaGeVO/l1+sMbGDX37Sn
kIEoMs59NALwWQ1AuKJOOoy8SIKQX3Mx7/YBCMaEP5rH7NRkNLrN2hsUfJgx3pWj
rL+Hc6hFSMFL+3LmiqFxEmE5YFs5j0ZlXQpGXSoFiKBPg4wO7/sJHAUkJoqMJpYM
yTeZCtAJFqOpttBRSWhWF6PXulc6kEwDPzPAc7UJ5CgZNpI86b9CjvBmmcUj0NcJ
cIVcTG+A+h9g8ZghklbZ6mcJBz2jIBfYcEeG0VRfrARt5tCZA3xux38dAU84+WQ8
KkA8jpDEsuNEZHKWoA6Mn3CLz7Njz8sImn6mGW6k5SzY+IGqw8NCVt340oaj2Com
jjzm6Ec4TrObqAEz/h0NibZoTcgYD9UBBIHvWgJFZXQyNszFQgsBF8/XBvkoLvLE
bUMflrVE5qrkvsv4boHPo4NPQFKZRJzc1SWugpxD9Zg/FGA03+L+wAEkEhKa25JY
xkqaMHY9Vl5cgwJgZMsH
=ojXL
-----END PGP SIGNATURE-----

--oCVe9lq0xAOfqhlFaA9ET0jSvqxAGjTfa--
