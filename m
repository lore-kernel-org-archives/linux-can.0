From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 14:40:37 +0200
Message-ID: <4FC61545.2020504@pengutronix.de>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <4FC60FA7.2000600@pengutronix.de> <jq53rt$uqu$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1E8A865EF89675DEA79A9A4C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44871 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab2E3Mkj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 May 2012 08:40:39 -0400
In-Reply-To: <jq53rt$uqu$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E8A865EF89675DEA79A9A4C
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On 05/30/2012 02:29 PM, Martin Kozusky wrote:
>> Have you debugged which component is dropping frames? Is it the hardwa=
re
>> or the socket because your application is to slow?
>=20
> I tried to solve this 19.4.2012 (thread "CAN messages being lost on
> i.MX25 with flexcan") and when I changed rcvbuf_size to 10000000 it

Oh, I see, this conversation slipped my mind.

> helped, but still sometimes few CAN frames are dropped (and many more
> when I try to write to SD card or internal flash). So I think it's not
> HW problem.
> The best for me would be some kernel module which would just put the CA=
N
> frame into some big "from userspace available" buffer in the interrupt
> and nothing more. My app would check if there is anything new and read
> it out.
> There are around 1500/sec (at 250kbit) can frames on the bus when the
> problem arise, I think it's not that much.

Are you writing the can frames to storage in the same thread as
receiving them?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1E8A865EF89675DEA79A9A4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/GFUUACgkQjTAFq1RaXHPP9ACeNQ3yGzeWvqVyE1PUpru/oKio
DP4An0pZmllRDDwj4yLrYg2CfD2/E6/B
=/Y29
-----END PGP SIGNATURE-----

--------------enig1E8A865EF89675DEA79A9A4C--
