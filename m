From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: Kconfig: CAN_AT91 depends on ARCH_AT91
Date: Mon, 11 Mar 2013 10:57:10 +0100
Message-ID: <513DAA76.6040803@pengutronix.de>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com> <1362763842-14924-4-git-send-email-ludovic.desroches@atmel.com> <513A2396.4080508@pengutronix.de> <20130311092419.GB2572@ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2PAUKNCNLCAHSNWGJBIUA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44763 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab3CKJ5Y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Mar 2013 05:57:24 -0400
In-Reply-To: <20130311092419.GB2572@ludovic.desroches@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2PAUKNCNLCAHSNWGJBIUA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/11/2013 10:24 AM, Ludovic Desroches wrote:
> On Fri, Mar 08, 2013 at 06:44:54PM +0100, Marc Kleine-Budde wrote:
>> On 03/08/2013 06:30 PM, ludovic.desroches@atmel.com wrote:
>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> SAMA5D3 devices also embed CAN feature. Moreover if we want to produc=
e a single
>>> kernel image (at least for Atmel devices) it is not useful to be too
>>> restrictive.
>>
>> If it compiles on other ARMs aswell we can make it depend on ARCH_ARM.=

>>=20
> I was thinking about it but I am wondering if it makes sense. Should we=
 have a
> non atmel device with atmel can?

I don't know if atmels sells the IP core separately, but ARM Linux is
going towards a multi ARCH kernel anyways. So the can core should
compile on non atmel and/or multi arch kernels.

> I have no position about this point, if you think it's better to make
> it depending onto ARCH_ARM, I'll change it if there is no compilation
> issue.

Please make it so.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2PAUKNCNLCAHSNWGJBIUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE9qnkACgkQjTAFq1RaXHO8xQCfW8u8An0yL/5TYieG8UfaHWdq
O+MAoIrK1EpQ24SI4hxsmwWxtEWtHnvs
=mTaT
-----END PGP SIGNATURE-----

------enig2PAUKNCNLCAHSNWGJBIUA--
