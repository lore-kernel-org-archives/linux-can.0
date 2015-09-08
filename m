From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: socket can receive order
Date: Tue, 8 Sep 2015 13:20:42 +0200
Message-ID: <55EEC48A.6000705@pengutronix.de>
References: <55EEAD8D.3070603@engineeredarts.co.uk>
 <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk>
 <55EEC2BD.6010302@pengutronix.de> <55EEC3C0.1010002@engineeredarts.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DVDMfOxf3xRPcBfV6NcdXNnckxKE5SDUc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59655 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbbIHLUv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 07:20:51 -0400
In-Reply-To: <55EEC3C0.1010002@engineeredarts.co.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Squires <dan@engineeredarts.co.uk>, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DVDMfOxf3xRPcBfV6NcdXNnckxKE5SDUc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2015 01:17 PM, Daniel Squires wrote:
>> The kernel module "produces" the CAN frames, so if you see them in the=

>> correct order in wireshark, they have left the module in the right ord=
er.
>=20
> Sorry , I should have been clearer here, in wireshark was looking at th=
e=20
> USB frames not the CAN frames. however I think what you say still stand=
s=20
> due to the time stamps being in the correct order.

Thanks for the clarification. Can you have a look at the CAN interface
with wireshark, too?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DVDMfOxf3xRPcBfV6NcdXNnckxKE5SDUc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV7sSKAAoJEP5prqPJtc/HYHMH/RYSixmNudbweRkNUoX7YHF+
XCo6J/m+v4vOsoIYGwy/Wxg2VaAo08goUu/KGhQjT6uueFWUd2WLwE92cfq7ckz+
kXvnsHtbhFa96h0atETHqb2JBG/jdWSrn7UKA+Lt3QTfBlbqRDE88bnLZeAV2cge
6YIal3eOS458wwxNgKww/scuoqpA1rfKesnfbWY38FKJfBEBM05S98GIOFSc3zRg
sVcrfjyd9vd5j7eZ/kiS9c4IyqGrKVjuDG5kYUbpeZj3AfF48uqR5Za4oi6ct7hX
rApjlcVULK3mcnMCnx6LTWxlQArbSjL6FE9baD9fJKdYbue0SRlnaP5B8P97FHo=
=LWLG
-----END PGP SIGNATURE-----

--DVDMfOxf3xRPcBfV6NcdXNnckxKE5SDUc--
