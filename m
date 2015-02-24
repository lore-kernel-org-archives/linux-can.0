From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: add missing initialisations in CAN related skbuffs
Date: Tue, 24 Feb 2015 09:31:34 +0100
Message-ID: <54EC36E6.10502@pengutronix.de>
References: <1424720274-3831-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hmqWSn7eD8nKnT91IM8NJAdvvHDv5KmfC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38452 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbbBXIbk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Feb 2015 03:31:40 -0500
In-Reply-To: <1424720274-3831-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hmqWSn7eD8nKnT91IM8NJAdvvHDv5KmfC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2015 08:37 PM, Oliver Hartkopp wrote:
> When accessing CAN network interfaces with AF_PACKET sockets e.g. by dh=
client
> this can lead to a skb_under_panic due to missing skb initialisations.
>=20
> Add the missing initialisations at the CAN skbuff creation times on dri=
ver
> level (rx path) and in the network layer (tx path).
>=20
> Reported-by: Austin Schuh <austin@peloton-tech.com>
> Reported-by: Daniel Steer <daniel.steer@mclaren.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks, applied to can/master, added stable on Cc.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hmqWSn7eD8nKnT91IM8NJAdvvHDv5KmfC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU7DbpAAoJECte4hHFiupUxWEQAJm7u+lTF4K+QO/GtVm4SNrQ
HZrkfTqJkoAAZnrGdXnk60hNkf8/QGz/pLm7kut1TbtnUdWze23evSqRbPNVa2ug
po6Nv8AkcO/wCbz1aY9kpbQRRGWF/fmy1he+xM7KHGq/T17Bi9ox47SGHzgQWSi6
vr+/2sdvit8/GtRvqAAyzrnZzvMeyQM611eJ8HcalxajIOwt7XJKFchTewd4C6ra
flLjmzBV3823/UhKJN+37kdmEstGSKfHt1u5f9p8HVrrEjvW+OpvY57qTIbs+hoY
NsY8KX3GLffS+4V32imtQKDU03OKZqzN7ZZ1GIgwncgo2fxFS4omEIRcuukUfqj8
y2u6OwVDIQvGYaZuQnrEC0YZDJ1uWb33Nb+CwyJgFT74x6KKBRtT5q9JckupiB9K
lT2I4bwphEDmDIS9eglRFjOe1nvr2k7Vb2n+prYMNxOLu36TBFc8LiloXUumyXLR
Eefyq5ismarW5OW8O1eENxcO+s4OexZBc11ycQ/gvIlZsHDvEhhAuLGnTIhZ5Rss
Z9gI6IG2Ctw1Ty4/8058aLXeH2aS6w3ZKarp4jGqWrYDZbEQkZEW3D9j+HfK0XvC
4bQhzBrPKC4PV6Ic0JlypiOVcN14vrgOjiLfnIeYvP2XEk7FXxCqc4k6+a1GgVVV
BKBxN8+tDqdG5huqaJ/4
=Butv
-----END PGP SIGNATURE-----

--hmqWSn7eD8nKnT91IM8NJAdvvHDv5KmfC--
