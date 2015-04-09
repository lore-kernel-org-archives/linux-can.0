From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO
 mode and ERRATA ERR005829
Date: Thu, 09 Apr 2015 18:12:30 +0200
Message-ID: <5526A4EE.8040401@pengutronix.de>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com> <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com> <55269D84.1070606@pengutronix.de> <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com> <55269EDC.7040802@pengutronix.de> <BY1PR0301MB1303BCBCB7BBC7A10409D52E82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GBVpWKxO8TxF1i4vhDTRSnvhcTRllv7m7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51614 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbbDIQMm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2015 12:12:42 -0400
In-Reply-To: <BY1PR0301MB1303BCBCB7BBC7A10409D52E82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GBVpWKxO8TxF1i4vhDTRSnvhcTRllv7m7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/09/2015 05:53 PM, bhupesh.sharma@freescale.com wrote:
>> Please look at the mainline commit:
>>
>> 25e924450fcb can: flexcan: implement workaround for errata ERR005829
>=20
> Hmm.. This looks like a fairly simple ERRATA to be handled w/o Kconfig.=

> But with the legacy mode support ERRATA, we have completely different R=
X setups for
> the legacy and FIFO mode.

Can you give me link to the "ERRATA ERR005829 (A-008965)" description?

The errata ERR005829 is described here
http://cache.freescale.com/files/32bit/doc/errata/IMX6DQCE.pdf and it's
fixed by mainline commit:

    25e924450fcb can: flexcan: implement workaround for errata ERR005829

Is your "ERRATA ERR005829 (A-008965)" something different?

> Errata handling via Kconfig seems pretty common in the kernel (see [1])=


Yes, for the ARM Core itself.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GBVpWKxO8TxF1i4vhDTRSnvhcTRllv7m7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVJqTyAAoJECte4hHFiupUbN4P/iwJXH0pgv5gb2MGVV0JhEVo
0wDxrCrmuWzYZgZ2E6G2Nv94woNnXM6rA8GRTFUzIEG7J0Jg4M0d5AQrYyUyUINa
Zqf+vTH0pCAyIHA4kZnTytN6fqCZ9ius3S3BaWkN8UnAAaY/5MeUQyyRX+QSxL1K
KutQsdXXbtwNIQrZlM0h7RI74FE0ovhf4AizJiQyfpJ6MK0vaS3aiNzBFMN1x/kc
0ypzDD8wnE49oWSn24JaVvwrzhepFns9viXS4ddP1RtICs+fSiGixTgkXfvFzCmU
KYyW0EMaElpDMQMGXoYMOZabjJdltpjPV6w5ta5Q2ia56ii71QIIJWMlK/hbA/yj
iLikLV2hFYdseamVzTtmRyeBmEHiojODEAjVeIKI7DVwaqRXaTzP2s+FZBREMSGB
0WxJ0t8qWZLyclfqq+OiPRIGRqh/9LST+Mt1KmaZWzCFyDkZmb29bdYiU48zYmUa
OURecwjuNjDwuEjfNzafy5igyjxM7J8dvKYTH5JskKbVY8/l3zhupqFhh+UOyTyA
iVm8gMgc9svh3fwtGHw42af718Lc6vzV1qYi3S+Dlr3Kq135M07nF0ahUjb/ndIF
k/c+waugifcZ3vH1sZU1QPliYhNLo08wbgzdab1Z9AcIII7s4L7f6jeXw2rvqhrd
FDPIz4ops7sZgh3VjzH3
=o042
-----END PGP SIGNATURE-----

--GBVpWKxO8TxF1i4vhDTRSnvhcTRllv7m7--
