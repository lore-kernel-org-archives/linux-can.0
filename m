From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: flexcan: use correct clock as base for bit
 rate calculation
Date: Tue, 26 Nov 2013 09:35:01 +0100
Message-ID: <52945D35.70103@pengutronix.de>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de> <1385414121-21493-2-git-send-email-mkl@pengutronix.de> <52945B5A.9070601@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OQ4a3jXh495c4R0voxhI4Obuw8giekrxh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57844 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab3KZIfI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 26 Nov 2013 03:35:08 -0500
In-Reply-To: <52945B5A.9070601@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, lst@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OQ4a3jXh495c4R0voxhI4Obuw8giekrxh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/26/2013 09:27 AM, Marc Kleine-Budde wrote:
> On 11/25/2013 10:15 PM, Marc Kleine-Budde wrote:
>> The flexcan IP core uses the peripheral clock ("per") as basic clock f=
or the
>> bit timing calculation. However the driver uses the the wrong clock ("=
ipg").
>> This leads to wrong bit rates if the rates on both clock are different=
=2E
>>
>> This patch fixes the problem by using the correct clock for the bit ra=
te
>> calculation.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
If you take the patch, please add:

Cc: linux-stable <stable@vger.kernel.org>

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OQ4a3jXh495c4R0voxhI4Obuw8giekrxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKUXTUACgkQjTAFq1RaXHOdTgCfW5JpIRe8srhWRmK0brgkar/w
ALAAmQEnEyTpJgm9X07E8Qr8k65tkkwN
=LuND
-----END PGP SIGNATURE-----

--OQ4a3jXh495c4R0voxhI4Obuw8giekrxh--
