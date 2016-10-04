From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 17:05:03 +0200
Message-ID: <b140a59d-9b6a-7b55-ba87-249f720a6218@pengutronix.de>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20161004072820.GA13813@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="FKN5nWKawcLHXI10KPFvEKIIQgKnugoqF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60009 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753237AbcJDPFL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 11:05:11 -0400
In-Reply-To: <20161004072820.GA13813@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FKN5nWKawcLHXI10KPFvEKIIQgKnugoqF
Content-Type: multipart/mixed; boundary="m7kbDdBC03TFVCdBmM5dL45jrMRMSssAp";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Austin Schuh <austin@peloton-tech.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>
Message-ID: <b140a59d-9b6a-7b55-ba87-249f720a6218@pengutronix.de>
Subject: Re: j1939
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net>
 <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net>
 <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20161004072820.GA13813@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161004072820.GA13813@airbook.vandijck-laurijssen.be>

--m7kbDdBC03TFVCdBmM5dL45jrMRMSssAp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2016 09:28 AM, Kurt Van Dijck wrote:
> Please note my @eia.be address is obsolete now.
> I should investigate why the kbuild robot send mail to that address.
> this (dev.kurt@...) is meant to stay :-)

Maybe it was due to the Author in the git commits. I can (technically)
change the address, don't know about the legal aspects of this, though.

[...]

>> SAE J1939-21 defines all the timing requirements and other constraints=

>> pretty well.  Is there a reason to make them configurable?
>=20
> The timing parameters are defined pretty well, but sometimes
> light-weight ECU's cannot handle what's defined by the standard.
> Therefore, a sort of rate-limiting may be defined.
>=20
> The 8-byte sutffing also is particular. Do you need to send 7 unused
> bytes? The standard says yes, but what happens if you don't.
> So I put module parameters there.
>=20
> Oliver idea is what I was heading to, making a lot of those module
> paramters also a socket option, with the module parameters still being
> the default. So, the module parameters do not disappear.

I've a bad feeling about introducing new module parameters to the
kernel. There are ways to configure them properly. Being it a per
interface (netlink) or a per socket option.

> I'm still catching up, I agree with David Jander's comments.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--m7kbDdBC03TFVCdBmM5dL45jrMRMSssAp--

--FKN5nWKawcLHXI10KPFvEKIIQgKnugoqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX88UfAAoJED07qiWsqSVqZG8IALdcj987gkAA7yvH6gkE6b01
3aquY3pZEHn94stXvFA9ajr+KK6eDMRlt9gfFm+27grSwWRmdlHL32A8Uq2fX9KE
RR3tL6nR4hzjyNeY63Ye+afvKiJeqNPoLdrzOuxfotdxQnc3E0DDzi1IV2pnLuVs
xdNHJ0JXB13XWh9jRS0u2ciGSNnqB+KjQxgK5pdceonn7yW0DeeOT2Pn/3DeJjHN
HR9RRnhzQXIvGf4o8f145PDk6unZUDDW/xGeXbD3/FXRgoY0a/kgu+bEGW1saTG8
K/hSXAzFqwpww6Q/WAkOK5m+IXBmuYf6I4HGq69cE+mAajSZmL62RY86paNWyCs=
=LK4P
-----END PGP SIGNATURE-----

--FKN5nWKawcLHXI10KPFvEKIIQgKnugoqF--
