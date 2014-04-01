From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/3] CAN: moved SPI drivers into a separate directory
Date: Tue, 01 Apr 2014 23:08:04 +0200
Message-ID: <533B2AB4.2000300@pengutronix.de>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de> <1395757822-22283-3-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VXdgQ7JQE1aBjhTBi3JvIGHoEea9p1fEM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53028 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaDAVIH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 17:08:07 -0400
In-Reply-To: <1395757822-22283-3-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VXdgQ7JQE1aBjhTBi3JvIGHoEea9p1fEM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/25/2014 03:30 PM, Stefano Babic wrote:
> Create a directory for all CAN drivers using SPI
> and move mcp251x driver there.
>=20
> Signed-off-by: Stefano Babic <sbabic@denx.de>

Applied to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VXdgQ7JQE1aBjhTBi3JvIGHoEea9p1fEM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM7KrQACgkQjTAFq1RaXHMTEQCfcbyLZyX93bDnMe0lJRqs1rEU
QVIAoJF3PTB4fTdaNiA/4W9jkJhF906v
=It6N
-----END PGP SIGNATURE-----

--VXdgQ7JQE1aBjhTBi3JvIGHoEea9p1fEM--
