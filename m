From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: esd_usb2: endianess warning
Date: Sat, 14 Mar 2015 15:33:09 +0100
Message-ID: <550446A5.80702@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fMJ8iNHkEvRMTrhRgeeHDDU9MP1fHV0Q7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50783 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbbCNOdM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Mar 2015 10:33:12 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Matthias Fuchs <matthias.fuchs@esd.eu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fMJ8iNHkEvRMTrhRgeeHDDU9MP1fHV0Q7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

when compiling with sparse (make C=3D2), the esd driver throws the
following warning, can someone, preferred the driver author :), take
care of fixing them?

> drivers/net/can/usb/esd_usb2.c:369:53: warning: restricted __le32 degra=
des to integer
> drivers/net/can/usb/esd_usb2.c:791:25: warning: incorrect type in assig=
nment (different base types)
> drivers/net/can/usb/esd_usb2.c:791:25:    expected restricted __le32 [u=
sertype] hnd
> drivers/net/can/usb/esd_usb2.c:791:25:    got unsigned int

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fMJ8iNHkEvRMTrhRgeeHDDU9MP1fHV0Q7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVBEalAAoJECte4hHFiupUjUkQAKVwtfLqk/nOhM0PA4aa6/1M
0ry+rsEby5VLgMxydhm3BgDYuzMjFZAbkd7MWe8EMEKGJ6SQ9Vhu1SV3Pf47IrMG
W5vzguMFmpfpnuz21clWjFCqK39A9P1zWJLkDzIHA2i0hSZln1lS+igAA9bLx4Uk
2hQPxV09dqEJJzKjtRi3yapmxMtOmPk4VnsSbVTK+ED5A5IwI+Myon43KilDjaGw
ca4AB3SCKJtoHCdTh3kmZYVVmBFO2SgmNSvnfYIHB0X25Bs0bV4+f68Uo6p7I5Dj
NvOe61icz3OQ6wBhII6XjBtqsvfNu+sv2fTLlf6aQrTLyGmMUbJyOtStNBH6jBkP
KCo8J7vuCOm7Sy/0v3MXfKrifCPR4YEQpjadduoAPeB0APVnUGVqSYX0MnSXnSF4
HLwczIBMiEudxLv5txfzgkWhfwJkvoxGDYKuA2Nj2k/poL5lekl7rZdU62E+ujtc
/9TFAId7KNuC2WBaQfzsqUX5OslIqS7iOWNW4rJ1nvzPwtMn0noN/VCx8Gz9eE6F
FqCD2JlGdMNDIesl9wA7oXOQtQ1Cv9PBqjxzjXE1hw5DwfHD68kllKaWq/cqkVD8
K1fweGMt8jpcC+/CznTLXDQI+PUO1vM2qDN9sL4tmOO4oEdxi020w8Bol4wjapgh
qpIc/PIPuw4dQHmws18Q
=hk22
-----END PGP SIGNATURE-----

--fMJ8iNHkEvRMTrhRgeeHDDU9MP1fHV0Q7--
