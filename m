From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
Date: Sun, 10 Jun 2012 19:46:00 +0200
Message-ID: <4FD4DD58.3070302@pengutronix.de>
References: <1338849280.43608.YahooMailNeo@web140802.mail.bf1.yahoo.com> <1338849547.86575.YahooMailNeo@web140805.mail.bf1.yahoo.com> <1338852261.93934.YahooMailNeo@web140802.mail.bf1.yahoo.com> <4FCDB93D.5030007@pengutronix.de> <1339086557.44691.YahooMailNeo@web140804.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig36CBE16ADD775434A8B5E563"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39784 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab2FJRqE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 10 Jun 2012 13:46:04 -0400
In-Reply-To: <1339086557.44691.YahooMailNeo@web140804.mail.bf1.yahoo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Keith Jones <keith.rjones@yahoo.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36CBE16ADD775434A8B5E563
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/07/2012 06:29 PM, Keith Jones wrote:
>> Use v3.4. Your v2.6.35 is probably a freescale kernel, with a freescal=
e
>> flexcan driver. The mainline driver should work with mx53.
>=20
> Dropping "drivers/net/can"  and supporting headers from 3.4 into
> 2.6.35 distro causes rippling compilation inconsistencies. The

I see.

> infrastructure has changed in the 3+ tree.  We would like to continue
> using 2.6.35 with upgraded flexcan, but the linux source tree
> dependencies for 3.4 support are significant.  On the other hand,
> building a complete 3.4 image for imx_ard would be an effort we wish
> not to undertake at this moment.

> How best to get 3.4 flexcan functionality into 2.6.35?

Port the 3.4 flexcan driver to you 2.6.35 Kernel.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig36CBE16ADD775434A8B5E563
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/U3VgACgkQjTAFq1RaXHMjcQCgjeppnXqH1Md42Jw0VspgDb8d
wuEAnRHk2XerjvMmg5rmXClKS5a5SDhK
=5w3h
-----END PGP SIGNATURE-----

--------------enig36CBE16ADD775434A8B5E563--
