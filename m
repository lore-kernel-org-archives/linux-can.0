From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v10] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN
 controller
Date: Thu, 13 Sep 2012 11:14:55 +0200
Message-ID: <5051A40F.2090205@pengutronix.de>
References: <1347525263-28414-1-git-send-email-mkl@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA2E2E3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4FA8B47857578FF197870827"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53261 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2IMJPB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Sep 2012 05:15:01 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2E2E3@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4FA8B47857578FF197870827
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/13/2012 11:09 AM, AnilKumar, Chimata wrote:
> On Thu, Sep 13, 2012 at 14:04:23, Marc Kleine-Budde wrote:
>> From: AnilKumar Ch <anilkumar@ti.com>
>>
>> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
>> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
>> register of C_CAN/D_CAN IP when clock is turned off.
>>
>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> I've squashed both patches into one, also changed:
>> - add and use c_can_pm_runtime_{enable,disable}
>> - remove leftovers from c_can_platform.c
>> - cleaned up error path in register_c_can_dev
>>
>=20
> Thanks Marc, its working.
>=20
> While committing "Adopt pinctrl support" patch on top
> of this patch I saw some error, can you fix that?

Sure, already done :) I'll force push that on net-next/master

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4FA8B47857578FF197870827
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBRpBMACgkQjTAFq1RaXHNskACfbLf0dNJmxhhmLMgpLfPhDn5o
+EMAn3M2f2PQd+V3or5T1dIJ8NRyl8dj
=NZXY
-----END PGP SIGNATURE-----

--------------enig4FA8B47857578FF197870827--
