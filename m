From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 20:43:01 +0200
Message-ID: <a4af635e-9a0c-d5df-5a90-4722967f0ac1@pengutronix.de>
References: <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de>
 <7661b770-574f-6337-d9a9-ff2103ebb8a6@posteo.de>
 <20161004183848.GC25008@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fBdUUPgiiMhA6R1o4bPmiB3QxSjoVKL45"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60639 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752778AbcJDSnO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 14:43:14 -0400
In-Reply-To: <20161004183848.GC25008@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>, David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fBdUUPgiiMhA6R1o4bPmiB3QxSjoVKL45
Content-Type: multipart/mixed; boundary="OfKQnN096WnonsN8pAbG0gTbwetP7XgPS";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Patrick Menschel <menschel.p@posteo.de>, David Jander
 <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <a4af635e-9a0c-d5df-5a90-4722967f0ac1@pengutronix.de>
Subject: Re: j1939
References: <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <8972643b-d6c8-1880-3360-4f8ef129cc4f@pengutronix.de>
 <7661b770-574f-6337-d9a9-ff2103ebb8a6@posteo.de>
 <20161004183848.GC25008@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161004183848.GC25008@airbook.vandijck-laurijssen.be>

--OfKQnN096WnonsN8pAbG0gTbwetP7XgPS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2016 08:38 PM, Kurt Van Dijck wrote:
>=20
>>
>>>> Recently, someone on this list was confronted with an engine ECU tha=
t
>>>> dropped TP that had the last packet not 8 bytes long.
>>>> And I believe I've encountered an issue a long time ago where this
>>>> happened on all PGNs.
>>>> So I introduced this option, having 3 possibilities:
>>>> * no padding
>>>> * padding for TP
>>>> * padding for all PGN.
>>> How to switch between padding for TP only and padding for all PGN?
>=20
> 0: no padding
> 1: TP padding
> 2: all PGN padding

Hmmm, have I taken the latest and greatest code of yours?

"padding" is static and only used once in main.c

https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/tree/=
net/can/j1939/main.c?h=3Dj1939#n45

https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/tree/=
net/can/j1939/main.c?h=3Dj1939#n171

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OfKQnN096WnonsN8pAbG0gTbwetP7XgPS--

--fBdUUPgiiMhA6R1o4bPmiB3QxSjoVKL45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX8/g2AAoJED07qiWsqSVq9FgH/1L+BTWrt9LsUncWV5ihEr8/
jaOti//aBEf02WWF4hrHDvtuz4lGnt6rvtUMHZxBfF45YJe+O81JQ6YlgeJzM0VJ
iLwWhrg9W7Rri6PX845YOcKXMmhUqSCJlndNJ5g5CnDzCu1krIb0pMP1rsYR/m1e
3ZSPRBWMTTeu5ws1dlrlsO7wULGfpN8o+jp0mT1EBkZvqR6W6ZfbS0dOoG0LtaNS
kUtVGTOAWXPkTuGmR7Xj/Mj1Oxn2YAOMPeAwjXgSFqyAicmXbXoIMaaz2tSMioHV
O7EpOydZKHmz/E/PvBslw/BdylqHCGlfR3LKXPZIV462gXmO4kURxBsqkQ8O6IE=
=thct
-----END PGP SIGNATURE-----

--fBdUUPgiiMhA6R1o4bPmiB3QxSjoVKL45--
