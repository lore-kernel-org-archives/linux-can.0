From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Does PEAK usb can support getting error count?
Date: Thu, 15 Jan 2015 12:43:10 +0100
Message-ID: <54B7A7CE.80500@pengutronix.de>
References: <4eb3ad60f4ab4f6d9fd71dc4231a1811@SGPMBX1006.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qRiHe8bNLEaLIQesEtjMd9liNboeLTLpw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56906 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbbAOLnT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Jan 2015 06:43:19 -0500
In-Reply-To: <4eb3ad60f4ab4f6d9fd71dc4231a1811@SGPMBX1006.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ruan TingQuan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qRiHe8bNLEaLIQesEtjMd9liNboeLTLpw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2015 03:21 AM, Ruan TingQuan (ST-FIR/ENG1-Zhu) wrote:
> I am using PEAK-USB-CAN adapter in my linux system (kernel 3.11).=20
> When I try to get RX/TX error count via netlink interface, return
> nothing. But it work fine on getting state, bittiming, control mode.

> Does PEAK usb can support error count getting? If not, is there plan
> to have it?

No the driver currently doesn't support it. However I think the
information is present. Currently Stephane is working to get the new
CANFD devices supported, once this is finished you can add support for
reading the error counters.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qRiHe8bNLEaLIQesEtjMd9liNboeLTLpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUt6fRAAoJECte4hHFiupUscMP/3kBNTXdoOQ/8865tv+vhYqw
kqankZsCMNGha9B3avxjU7WLyuoy6V9Xf8SoE9O2tQ2vbXdw48GHWBXVz6oVPEDq
vvok9R1EVvQrHGG/8bFpqqFrZsdcb78SD5SfKho6TbFqhxzOum27Rww8tN9Al+FS
8OVlsf2Jb1eE61LCH6DM9M8UFyY5jNfGmKSsP/MddTCvn6CcrDev7fVuNVvh603m
4+CfvqpABFIndEkHywNNdCl/1CdGjKJlsE7rz1oDi1jlj8hdduoh8V8+ZKMrAtpV
Nn14bClsopvtSSh0ek905mqxqblSAsU7dqUjuSkcUGxp+ZLLccjkarquEvhTwq/s
NOV82ivMUq0vq1Mr57FhclqKyLmbdjco4PRzgN3KTBOWZln50iOyuJrl4gwiDj9u
qB130mCrjBt47s3kZcqQFcRmWSD5R4UBHzLfwBT35RWVcfllbBhrW8ZAVeurC6kb
VpZbCVonkqekUDiMWSL8v3nVLlZm/MYzRzGssH8LU4DdAbPp9C4QVmpfYm5YW7CI
peubDvOLCcQHybY39DQFH2/Zh8bHucO/o9nJih92CsVmMs7Ca4bgJnwL83ye8aEM
XAcH3L7pUtQQxyNN1QX5NUHn1MeDhLXyak84MZTFRFpr19EXoCW6g4LQWUbG1Qrg
2OAsfKTp01mvCnVM2Erj
=ZuUJ
-----END PGP SIGNATURE-----

--qRiHe8bNLEaLIQesEtjMd9liNboeLTLpw--
