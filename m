From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6] can: move can_stats.bus_off++ from can_bus_off into
 can_change_state
Date: Wed, 07 Jan 2015 16:23:46 +0100
Message-ID: <54AD4F82.6030207@pengutronix.de>
References: <b032a1c3-b80d-41a4-998b-4fe0e5a8118b@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xJjlTH9RxWigOH73hXNt6FidCJjhAc5DS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45610 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbbAGPXx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Jan 2015 10:23:53 -0500
In-Reply-To: <b032a1c3-b80d-41a4-998b-4fe0e5a8118b@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xJjlTH9RxWigOH73hXNt6FidCJjhAc5DS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/11/2014 03:15 PM, Andri Yngvason wrote:
> In order to be able to move the stats increment from can_bus_off() into=

> can_change_state(), the increment had to be moved back into code that w=
as using
> can_bus_off() but not can_change_state().
>=20
> As a side-effect, this patch fixes the following bugs:
>  * Redundant call to can_bus_off() in c_can.
>  * Bus-off counted twice in xilinx_can.

FTBFS:

> drivers/net/can/bfin_can.c: In function 'bfin_can_err':
> drivers/net/can/bfin_can.c:355:8: error: 'struct net_device_stats' has =
no member named 'bus_off'

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xJjlTH9RxWigOH73hXNt6FidCJjhAc5DS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrU+CAAoJECte4hHFiupUlSsQAJ7uKI4w64sCaQ5Mtoc99w1z
1d6f6zx4ga4TZX29eAzpUTufLdJAtc09Ox7tjNZ9bsPsOgBWfTM1UpyMiUSyJP3X
JtG7rHigYzF8paeUPFUwQsTL/RE7TIN/vLOrlvBxOhg6DjWXrwF8GZIIK5RrUSVv
yl0NWvilM5px6C1jrHTAolUsPCvX/p6qh/A1KhvfEp5ZFCXkpZSyoc0yfhYf0+AL
twGIoRSWTJrWvDBoHDnYAoTW3Ax933yPWGxDrypllAhs+aUmELdPmzpXP7S7t1yo
/GRH2arYQXq3/qKHqHdknO6VxpTVZV2+siIgnWidAWwp12M22CVJycrdXiu1v2Dq
2CRWPj2unKxPFUcl85wCqEqmuAXITIKDz5QKcDRLpvc8Aa3R9QFxP30mIG4A+vGF
NAbJZLwPPh6VSI4QGnGU1O1cpL30fjOeard+dhouhgHb9KmMyiholC4CFYRawUzN
j32DqiMMMgmUo9ZpS9u2MkApzUS8VDBWfE09D5d94LWc4q0AwpA5T55JAGO0R2z4
Shnl99EFnIJ+k5B+ciLnqAX693Cmk/jxGXVb8n0rTXjlfyiiI1nx/T3eXYpikyaK
MpBPhLaBvtydPirs6SAbaBNyX7rSD129XTRfzeu8C/IXnMybYv6U9CKqn/20dBhH
qm+A7XVtQikQGhVLwhAU
=R3Px
-----END PGP SIGNATURE-----

--xJjlTH9RxWigOH73hXNt6FidCJjhAc5DS--
