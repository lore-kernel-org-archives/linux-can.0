From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH next 1/2] net: can: mscan: add a comment on reg to idx
 mapping
Date: Fri, 23 Aug 2013 09:30:55 +0200
Message-ID: <52170FAF.7040508@pengutronix.de>
References: <1377208917-16698-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lJUxDOIVI5vpTQIIJfVjfB2FwVsDr9rPG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35771 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444Ab3HWHbU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 Aug 2013 03:31:20 -0400
In-Reply-To: <1377208917-16698-1-git-send-email-agust@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anatolij Gustschin <agust@denx.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Gerhard Sittig <gsi@denx.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lJUxDOIVI5vpTQIIJfVjfB2FwVsDr9rPG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2013 12:01 AM, Anatolij Gustschin wrote:
> From: Gerhard Sittig <gsi@denx.de>
>=20
> add a comment about the magic of deriving an MSCAN component index
> from the peripheral's physical address / register offset
>=20
> Cc: linux-can@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Anatolij, I'm missung your S-o-b here. Can you repost both patches?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lJUxDOIVI5vpTQIIJfVjfB2FwVsDr9rPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIXD7MACgkQjTAFq1RaXHOZgACfdC2+4nOFrtUl9JOoT7nA7xw6
RVkAmwSyhkeaIDeMui0VGHghYTYbZbPa
=Zsbs
-----END PGP SIGNATURE-----

--lJUxDOIVI5vpTQIIJfVjfB2FwVsDr9rPG--
