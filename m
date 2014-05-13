From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCHv3] C_CAN: hwinit support for non-TI devices
Date: Tue, 13 May 2014 15:36:21 +0200
Message-ID: <53721FD5.50508@pengutronix.de>
References: <1398716449.836.4.camel@dinh-ubuntu> <20140428211505.GA28242@amd.pavel.ucw.cz> <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com> <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com> <20140430215359.GA15148@amd.pavel.ucw.cz> <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com> <20140502084851.GA5730@amd.pavel.ucw.cz> <20140505120801.GA16461@amd.pavel.ucw.cz> <20140506135702.GA9879@amd.pavel.ucw.cz> <5370ED11.4000002@pengutronix.de> <20140513130914.GA9806@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NgqACsG560eIglTnlUo0DNQmbmam5v99P"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55281 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760534AbaEMNgk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 09:36:40 -0400
In-Reply-To: <20140513130914.GA9806@amd.pavel.ucw.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: Thor Thayer <tthayer.linux@gmail.com>, Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NgqACsG560eIglTnlUo0DNQmbmam5v99P
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/13/2014 03:09 PM, Pavel Machek wrote:
> Non-TI chips (including socfpga) needs different raminit
> sequence. Implement it.
>=20
> const's in the hwinit prototype forced me to add const to more
> prototypes. This makes changes bigger but the result is cleaner.

Why not split into several patches?

> Unfortunately, testing-c_can does not boot on sockit, but previous
> version of patch was tested by me and Thor Thayer.

Have a look at:

    git@gitorious.org:linux-can/linux-can-next.git
testing-c_can-based-on-net

This branch uses net/master as it's base, I've split your patch into 3,
and squashed the 32bit-const changes into the 32-bit access patch. The
remaining patch looks quite clean.

Can you please test the branch, I hope it boots on sockit.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NgqACsG560eIglTnlUo0DNQmbmam5v99P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNyH9UACgkQjTAFq1RaXHOKOACfSgvNqCYfROnzHhFYJtHN8lgm
pmMAn2U+mufzvJpjcZQjMpCRjBCtpK30
=cnKH
-----END PGP SIGNATURE-----

--NgqACsG560eIglTnlUo0DNQmbmam5v99P--
