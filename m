From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Can't start ESD CAN-USB/2
Date: Fri, 31 Jan 2014 18:26:42 +0100
Message-ID: <52EBDCD2.6000301@pengutronix.de>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="A0iTUT4B8WLxLLoTxGQrkwNmINcXeEPaB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53667 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbaAaR0s (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 12:26:48 -0500
In-Reply-To: <52EBD794.3020503@iit.it>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Giovannini <francesco.giovannini@iit.it>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A0iTUT4B8WLxLLoTxGQrkwNmINcXeEPaB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2014 06:04 PM, Francesco Giovannini wrote:
> I tried #canconfig can0 bitrate 1000000
>=20
>    can0 bitrate: 1000000, sample-point: 0.750
>=20
> I am however still unable to successfully start the can0 interface with=

> # ifconfig can0 up. Same error shows up.

What's the outout of "canconfig can0" after "canconfig can0 bitrate 10000=
00"

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--A0iTUT4B8WLxLLoTxGQrkwNmINcXeEPaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLr3NIACgkQjTAFq1RaXHM3oQCeNHi6w7rdoIJlmooJDgF7Z3ot
troAniuFuVnF+rXiZrdVrlcZlXnpqPjS
=lgLo
-----END PGP SIGNATURE-----

--A0iTUT4B8WLxLLoTxGQrkwNmINcXeEPaB--
