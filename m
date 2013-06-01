From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: flexcan: remove HAVE_CAN_FLEXCAN Kconfig symbol
Date: Sat, 01 Jun 2013 11:56:17 +0200
Message-ID: <51A9C541.9080300@pengutronix.de>
References: <1368781157-4646-1-git-send-email-mkl@pengutronix.de> <4297748.x0TtCUl2dJ@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2KDSAWGODOBJIIFUIBXOC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41798 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759098Ab3FAJ4j (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Jun 2013 05:56:39 -0400
In-Reply-To: <4297748.x0TtCUl2dJ@wuerfel>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Kumar Gala <galak@kernel.crashing.org>, U Bhaskar-B22300 <B22300@freescale.com>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2KDSAWGODOBJIIFUIBXOC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/01/2013 10:59 AM, Arnd Bergmann wrote:
> On Friday 17 May 2013 10:59:17 Marc Kleine-Budde wrote:
>> This patch removes the Kconfig symbol HAVE_CAN_FLEXCAN from arch/{arm,=
powerpc}
>> and allowing compilation unconditionally on all arm and powerpc platfo=
rms.
>>
>> This brings a bigger compile time coverage and removes the following d=
ependency
>> warning found by Arnd Bergmann:
>>
>>     warning: (SOC_IMX28 && SOC_IMX25 && SOC_IMX35 && IMX_HAVE_PLATFORM=
_FLEXCAN &&
>>         SOC_IMX53 && SOC_IMX6Q) selects HAVE_CAN_FLEXCAN
>>     which has unmet direct dependencies (NET && CAN && CAN_DEV)
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Cc: U Bhaskar-B22300 <B22300@freescale.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Thanks for addressing this!

I'll include this patch in my next pull request to David Miller.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2KDSAWGODOBJIIFUIBXOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGpxUUACgkQjTAFq1RaXHMpzwCggS+Cc4I1EUGvRULTyVrGgO7T
isYAn1JjuusIgDQzTKEA2UJ9Ke5REA/y
=uxSY
-----END PGP SIGNATURE-----

------enig2KDSAWGODOBJIIFUIBXOC--
