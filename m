From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 20:46:16 +0200
Message-ID: <48bf45a3-b724-a546-62ee-31a27dc3db33@pengutronix.de>
References: <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
 <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
 <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
 <20161004184036.GD25008@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7tKALatLDpLk3750fq13H7XeLGN5khXwV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36945 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752027AbcJDSqY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 14:46:24 -0400
In-Reply-To: <20161004184036.GD25008@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7tKALatLDpLk3750fq13H7XeLGN5khXwV
Content-Type: multipart/mixed; boundary="MhpTmkuw007HaJm0FjbX7eb8kflNA5opX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <48bf45a3-b724-a546-62ee-31a27dc3db33@pengutronix.de>
Subject: Re: j1939
References: <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
 <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
 <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
 <20161004184036.GD25008@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161004184036.GD25008@airbook.vandijck-laurijssen.be>

--MhpTmkuw007HaJm0FjbX7eb8kflNA5opX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2016 08:40 PM, Kurt Van Dijck wrote:
>>> I think we agree on what must be possible, we may just differ on the
>>> defaults and how to set things.
>>
>> It seems, or rather what I'd like to see is that we want most things t=
o
>> be per socket option. All module parameters should go away. The defaul=
t
>> for transport_max_size might be a system wide value, similar to
>> /proc/sys/net/core/rmem_max.
>=20
> do you propose to add /proc files?

No - However I'm not sure yet, though.

> I'm willing to replace module parameters with /proc files, but I don't
> see the real advantage yet. And module parameters were quicker :-)

When trying to bring new code into the kernel, this is probably not the
best argument :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--MhpTmkuw007HaJm0FjbX7eb8kflNA5opX--

--7tKALatLDpLk3750fq13H7XeLGN5khXwV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX8/j4AAoJED07qiWsqSVq/t8H/2Fc0p3+aO5ObkrC7G88BjsB
TUXPrLaqGnTnyBiUwg4bdczs2UtWQVVjS4clx4GZa8FRN3TBrXTTz+1v0dSs7+x4
p0Swa8a494j2TzzXoycj6ef3K6oycKasV70Xq+8ET3Xt5IlKW8BB6S4OijfaEJ5y
Z7i3+4bOiaf29t+I7rTzjcaQ8CmiyUVZb7VULaC/Gk/eaoKScoyhabzfpKSn029l
dYKMVFDX0rZej1gwCptmYFXEQTQuXH6cBVTbyhr75YtR4y7XZrSogyf/UzcDE+wO
bx5/FKIi2z3bq2nkZ2wQe/lEyp1rZ5jfg+zE3GzFiE54VhkCS1P0uLcMJUOsv28=
=pPgK
-----END PGP SIGNATURE-----

--7tKALatLDpLk3750fq13H7XeLGN5khXwV--
