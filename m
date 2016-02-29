From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: r8a7795 dtsi file in can-next
Date: Mon, 29 Feb 2016 13:07:16 +0100
Message-ID: <56D43474.7070405@pengutronix.de>
References: <SG2PR06MB1038D3EF38013CAA39BAD598C3BA0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Q5i2f3fOsnnsc5GSSVnglK9g4B8XNt4XA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50074 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129AbcB2MH0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Feb 2016 07:07:26 -0500
In-Reply-To: <SG2PR06MB1038D3EF38013CAA39BAD598C3BA0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q5i2f3fOsnnsc5GSSVnglK9g4B8XNt4XA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/29/2016 12:25 PM, Ramesh Shanmugasundaram wrote:
> Any reasons why arch/arm64/boot/dts/renesas/r8a7795.dtsi is not up to
> date with linux-next in tag:linux-can-next-for-4.6-20160226? When I
> submit my patch set, should I ignore the dtsi changes?

My upstream is David Miller's net-next/master. So you can either wait
until the dtsi changes will end up there or submit your dtsi changes via
another tree.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Q5i2f3fOsnnsc5GSSVnglK9g4B8XNt4XA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJW1DR0AAoJED07qiWsqSVqLCkH/2iGrcf9SdCvYdL1smCH917t
M8LyTT+Teg1rgYs8M2czNJb/kWmu2EQttsGbFM1xRGHRHEd9WnjfJouwf9TihDc4
pa9A4C2J96HOvAGDbhDkcQn3+2RDJdOzrJ+JQx2gXLNMajvsAjT/AJQ2UUksyu+l
ezQJKvxz/13yhZlRpblKBq7Wvtde/rD0V7jCf0dEXhlsJDloH3vKWsdYPznSsyAy
SEGJzQ2/EBpi8PgMU/tLmOXJ9iIamjdqrtz92ZpA2dqF1/sos2KX01SlVs9CzLXV
J2rC0XHAPxmXl1f2RL1AADYdmPudLbLVU2iPamm5ABS79rjKn48o/m1tK1/W708=
=VUkc
-----END PGP SIGNATURE-----

--Q5i2f3fOsnnsc5GSSVnglK9g4B8XNt4XA--
