From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Mon, 09 Dec 2013 22:07:24 +0100
Message-ID: <52A6310C.1000703@pengutronix.de>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <52931051.90502@pengutronix.de> <CANGgnMYPm7yJOrhb-6Jg1LANk4D40p=UhCBx0Nu=JEbAaUuAeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IOkuHTmtlCWE6nJMuVC0650xBMNUGB2cP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57139 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761557Ab3LIVHf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2013 16:07:35 -0500
In-Reply-To: <CANGgnMYPm7yJOrhb-6Jg1LANk4D40p=UhCBx0Nu=JEbAaUuAeg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IOkuHTmtlCWE6nJMuVC0650xBMNUGB2cP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/09/2013 08:48 PM, Austin Schuh wrote:
> Hi Marc,
>=20
> I have applied the patch.  I ran a test with 75% bus load @500000
> bits/sec (15% sending from the SJA1000 and 60% from another device on
> the bus, running candump can1 to grab the data).  It failed within
> minutes.  I'll add the code back in to disable tracing when the IRQ
> gets disabled.

Does the patch make any difference at all?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IOkuHTmtlCWE6nJMuVC0650xBMNUGB2cP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKmMRAACgkQjTAFq1RaXHNWYQCfQBojbd5t1VpWFKnHWRaZvLWK
mKEAoI7jfvLMoidKamJdIYsRUH0wZFyx
=XnYg
-----END PGP SIGNATURE-----

--IOkuHTmtlCWE6nJMuVC0650xBMNUGB2cP--
