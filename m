From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: AW: Receiving messages issue
Date: Fri, 05 Jul 2013 12:18:54 +0200
Message-ID: <51D69D8E.6060803@pengutronix.de>
References: <zarafa.51c94a17.775f.288b4f8e69a3abab@v14647.1blu.de> <56720.79.205.48.80.1372161611.squirrel@webmail.rdts.de> <51C99CE5.7070708@pengutronix.de> <CAOHwv555mUTjXQsB2KGPAEjdVkS1fOeWZxvTb+XEk-8HjkANwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LXSLMBAMUCSEBIHDGCBM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56988 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757069Ab3GEKTH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Jul 2013 06:19:07 -0400
In-Reply-To: <CAOHwv555mUTjXQsB2KGPAEjdVkS1fOeWZxvTb+XEk-8HjkANwQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luka Rahne <luka.rahne@gmail.com>
Cc: info@gerhard-bertelsmann.de, Michael Luxen <mluxen@gmx.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LXSLMBAMUCSEBIHDGCBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2013 12:07 PM, Luka Rahne wrote:
> I was able to include this driver in my project but first test shows
> that there is no significant improvement.
>=20
> I also had to patch driver in order to compile and work.
> Can someone more experienced check patch for some fatal issues?

Just the tx_bytes calculation isn't correct, see inline. But that will
not cause bad performance.

>  Testing results:
> Test -> sending 520 messages in total (each burst had 65 unique ID
> messages of length 8 ) @ 100k baud.
> USB-PEAK-CAN used for listening only, confirms all messages on sent bus=
=2E
>=20
> New spi async drivers mcp2515.c had 3% packet loss and stable stock
> driver mcp251x.c included in kernel 3.0.81 had 5% losts messages.

That's about 40% less packet loss.

> Decreasing baud on 50k had no packet loss for handling packets of
> length 8 bytes (stock driver), but there is still issue on receiving
> messages of length 0. (tested with stock driver only)
> As expected shorter messages generates more interrupts, since they
> takes less time to transfer.
>=20
> Does anyone has any ideas what should I try, because I dont have lot
> more ideas to try with.

If I remember correct the i.mx spi driver uses a workqueue internally
and in newer kernels there isn't a kthread directly associated with that
workqueue. You can patch the spi driver to create a special kthread
based workqueue, which you can boost in priority via chrt in userspace
later.

> Is there any chip on market that has more than few RX buffers and can
> better handle high baud bus?

If you have access to the data and address bus on your processor you can
attach an sja1000 (you need a bunch of level shifters, too), that works
pretty good. Another option is to use some USB based CAN adapter.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2LXSLMBAMUCSEBIHDGCBM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHWnY4ACgkQjTAFq1RaXHOazgCfTDgUG68NJn1sVI1v963uPWg6
8PEAn21+NzlDqzw7GtX23GlESoGRlgLF
=LW3x
-----END PGP SIGNATURE-----

------enig2LXSLMBAMUCSEBIHDGCBM--
