From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Linux board with 10 CANs
Date: Fri, 15 May 2015 14:48:22 +0200
Message-ID: <5555EB16.4090903@pengutronix.de>
References: <5555A6A3.7090206@orange.fr>
 <CAGm1_ktyE_CjFwEfi1M48hDxM58HMJNAhQgYC3-8ivJ6AgE1WQ@mail.gmail.com>
 <5555B82B.2010204@pengutronix.de> <5555BD6A.60204@orange.fr>
 <5555E8DC.7050209@ems-wuensche.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="81KgVGsSme9lfP7kEcvw2HnvInuSBog4n"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51242 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161018AbbEOMse (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 08:48:34 -0400
in-reply-to: <5555E8DC.7050209@ems-wuensche.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>, =?UTF-8?Q?Fran=c3=a7ois_Beaulier?= <fbeaulier@orange.fr>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--81KgVGsSme9lfP7kEcvw2HnvInuSBog4n
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2015 02:38 PM, Gerhard Uttenthaler wrote:

>> Module based solutions are too expensive, whether it is PCIe or
>> USB. There are some bridge chips PCIe <-> memory, but i'm not
>> familiar with that. And you are right the SJA1000 is an old 5V
>> beast !

> Also a point to consider is that the speed you can read a SJA1000 chip
> is based on the clock frequency of this chip. And you have to
> read/write byte by byte. This may be too slow for 10 channels.

A local memory bus may be faster for single byte/word accesses than a
PCIe bus. I'm not a hardware guy, though :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--81KgVGsSme9lfP7kEcvw2HnvInuSBog4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVVesWAAoJEP5prqPJtc/HSlkH/0VbRyo3v/sDxFJDto3QM1pg
zMigiCZyd3Y1h5sOVgATxIODuArb0RqXq1XFTxi0VMwfTKK8RsmiK+372MICfOyB
TkzlR+ZXjuS0bIAmpM1yJAhe9IJzyvaK46d/qiT1fdTHu0kGDqFdeGaj3gYj9Oi0
oDwFzvSrH0CtUtxWDqiAaj2qX6xbnznVjXtBermgeuAQe4MrN9seI5IjVHU+AI2w
vMXllH4NDSzoyn1Du5XYgv6Dr+/ZXtB/+E3aXaSdCsOhIlJ/2H2KVcE4jHXBYHm5
qHSzEtN1B0tybvVXi/tkU2vPftVzZO/xvpSIrnQWg+RXHf81PsXNGK1yVSuRrs4=
=ou6Y
-----END PGP SIGNATURE-----

--81KgVGsSme9lfP7kEcvw2HnvInuSBog4n--
