From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
Date: Tue, 5 Jul 2016 00:30:32 +0200
Message-ID: <4456cc74-7d85-c05e-fc86-af916ce0edb0@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <146765818281.26740.6668128129784946822@maxwell>
 <1d462f0c-3dc2-ba44-b3bf-53469062ff22@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="St2E9LvJL8a2Q7UAGmpw6jn5NMtaKTlMs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57847 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752357AbcGDWap (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2016 18:30:45 -0400
In-Reply-To: <1d462f0c-3dc2-ba44-b3bf-53469062ff22@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: david@protonic.nl

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--St2E9LvJL8a2Q7UAGmpw6jn5NMtaKTlMs
Content-Type: multipart/mixed; boundary="twHTW2dxti00Oo6ucAhGvt54tiOcAgwTE"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: david@protonic.nl
Message-ID: <4456cc74-7d85-c05e-fc86-af916ce0edb0@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <146765818281.26740.6668128129784946822@maxwell>
 <1d462f0c-3dc2-ba44-b3bf-53469062ff22@pengutronix.de>
In-Reply-To: <1d462f0c-3dc2-ba44-b3bf-53469062ff22@pengutronix.de>

--twHTW2dxti00Oo6ucAhGvt54tiOcAgwTE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2016 10:59 PM, Marc Kleine-Budde wrote:
> Actually I want to have the difference between two timestamps in order
> to sort . The timestamps are monotonically increasing and will
> eventually roll over. As the flexcan core only has a 16 bit timer, I
> shift the timestamp by 16 bit (cb =3D reg_ts << 16), to fill the whole =
32
> bit. This way I don't have to take care about the overflow, right?
>=20
>> main: a=3D0xfffffff0 b=3D0xfffffffc diff=3D 12
>> main: a=3D0xfffffff0 b=3D0xfffffffd diff=3D 13
>> main: a=3D0xfffffff0 b=3D0xfffffffe diff=3D 14
>> main: a=3D0xfffffff0 b=3D0xffffffff diff=3D 15
>> main: a=3D0xfffffff0 b=3D0x00000000 diff=3D 16
>> main: a=3D0xfffffff0 b=3D0x00000001 diff=3D 17
>> main: a=3D0xfffffff0 b=3D0x00000002 diff=3D 18
>> main: a=3D0xfffffff0 b=3D0x00000003 diff=3D 19
>> main: a=3D0xfffffff0 b=3D0x00000004 diff=3D 20

It's also working when the difference is negative:

> main: a=3D0xfffffffc b=3D0xfffffff0 diff=3D-12
> main: a=3D0xfffffffd b=3D0xfffffff0 diff=3D-13
> main: a=3D0xfffffffe b=3D0xfffffff0 diff=3D-14
> main: a=3D0xffffffff b=3D0xfffffff0 diff=3D-15
> main: a=3D0x00000000 b=3D0xfffffff0 diff=3D-16
> main: a=3D0x00000001 b=3D0xfffffff0 diff=3D-17
> main: a=3D0x00000002 b=3D0xfffffff0 diff=3D-18
> main: a=3D0x00000003 b=3D0xfffffff0 diff=3D-19

It will get "problematic" if the difference between the two u32 is
around 2^31. But then it's hard to tell which of the mailboxes holds the
older timestamp.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--twHTW2dxti00Oo6ucAhGvt54tiOcAgwTE--

--St2E9LvJL8a2Q7UAGmpw6jn5NMtaKTlMs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXeuOIAAoJED07qiWsqSVqzEAH/0n7u0Xv0DPTpupRV1wxCQFA
ZoXmZJQQvtzbk/6UVm87HemBygBBGaI3WQ+YoER8nsfvTw2E5wAqjFuyRF86cqFu
0N2cUsn4Oj+CI+zK8WmunqL32ODLdiXH2XIpv7ZA6E/CPng7VcgnxpatzbuAlExb
el/TmKWXiWYY5QuMkDrOewIE7IGDr+Ql9dVS3p/cS5vIKNQ3qH6vXILiswoH91Vi
2SHrfnR/29AikA7rnOG8O/VIi+wKw/fhXfCQ1N5oilxzoHB4qWG0zvMsE0bnNqeI
0HkgvV078qz7Ti6J0vlcj3PNl9iqrQDDRZt7smbq/r0JNcPNL80DTjpy8UZeylE=
=dTwP
-----END PGP SIGNATURE-----

--St2E9LvJL8a2Q7UAGmpw6jn5NMtaKTlMs--
