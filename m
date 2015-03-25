From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: ems_usb: endianess warning
Date: Wed, 25 Mar 2015 10:38:29 +0100
Message-ID: <55128215.5040300@pengutronix.de>
References: <55044620.60903@pengutronix.de> <5511A6B5.2010507@ems-wuensche.com> <55127313.6090500@pengutronix.de> <55127566.8050504@pengutronix.de> <551280A9.8000206@ems-wuensche.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OPdbWPfGhSSJR9GlDppE1onLopgFIw857"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36038 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbCYJig (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Mar 2015 05:38:36 -0400
In-Reply-To: <551280A9.8000206@ems-wuensche.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Sebastian Haas <haas@ems-wuensche.com>, Sebastian Haas <dev@sebastianhaas.info>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OPdbWPfGhSSJR9GlDppE1onLopgFIw857
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/25/2015 10:32 AM, Gerhard Uttenthaler wrote:
>> In the driver there's timestamp, which endianess is corret here?
>=20
> The device is LE and transmits/receives everything as LE, hence also
> the timestamp.

Thanks, I've created a patch, can I have your Acked-by.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OPdbWPfGhSSJR9GlDppE1onLopgFIw857
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVEoIYAAoJECte4hHFiupUw7AP/3e2q3e7sOTUXudq1RQafTwT
7s492HL99FL2vUyBvIngoY/nqYyKFH2lt6Aqx448y/voEv1LLjPWdc/QaYYHQS49
60x741kApdFlKHV29x5Rp/GRhkbjrYnFTfKqNYDMx/Q/96ILoL8AvhOt+FCVdkhl
KfAZ6J7+4DIkVj35lc/XEdl4AKWB9tY3FekjOhEkY2KM/+TOyh0kauOnQnjqsA2L
7pnoZTg4rKLVEhQobNY52P99CsceSc3l21xdwIVNDwaC/Gn36OLoRPECUKYjRATv
4y0HPLE8MbquuoeAHtwxIVMpuKijf6SiAl2MEl/Q3WjkXO2DDPU3+/z6neR5ZnDm
ArXaFcX8TLm+TQD8Na/coyhuCy3RSBYeIPdJGC8czt3uuOadThhY+tdM9/mN/Q49
wRvV/8zEcjkqyZ6ALG4LjPwvFl4VpZP0PL2NTZQ1IyNvFeLx9kxDkGUHLOS07EtE
mrVM4gJ3iF6U54Rfhuhn1gD/7zUd1UAO4C6q2OhWSUbZseu0ybm4nuVwRUt6j1IG
nD7fuSKdDS9LojDjgWsN53gnzIaO9WPX3sY9RD3ZwQrn4R3LKLhtek8Ae77Bx5ET
gdwpQQsWANtBu/UPHCQPqP1k5bD8CSim0rpIgxPUG89HzOyaqIQty/HkvzEFHMif
AmRx+oH5cUskQs1Z72Kb
=tJ8E
-----END PGP SIGNATURE-----

--OPdbWPfGhSSJR9GlDppE1onLopgFIw857--
