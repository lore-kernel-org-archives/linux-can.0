From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add hardware controller version support
Date: Mon, 02 Jul 2012 14:42:38 +0200
Message-ID: <4FF1973E.4070005@pengutronix.de>
References: <1341174085-11781-1-git-send-email-mkl@pengutronix.de> <4FF10668.4000504@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC69C95857D5721EEF1E41C49"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37662 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab2GBMmq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 08:42:46 -0400
In-Reply-To: <4FF10668.4000504@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Wolfgang Grandegger <wg@grandegger.com>, Shawn Guo <shawn.guo@linaro.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC69C95857D5721EEF1E41C49
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/02/2012 04:24 AM, Hui Wang wrote:
> Marc Kleine-Budde wrote:
>> From: Hui Wang <jason77.wang@gmail.com>
>>
>> At least in the i.MX series, the flexcan contrller divides into ver_3
>> and ver_10, current driver is for ver_3 controller.
>>
>> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
>> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
>> Its reset value is 0xffffffff, this means ID Filter Table must be
>> checked when receive a packet, but the driver is designed to accept
>> everything during the chip start, we need to clear this register to
>> follow this design.
>>
>> Use the data entry of the struct of_device_id to point chip specific
>> info, we can set hardware version for each platform.
>>
>> Cc: linux-can@vger.kernel.org
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> [mkl: add id_table support]
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hui Wang,
>>
>> can you please test if this works for you on mx6.
>>  =20
> Sorry for reply late.
>=20
> This patch works well on the mx6. But i found a minor problem, please
> see below.

I've fixed the issue in the patch series I just send (forgot to mention
that in the patch). Can I add your Acked-by and Tested-by?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC69C95857D5721EEF1E41C49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/xl0EACgkQjTAFq1RaXHNnNwCeJudMo5WPJPgDrMllCtVHHhNt
DUgAn0YDObLz/kTzhR9COpV06RiC3wSM
=Ei7y
-----END PGP SIGNATURE-----

--------------enigC69C95857D5721EEF1E41C49--
