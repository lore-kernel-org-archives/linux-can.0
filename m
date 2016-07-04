From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
Date: Mon, 4 Jul 2016 22:59:00 +0200
Message-ID: <1d462f0c-3dc2-ba44-b3bf-53469062ff22@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <146765818281.26740.6668128129784946822@maxwell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6qotgmCG7NeP8Jlwnjgl0325FVqAVWTK7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44592 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753970AbcGDU7L (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2016 16:59:11 -0400
In-Reply-To: <146765818281.26740.6668128129784946822@maxwell>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: david@protonic.nl

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6qotgmCG7NeP8Jlwnjgl0325FVqAVWTK7
Content-Type: multipart/mixed; boundary="Gatle7n7two1K5bndqDokJq9VlIK8Cqqx"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: david@protonic.nl
Message-ID: <1d462f0c-3dc2-ba44-b3bf-53469062ff22@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <146765818281.26740.6668128129784946822@maxwell>
In-Reply-To: <146765818281.26740.6668128129784946822@maxwell>

--Gatle7n7two1K5bndqDokJq9VlIK8Cqqx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2016 08:49 PM, Andri Yngvason wrote:
> Quoting Marc Kleine-Budde (2016-07-04 18:32:07)
>> +static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *=
b)
>> +{
>> +       const struct can_rx_offload_cb *cb_a, *cb_b;
>> +
>> +       cb_a =3D can_rx_offload_get_cb(a);
>> +       cb_b =3D can_rx_offload_get_cb(b);
>> +
>> +       return cb_b->timestamp - cb_a->timestamp;
>> +}
>=20
> Hi Marc,
>=20
> An int is not large enough to store the difference between two u32.
>=20
> E.g. INT_MAX - (-1) =3D INT_MIN
>=20
> They're unlikely to be very far apart, but you can never be too cautiou=
s. ;)

Actually I want to have the difference between two timestamps in order
to sort . The timestamps are monotonically increasing and will
eventually roll over. As the flexcan core only has a 16 bit timer, I
shift the timestamp by 16 bit (cb =3D reg_ts << 16), to fill the whole 32=

bit. This way I don't have to take care about the overflow, right?

> main: a=3D0xfffffff0 b=3D0xfffffffc diff=3D 12
> main: a=3D0xfffffff0 b=3D0xfffffffd diff=3D 13
> main: a=3D0xfffffff0 b=3D0xfffffffe diff=3D 14
> main: a=3D0xfffffff0 b=3D0xffffffff diff=3D 15
> main: a=3D0xfffffff0 b=3D0x00000000 diff=3D 16
> main: a=3D0xfffffff0 b=3D0x00000001 diff=3D 17
> main: a=3D0xfffffff0 b=3D0x00000002 diff=3D 18
> main: a=3D0xfffffff0 b=3D0x00000003 diff=3D 19
> main: a=3D0xfffffff0 b=3D0x00000004 diff=3D 20

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Gatle7n7two1K5bndqDokJq9VlIK8Cqqx--

--6qotgmCG7NeP8Jlwnjgl0325FVqAVWTK7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXes4UAAoJED07qiWsqSVqX04IAI1AOQRRn5DTedZzpuGk6fy2
pFqztlhuhMKBtRP/IqgoIyk8+qrAz51LGQ2DUXRkGgTsuK+ODxXlETxFpP6wTZbu
6ywyLwLjXoOpp6vxLF1nVChZ9dWnG1EZUIUfTIBbnA6iR7LP6IPxsHrggsbyhZsc
RQiH7BFapfpAFQMDMpLtOS6r8mC0QOlBU6KfyxNyearwMl2/oo4+4MOohePETRdb
ZDtzQhc4/uxlNPCEXFe12KD1atfpbYsL2KQU0M6SXYggiz32Z+PNfhY7lmlYZFVJ
SHktf7zgtyQCeQa44LBqPpmkjtDVLLg/OyhCQPB6nsksFBfqzQhE3W/7+ZARRiU=
=/Tff
-----END PGP SIGNATURE-----

--6qotgmCG7NeP8Jlwnjgl0325FVqAVWTK7--
