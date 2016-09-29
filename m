From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Recommended NAPI practices for new drivers
Date: Thu, 29 Sep 2016 08:35:16 +0200
Message-ID: <2e4df84e-6c6c-368b-352e-ce9c19108ce8@pengutronix.de>
References: <CABeNA8f3Tyhqt0AQPA-T_KeMSZE3gshfrWKGAx1dhy=Ae0fNdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jXNmiGMHRgQpErs1HHFdVvkGWT7etucN2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53285 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755214AbcI2Gf0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Sep 2016 02:35:26 -0400
In-Reply-To: <CABeNA8f3Tyhqt0AQPA-T_KeMSZE3gshfrWKGAx1dhy=Ae0fNdQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Damien Dusha <d.dusha@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jXNmiGMHRgQpErs1HHFdVvkGWT7etucN2
Content-Type: multipart/mixed; boundary="spAmtN5omOL9Vuvrv4jJf4XrVTn3MGAM0";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Damien Dusha <d.dusha@gmail.com>, linux-can@vger.kernel.org
Message-ID: <2e4df84e-6c6c-368b-352e-ce9c19108ce8@pengutronix.de>
Subject: Re: Recommended NAPI practices for new drivers
References: <CABeNA8f3Tyhqt0AQPA-T_KeMSZE3gshfrWKGAx1dhy=Ae0fNdQ@mail.gmail.com>
In-Reply-To: <CABeNA8f3Tyhqt0AQPA-T_KeMSZE3gshfrWKGAx1dhy=Ae0fNdQ@mail.gmail.com>

--spAmtN5omOL9Vuvrv4jJf4XrVTn3MGAM0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2016 07:05 AM, Damien Dusha wrote:
> Dear All,
>=20
> I am currently writing a driver for the IFI CAN IP Core [1]*.  It uses
> TX and RX FIFOs rather than mailboxes.
>=20
> What is the current best practice for using NAPI? The models appear to
> be quite different between drivers:
>=20
> Uses NAPI for RX only:
>  - rcan
>  - xilinx
>  - mscan
> -  ti_hecc
>=20
> Uses NAPI for RX and ERR:
>  - flexcan
>  - at91
>  - m_can
>  - ifi_canfd
>=20
> Uses NAPI for the whole IRQ:
>  - pch_can
>  - c_can
>  - ican3
>=20
> Some others do not use NAPI at all, notably the venerable SJA1000 drive=
r.
>=20
> For new drivers, what scheme is recommended?

I'd go for RX-only NAPI.

Marc

BTW: I've a very old driver that's probably for this hardware.
Interested? It was written before socketcan was mainlined but never
adopted, as I didn't have access to the hardware anymore.

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--spAmtN5omOL9Vuvrv4jJf4XrVTn3MGAM0--

--jXNmiGMHRgQpErs1HHFdVvkGWT7etucN2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX7LYkAAoJED07qiWsqSVqHxIIALs3ZtuQINDaC78IWaPE62Ws
FihqFdShasdG9IA5byvwVQn1XRrHmSeFnt4TNGAz/PBVLnWe5elXU/5bptD/V1lc
OqwEYd5t9cQfty73H9XbWKv4tlEhpNrugmeyDw4XRXFmTvK7OqWjAYk+Jsh61jJV
TUzVmSLfdEvr8OcIF6djPb3kVGMxv/mMM5XDchxQWpGr9nJ2fCxjFMZP5TTIugFW
AQfbWqglO3mzV5jezKgrCO9QOBGI3CP36lgibM0MlfMzXIBe+QoEFqp8L0ZRK+oo
MoPE9N//y2TVYfqgm+q9+kW4AP7XOvB6CF/+8ze+6hrTEk7jE7dF/JJX9i4YdDM=
=VqUY
-----END PGP SIGNATURE-----

--jXNmiGMHRgQpErs1HHFdVvkGWT7etucN2--
