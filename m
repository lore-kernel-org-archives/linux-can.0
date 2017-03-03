From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: FlexCAN on imx28
Date: Fri, 3 Mar 2017 12:23:10 +0100
Message-ID: <31bc327a-a900-c5fa-67fc-08a93134e753@pengutronix.de>
References: <1488465746.18098.13.camel@serenergy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LFxDUh7nKknACJ726Lb9CRXiG5bTUcd4I"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35459 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751333AbdCCLXn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Mar 2017 06:23:43 -0500
In-Reply-To: <1488465746.18098.13.camel@serenergy.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Malmgaard Mortensen <smm@serenergy.com>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LFxDUh7nKknACJ726Lb9CRXiG5bTUcd4I
Content-Type: multipart/mixed; boundary="hBbfLQggDkCgc2ilFlVvxn0uDjGxUDh4L";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Steffen Malmgaard Mortensen <smm@serenergy.com>
Cc: linux-can <linux-can@vger.kernel.org>
Message-ID: <31bc327a-a900-c5fa-67fc-08a93134e753@pengutronix.de>
Subject: Re: FlexCAN on imx28
References: <1488465746.18098.13.camel@serenergy.com>
In-Reply-To: <1488465746.18098.13.camel@serenergy.com>

--hBbfLQggDkCgc2ilFlVvxn0uDjGxUDh4L
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hallo Steffen,

I'm adding the linux-can ML on Cc, as the answer is of potential common
interest.

On 03/02/2017 03:42 PM, Steffen Malmgaard Mortensen wrote:
> I have been experiencing problems with CAN package loss under high bus
> load at high bit rates using an imx28. During my search for a solution,=

> I fell upon your flexcan-maxmb branch on the linux-can-next git tree. A=
s
> you are the author, I turn to you for a bit of advice. What is the
> current state of the code?

The current code is available as the tag
"linux-can-next-for-4.11-20170206" and has already been merged to
net-next. This means it will be included in the upcoming v4.11 release.

> Is it tested on imx28, or only newer SOCs?

Yes.

> What are the plans for merging to linux-fslc or other upstream trees?

It's already upstream \o/

Regarding any freescale/nxp/... vendor trees I have personally no
interest of merging the driver there. Feel free to contact me if you
need commercial support, though.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hBbfLQggDkCgc2ilFlVvxn0uDjGxUDh4L--

--LFxDUh7nKknACJ726Lb9CRXiG5bTUcd4I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAli5Uh4ACgkQHv7KIOw4
HPZ07wgAgmUSPprAlQmZNRoJsls99tAPEjpyspD9ZrzbiKy9735kampVbNAIHybe
ISbErIFe4wZ3DkbOch6Ehr9oovQEeuT8Wj77eaZigSLP8pwjt4H7fhbNwl2mTO5D
1SCbSKXKeYdVIuNOoyHp4Il7TZnNFtVgHA0mQVVVhzbPlwODUYQb2YQExnZlTs4i
TTXJXndO7aLyVBaTRmWQd6HkFQzfRqbpr2z0/WnNxV0PtNbbRJFoJI41YfzTByi7
I5aQyMSuevkZAoLpLxFTGlnqZ5vcwIc6SWvyZhqGf9tJe/J1vb5t0AyOGl6nMsvJ
qIA60tSJJcHUMbpSrS6D9XUN4t9vBQ==
=3432
-----END PGP SIGNATURE-----

--LFxDUh7nKknACJ726Lb9CRXiG5bTUcd4I--
