From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Thu, 16 May 2013 13:40:34 +0200
Message-ID: <5194C5B2.7060004@pengutronix.de>
References: <1366737302.3325.36.camel@blackbox>   <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox>  <51780336.5060800@pengutronix.de> <1366839193.7226.8.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NONVPQVURNRLTJQOTCWB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38541 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab3EPLkh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 May 2013 07:40:37 -0400
In-Reply-To: <1366839193.7226.8.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NONVPQVURNRLTJQOTCWB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/24/2013 11:33 PM, Max S. wrote:
> From 8a83080bcddc558cd016e58e408b56ca68bc5bc8 Mon Sep 17 00:00:00 2001
> From: Maximilian Schneider <max@schneidersoft.net>
> Date: Wed, 24 Apr 2013 21:03:31 +0000
> Subject: [PATCH] Added ss_usb source.
>=20
>=20
> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>

Please fix these errors, too:

> drivers/net/can/usb/ss_usb.c:343 ss_usb_set_bittiming() error: doing dm=
a on the stack (&dbt)
> drivers/net/can/usb/ss_usb.c:374 ss_usb_set_mode() error: doing dma on =
the stack (&dm)
> drivers/net/can/usb/ss_usb.c:411 ss_usb_get_state() error: doing dma on=
 the stack (&dstate)
> drivers/net/can/usb/ss_usb.c:465 ss_usb_get_berr_counter() error: doing=
 dma on the stack (&dstate)
> drivers/net/can/usb/ss_usb.c:661 ss_can_open() error: doing dma on the =
stack (&dm)
> drivers/net/can/usb/ss_usb.c:736 ss_usb_probe() error: doing dma on the=
 stack (&conf)
> drivers/net/can/usb/ss_usb.c:859 ss_make_candev() error: doing dma on t=
he stack (&bt_const)

You should not use memory on stack for usb transfers. Use kmalloc(), or
kzalloc() (and kfree) instead.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NONVPQVURNRLTJQOTCWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGUxbIACgkQjTAFq1RaXHMz2gCeISDJJPcP+UZ7vMihxiAum9bV
lG8AoIJ1ifMAVvZJnUMWMjkhUscNVbuM
=Xt1W
-----END PGP SIGNATURE-----

------enig2NONVPQVURNRLTJQOTCWB--
