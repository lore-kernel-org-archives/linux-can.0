From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: update documentation wording error frames -> error
 messages
Date: Tue, 08 May 2012 22:38:25 +0200
Message-ID: <4FA98441.8090308@pengutronix.de>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de> <4FA98011.3020600@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD4041C0DC8E5B6FAB8035D33"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37782 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab2EHUib (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 May 2012 16:38:31 -0400
In-Reply-To: <4FA98011.3020600@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4041C0DC8E5B6FAB8035D33
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/08/2012 10:20 PM, Oliver Hartkopp wrote:
> As Heinz-Juergen Oertel pointed out 'CAN error frames' are a already de=
fined
> term for the CAN protocol violation indication on the wire.
>=20
> To avoid confusion with the error messages created by CAN drivers avail=
able
> via CAN RAW sockets update the documentation and change the naming from=

> 'error frames' to 'error messages' or 'error message frames'.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Sounds reasonable. Heinz-J=FCrgen, can I add your Acked-by: to this patch=
?
It means that you've read the patch and think this is a good change.

Marc

P.S.: Oliver, try to use: "git send-email", it much easier for you to
send patches than to copy/paste it to thunderbird.

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD4041C0DC8E5B6FAB8035D33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+phEQACgkQjTAFq1RaXHOu8ACeN3gr0ebUaoHaXWzjEkuk+Jxu
uVYAniV3f41ysocyygXLfq+X7YSiSYpI
=k1Hc
-----END PGP SIGNATURE-----

--------------enigD4041C0DC8E5B6FAB8035D33--
