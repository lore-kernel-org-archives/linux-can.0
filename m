From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Fri, 12 Apr 2013 11:36:04 +0200
Message-ID: <5167D584.7080800@pengutronix.de>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local> <51666B21.10109@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445D@SERVEUR0.nvp.local> <516676B5.6090903@pengutronix.de> <CA78C307B8F06747967D122FC656B153774460@SERVEUR0.nvp.local> <51668741.6030909@pengutronix.de> <CA78C307B8F06747967D122FC656B153774467@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2IDNABEPRJODUBQTNIOOX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44019 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab3DLJgH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Apr 2013 05:36:07 -0400
In-Reply-To: <CA78C307B8F06747967D122FC656B153774467@SERVEUR0.nvp.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mylene Josserand <Mylene.Josserand@navocap.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2IDNABEPRJODUBQTNIOOX
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/11/2013 04:39 PM, Mylene Josserand wrote:
[...]

> I have read 15 383 frames but after 15 834, it hangs. And after that, I=
=20
> can not act on the CAN anymore. A "ifconfig can0 down" hangs the kernel=
=20
> (even with ^C) and I have to restart the board to use the CAN again !
>=20
> I really think that it is not linked to your patch (do you want me to=20
> send the "Tested by" anyway ?) but to my first problem. The kernel=20

Can I add your Tested-by to the patch? I hope the patch will go into 3.9
release.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2IDNABEPRJODUBQTNIOOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFn1YQACgkQjTAFq1RaXHNMtwCeNi9VTkuDITqwshRVWNoM1qTa
YZ8AnRHDI8EDQPFjE2Bu8G2l1tFPY07x
=a95P
-----END PGP SIGNATURE-----

------enig2IDNABEPRJODUBQTNIOOX--
