From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: ems_usb: endianess warning
Date: Sat, 14 Mar 2015 15:30:56 +0100
Message-ID: <55044620.60903@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lRAWIlU7iUsmuxknRRnQVwTNPUL9n3XfK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50766 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbbCNObA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Mar 2015 10:31:00 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Sebastian Haas <haas@ems-wuensche.com>, Sebastian Haas <dev@sebastianhaas.info>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lRAWIlU7iUsmuxknRRnQVwTNPUL9n3XfK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

when compiling with sparse (make C=3D2), the ems driver throws the
following warning, can someone, preferred the driver author :), take
care of fixing them?

> drivers/net/can/usb/ems_usb.c:312:22: warning: cast to restricted __le3=
2
> drivers/net/can/usb/ems_usb.c:787:29: warning: incorrect type in assign=
ment (different base types)
> drivers/net/can/usb/ems_usb.c:787:29:    expected unsigned int [unsigne=
d] [usertype] id
> drivers/net/can/usb/ems_usb.c:787:29:    got restricted __le32 [usertyp=
e] <noident>

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lRAWIlU7iUsmuxknRRnQVwTNPUL9n3XfK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVBEYgAAoJECte4hHFiupU6JsP/1/GVY7x3vnP7eZlVuI84c7T
m2KWQZcOSeXuF8XOEwxRsHYMmzkSILQ76MpszWqPzEMYveMUVEch5BUka4av2J/d
G4u8xDi6R0b4VBukkK9waJGFgfadgiochIpCoLNepF1jBtOTBoOJKjxZDLj81k/p
dz/ZOqxXpDhTf0L9F1sB7BGDj8Oav5B8ZUiFl6AmBs5tN/4cDGak3b3JxWuxMQCw
TxkpZyV5fiduvaJ9BI27Am9Qjk40Rg/2lpO+3zIt45TIxcuzyAS3tT4HTiALnkeU
Kj6IWUti5PkOH4EXN8WuTw6c9QywonRHDafbNhHtSKkZY5gDorofFiAhVmjwBBjC
d+eCnUtG2mhylp9Tf0UFNGQhts7ob2VpiGuzgec/md09aHfHN40Ml3CTXmIpKmmy
MqbirxYYCtlFQHdFAHR3GiR2zZxd37RRNRrs2gGg66UcsxTic/OICbDjGwbGQgOt
GADHhCckwZC/p6rVGdE+M46DqEfR2Pc28ujN+i/RzuIZ7N8EgrX3BqfYEOt+9/vb
oSEcRnJ+xHsjcs0bh56/pqBEpm/Bow6KgYaXA2wC/BSo6oNF34/wd5rJsyUqhrQA
ivO3QXweF6GAoaK4NpNK+uFr6HzQ0gkR+PHRv6mcy+l7ptpiloxmdxbGYrc4RPh0
TvDzqr5HU0YR/sxajp/W
=JMvQ
-----END PGP SIGNATURE-----

--lRAWIlU7iUsmuxknRRnQVwTNPUL9n3XfK--
