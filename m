From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Receiving overloaded and/or out-of-order on iMX6 platform
Date: Thu, 8 Jun 2017 14:59:07 +0200
Message-ID: <9d4622db-f4f7-54f1-c294-08939377ffc9@pengutronix.de>
References: <CAFFyqAYjEdxVg44=9VC=TqxMs6mbMGK1FFPQ-E_GPpPH0XwTSQ@mail.gmail.com>
 <CAFFyqAa-e9GLgcbQkcOamC4_n56FnwEnTJ0uAny64Kg3Npac1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="v06bl0W9GBSvp2ArlQmUBahFsJ8I9H1XS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52381 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750725AbdFHM7P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Jun 2017 08:59:15 -0400
In-Reply-To: <CAFFyqAa-e9GLgcbQkcOamC4_n56FnwEnTJ0uAny64Kg3Npac1Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jim Morash <jmorash@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v06bl0W9GBSvp2ArlQmUBahFsJ8I9H1XS
Content-Type: multipart/mixed; boundary="Mkxtk52F7WAIXKn6JMB9m2d3pMcLWM6MN";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jim Morash <jmorash@gmail.com>, linux-can@vger.kernel.org
Message-ID: <9d4622db-f4f7-54f1-c294-08939377ffc9@pengutronix.de>
Subject: Re: Receiving overloaded and/or out-of-order on iMX6 platform
References: <CAFFyqAYjEdxVg44=9VC=TqxMs6mbMGK1FFPQ-E_GPpPH0XwTSQ@mail.gmail.com>
 <CAFFyqAa-e9GLgcbQkcOamC4_n56FnwEnTJ0uAny64Kg3Npac1Q@mail.gmail.com>
In-Reply-To: <CAFFyqAa-e9GLgcbQkcOamC4_n56FnwEnTJ0uAny64Kg3Npac1Q@mail.gmail.com>

--Mkxtk52F7WAIXKn6JMB9m2d3pMcLWM6MN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 01:16 AM, Jim Morash wrote:
> Apologies for replying to myself:
> Anyway, I see that the rx-offload stuff just got into the 4.11
> mainline kernel, so that explains why it has not percolated down to
> freescale as yet.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/=
drivers/net/can/flexcan.c?h=3Dv4.11

There are not that many changes on the fsl tree, you can probably cherry
pick the patches.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Mkxtk52F7WAIXKn6JMB9m2d3pMcLWM6MN--

--v06bl0W9GBSvp2ArlQmUBahFsJ8I9H1XS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlk5ShsACgkQHv7KIOw4
HPZpbgf9FRQwxCbij32CpCd8Er5Do1pLfN6wMtOBGp3C+32Wr7P1ek7yCs2vFvx/
My+F1ZoWAaph2B2/yH/bNG8rJ0+lAuxwN7jQBeywtZ7w1K6KAJ5tgm8W0zmEkrLw
Z9FuAdbIqHMXYrMpgOTFNSLQdyag8NxmRicEL76MyuzID3O6k7X7/7tJAmz2Guze
OB9J1Zymshv6oJeg9D9v7RqFf8aAPgM/lG4hfL+RHgzXHL3nbWsWN77tpnCZEo7u
ujmz2gk1VjuecG114BNx/lrUjgVdsypEWgb+f2WF9TBzi9kwcndBGNFQq5xSoYax
aQ7SXioF+o9BID1pCjTIYanPviSYbA==
=nxQJ
-----END PGP SIGNATURE-----

--v06bl0W9GBSvp2ArlQmUBahFsJ8I9H1XS--
