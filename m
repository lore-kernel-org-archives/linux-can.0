From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/4] Add DT support to C_CAN/D_CAN controller
Date: Wed, 25 Jul 2012 11:26:35 +0200
Message-ID: <500FBBCB.7000206@pengutronix.de>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com> <500FB695.4080103@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA031DB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDEE61FF4972F282598A10688"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57248 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932767Ab2GYJ0k (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jul 2012 05:26:40 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA031DB@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDEE61FF4972F282598A10688
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/25/2012 11:19 AM, AnilKumar, Chimata wrote:
[...]

>>> First and last patches applies on top of linux-next tree, 2nd and
>>> 3rd patches applies on linux-omap tree.
>>
>> I think 1st and 4th patch (if not all) should go though the
>> linux-can-next tree. Please rebase against linux-can-next master. If y=
ou
>> need features from the v3.6 release cycle we have to wait until David
>> merges then back.
>>
>=20
> I will separate out into two sereis one with 1st and 4th patches and ot=
her
> with 2nd and 3rd patches. I will submit v2 based on linux-can-nest mast=
er.

I think the #ifdef CONFIG_HAVE_CLK will be removed in -rc1, maybe it's
better to wait until this is done.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigDEE61FF4972F282598A10688
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAPu8sACgkQjTAFq1RaXHMHVACeOihndia1BgDKxR5tefkInfMu
YoEAnRwv2CW1O65ZHGdBLZogN3+eSXeE
=6uD6
-----END PGP SIGNATURE-----

--------------enigDEE61FF4972F282598A10688--
