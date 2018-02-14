From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
Date: Wed, 14 Feb 2018 21:33:53 +0100
Message-ID: <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="UgzEXrharcis7a2k2YcH7GennBpiXAuFv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50821 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932096AbeBNUel (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Feb 2018 15:34:41 -0500
In-Reply-To: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, o.rempel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UgzEXrharcis7a2k2YcH7GennBpiXAuFv
Content-Type: multipart/mixed; boundary="SLzRPdmetpEJIANEupWijB6Ltx8MVRLqs";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org,
 dev.kurt@vandijck-laurijssen.be, o.rempel@pengutronix.de
Message-ID: <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
In-Reply-To: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>

--SLzRPdmetpEJIANEupWijB6Ltx8MVRLqs
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/14/2018 06:45 PM, Elenita Hinds wrote:
> Hi all.
>=20
> I was seeing the kernel panic when receiving J1939 packets
> promiscuously over both can0 and can1
> (with multi-frame messages). The panic is due to the following line in
> kernel/softirq.c (line 518):
>=20
> if (!test_and_clear_bit(TASKLET_STATE_SCHED,
>         &t->state))
>     BUG();  <=3D=3D=3D panic here!!
>=20
> The issue seems similar to a previous patch in can/bcm.c
> (see commit https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-c=
an-next.git/commit/?id=3Da06393ed03167771246c4c43192d9c264bc48412),
> wherein a race condition can occur while the tasklets are being or
> have terminated and the soft irq is checking the flag at the same
> time. I mimicked the bcm fix and the panic went away.
>=20
> Below is a proposed fix. Please review.

Can I have your S-o-b?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SLzRPdmetpEJIANEupWijB6Ltx8MVRLqs--

--UgzEXrharcis7a2k2YcH7GennBpiXAuFv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqEnTEACgkQk9IU1zQo
ZfGZLwgAxGF9SGi3DgQqZYF+hlC8qXb08Jjwjjh/5UN+xMJ5vwXsJISBRgbzejdJ
ZQmwYFVTGA9ZSLIgE8g6uobfDq9uISuCR2cvJP0q3ih7kVaBdnrhwOgF3sfx773H
9/hjkbDniineS2YQ+jPYWoi+E+CVmuK/UmwEOYE/8MkppIVpSXh1n8gLJXqvlwQd
USGkPjIF4UzbXMPKuX/m6Q9S0k9RXSCUp8pnr7jjJy4gAZYFV38dGZLoZeY7vAmT
ScXdeYFOARwTockw+qMTpTe7zXYPpY/F8EAPHJ55tzkwBhyHnlZ7wbqL6Bx6YS9Z
I8ZUMFtMeoDaDP2HvClfAHcrjpWYpw==
=6AH+
-----END PGP SIGNATURE-----

--UgzEXrharcis7a2k2YcH7GennBpiXAuFv--
