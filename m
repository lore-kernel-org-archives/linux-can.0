From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: janz-ican3: error handling for CAL/CANopen
 firmware
Date: Mon, 9 May 2016 20:20:27 +0200
Message-ID: <5730D4EB.7030207@pengutronix.de>
References: <1462729709-17546-1-git-send-email-mkl@pengutronix.de>
 <5730D11F.2050804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qPIUUW7QUjmLpPxpc2sKwmKDo0vvGHpqi"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36282 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751274AbcEISVJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 May 2016 14:21:09 -0400
In-Reply-To: <5730D11F.2050804@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qPIUUW7QUjmLpPxpc2sKwmKDo0vvGHpqi
Content-Type: multipart/mixed; boundary="9Xa2LbbdvdRmq2lx4WaPBQxvUIIMXj3RL"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>,
 linux-can@vger.kernel.org
Message-ID: <5730D4EB.7030207@pengutronix.de>
Subject: Re: [PATCH v2] can: janz-ican3: error handling for CAL/CANopen
 firmware
References: <1462729709-17546-1-git-send-email-mkl@pengutronix.de>
 <5730D11F.2050804@gmail.com>
In-Reply-To: <5730D11F.2050804@gmail.com>

--9Xa2LbbdvdRmq2lx4WaPBQxvUIIMXj3RL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2016 08:04 PM, Andreas Gr=C3=B6ger wrote:
> I have tested it, works fine. All NMTS indications are forwarded
> correctly to ican3_handle_cevtind. Remark: I have only tested on
> little-endian machines

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9Xa2LbbdvdRmq2lx4WaPBQxvUIIMXj3RL--

--qPIUUW7QUjmLpPxpc2sKwmKDo0vvGHpqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXMNTrAAoJED07qiWsqSVqFMkIAICOJFrKFbKGYDZvXaeHziVY
rUGnQLJbHbPG5ooVG3crYSETFiOMAMP9RdDznCxeneLNLniGWgj94inJGFVwOreD
QS3aGpP/FAhLjW+nKFquZkA0A0n6iIJ3kfNWqUJUmp8L3wrLk2GQ6nakAkf6kktT
X5GZYV10Tz7dgVg+1bD6uI9e3q5zopwTVV+hEM4tFKzK5mUuXfblgdYMH9VqH7UP
Lp8JEnYHF8P0I653UK8r72KQvtHwMrkrSVTX5RQ5n0jbNF8IqQ508Tu4IAj2d17f
l8wGQ1xxSMNsLN1MZynblTPXmp2sGie3MNHf91lOyJ3KQK8B/4CyHuKqin5Sfhk=
=1E4t
-----END PGP SIGNATURE-----

--qPIUUW7QUjmLpPxpc2sKwmKDo0vvGHpqi--
