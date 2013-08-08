From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] pcan_usb: fix wrong memcpy() bytes length
Date: Thu, 08 Aug 2013 11:56:48 +0200
Message-ID: <52036B60.7090701@pengutronix.de>
References: <1375951951-18507-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Kkd2Ip8mFWkbHMSRuFABbaIlvIFcc9DsU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56689 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757709Ab3HHJ47 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Aug 2013 05:56:59 -0400
In-Reply-To: <1375951951-18507-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kkd2Ip8mFWkbHMSRuFABbaIlvIFcc9DsU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2013 10:52 AM, Stephane Grosjean wrote:
> Fix possibly wrong memcpy() bytes length since some CAN records receive=
d from
> PCAN-USB could define a DLC field in range [9..15].
> In that case, the real DLC value MUST be used to move forward the recor=
d pointer
> but, only 8 bytes max. MUST be copied into the data field of the struct=

> can_frame object of the skb given to the network core.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Looks like a candidate for stable, doesn't it?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Kkd2Ip8mFWkbHMSRuFABbaIlvIFcc9DsU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIDa2YACgkQjTAFq1RaXHP7IwCeIxFsQxXzBn+26cGka9SxACO0
jogAn3AZRMvQwC/o88ZX5g/eXshlZf6U
=NFeJ
-----END PGP SIGNATURE-----

--Kkd2Ip8mFWkbHMSRuFABbaIlvIFcc9DsU--
