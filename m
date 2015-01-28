From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Wed, 28 Jan 2015 14:17:28 +0100
Message-ID: <54C8E168.1040501@pengutronix.de>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com> <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net> <54C6ACBD.2020806@pengutronix.de> <54C74589.9050603@hartkopp.net> <54C746AE.60801@pengutronix.de> <54C78C6E.3070705@peak-system.com> <54C78E4D.9060601@hartkopp.net> <54C791DA.3060708@peak-system.com> <54C7A037.6080100@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WwJS7hXRWxeBE2B11sx2RrKUD7ElPkX0j"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48462 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbbA1URC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Jan 2015 15:17:02 -0500
In-Reply-To: <54C7A037.6080100@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WwJS7hXRWxeBE2B11sx2RrKUD7ElPkX0j
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2015 03:27 PM, Oliver Hartkopp wrote:
> As there is no firmware version to check against right now:
>=20
> In pcan_usb_fd_init() just set
>=20
> pdev->dev.can.ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO;

St=C3=A9phane, are going to add a firmware version check or should I take=
 the
series as it is?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WwJS7hXRWxeBE2B11sx2RrKUD7ElPkX0j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUyOFrAAoJECte4hHFiupUBzwP/iUqTC8NhzJV2oTooXfeSSQu
+Z+Q0+dl+OP6b6SwlnNjB/qZ79fZGXfdOiKXv39MNsTzilCSXIO4y+/q+WEu1DSm
o9LLIfNd+93bcRPO+aH97gJaCLZtCeWE5D8a7Nry+Rl2II7FaYtxJscr8rKeMXQ1
6IHWcsz10dn3fasOCSnYjpOPoZRQ74BHUn8FN7d4SsB8Zrm5pNUZGlBGkKHpUgiA
6sUhz9hAiAxbPiT1a84LUdxlC2j9p53LWgMRlgt1MV2v/8ETlvdHdClBXJXJ3wuD
ectaLQRe34YsppDNKtFX95KLw1f7JO0RDi2g3zQ74zV60KeD4ErxKR/5eUy1yCab
QPB9HCZHLT20Z+06zkVlq99UaHEsSI0zceVs5lbk9WK0XafKDJhzQKK+npkFdIxJ
/e8A33nQxiqpjJbK6TTLEp8LgCrZxn6J4zHqESsmizE4G3ghOEuKeQbNrOl12e8H
AOj/IEXRzQWQoxhaAOrS2outaAjWCAiAVugoHf4LJWVBaaxs+Hbq0zSfOwIaBfZH
F3Uh83ejX2ojbT/XKNJZ5B1fayhcudGfQmv2+eakYfKKXe9NYgP3o89Pri3K8ydN
1CaxfZwxdMz/PaSUBsiEJwcaZi/FkPVJDK3mI/Z03CbQSmjC/MyUkZ30W+9rC27y
dKFQPHPctDPohuZKVeW9
=XJm5
-----END PGP SIGNATURE-----

--WwJS7hXRWxeBE2B11sx2RrKUD7ElPkX0j--
