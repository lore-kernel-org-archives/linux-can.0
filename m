From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: fix assignment of error location in CAN error
 messages
Date: Mon, 23 Nov 2015 09:47:32 +0100
Message-ID: <5652D2A4.6070508@pengutronix.de>
References: <1448127681-8533-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VibqHEwOLCU2uX7XPopmwJ1xBIJtGwaDD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57346 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbbKWIrp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Nov 2015 03:47:45 -0500
In-Reply-To: <1448127681-8533-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: dan.carpenter@oracle.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VibqHEwOLCU2uX7XPopmwJ1xBIJtGwaDD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/21/2015 06:41 PM, Oliver Hartkopp wrote:
> As Dan Carpenter reported in http://marc.info/?l=3Dlinux-can&m=3D144793=
696016187
> the assignment of the error location in CAN error messages had some bit=
 wise
> overlaps. Indeed the value to be assigned in data[3] is no bitfield but=
 defines
> a single value which points to a location inside the CAN frame on the w=
ire.
>=20
> This patch fixes the assignments for the error locations in error messa=
ges.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied both to the can tree.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VibqHEwOLCU2uX7XPopmwJ1xBIJtGwaDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWUtKnAAoJEP5prqPJtc/HqjgH/3ow/pFX3Buh0k8f9Z433bfQ
CYYhB4HizGHlW5TlR56gXdEOqn3AyA6pW47csfdDI1QXhTxG/qCxahg3bAKCQb3I
5IT/7DtXSWsgNXI+BwVaWUoF9NjHG4IcU3RldJs5GM4Gd/iV/xSvEt8aBrGoKoCH
QVKE15Zj7Tu6cnVvWf4IXDgivRNKhQ5LV8mzaoUDPb0iE6Z/V3Qej2lR+GefTbVG
7wwRRNJNw/QyQm0DI9yJIZzxSvexFEm7MXH794axwRdkksrGPkEwxt0NmoNfVoOL
8acFMCYTbrX3iPW7yQSepTetrDBeOSpNexlW3P+QELtudastS/fJ8Fi+66maYMw=
=/5iF
-----END PGP SIGNATURE-----

--VibqHEwOLCU2uX7XPopmwJ1xBIJtGwaDD--
