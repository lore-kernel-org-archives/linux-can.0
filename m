From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add 2nd clock to support imx53 and newer
Date: Wed, 18 Jul 2012 11:21:49 +0200
Message-ID: <5006802D.8070707@pengutronix.de>
References: <1342562748-24701-1-git-send-email-mkl@pengutronix.de> <50061B86.7080200@gmail.com> <500675C2.9090303@pengutronix.de> <20486.31827.477680.302450@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE16F79782DC03758E73F6B9E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35715 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab2GRJWI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 05:22:08 -0400
In-Reply-To: <20486.31827.477680.302450@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: Hui Wang <jason77.wang@gmail.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE16F79782DC03758E73F6B9E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2012 11:05 AM, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Marc Kleine-Budde writes:
>> On 07/18/2012 04:12 AM, Hui Wang wrote:
>>> Marc Kleine-Budde wrote:
>>>> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>>>
>>>> This patch add support for a second clock to the flexcan driver. On
>>>> modern
>>>> freescale ARM cores like the imx53 and imx6q two clocks ("ipg" and "=
per")
>>>> must be enabled in order to access the CAN core.
>>>> -        clock_freq =3D clk_get_rate(clk);
>>>>      }
>>>> =20
>>>>      mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> @@ -1039,7 +1052,8 @@ static int __devinit flexcan_probe(struct
>>>> platform_device *pdev)
>>>>          CAN_CTRLMODE_BERR_REPORTING;
>>>>      priv->base =3D base;
>>>>      priv->dev =3D dev;
>>>> -    priv->clk =3D clk;
>>>> +    priv->clk_ipg =3D clk_ipg;
>>>> +    priv->clk_per =3D clk_per;
>>>>      priv->pdata =3D pdev->dev.platform_data;
>>>>      priv->devtype_data =3D devtype_data;
>>>> =20
>>>> @@ -1067,9 +1081,11 @@ static int __devinit flexcan_probe(struct
>>>> platform_device *pdev)
>>>>   failed_map:
>>>>      release_mem_region(mem->start, mem_size);
>>>>   failed_get:
>>>> -    if (clk)
>>>> -        clk_put(clk);
>>>>   failed_clock:
>>>> +    if (clk_per)
>>>>  =20
>>> Use if (!IS_ERR(clk_per))
>>
>> Yes, good catch.
>>
>> Is it allowed to call clk_put with a NULL pointer? Both clocks can be
>> NULL, if the frequency is defined via the device tree, this is case fo=
r
>> powerpc.
>>
> This has been discussed here already several times. Everything
> returned by clk_get() that does not satisfy the IS_ERR() check, is a
> valid clk cookie and can be used for the clk API calls.

I've switched to devm completely (see Patch v2), so the clk_put is obsole=
te.

In this particular driver the NULL pointer in question is not returned
via the clk_get(). On powerpc we don't use clk_get(), because it's not
working (AFIAK) on the p1010 (the powerpc arch that has a flexcan).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE16F79782DC03758E73F6B9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAGgDAACgkQjTAFq1RaXHN8kwCfczagY2DGQSipipyZiHhoP+Pe
bnAAn2nzCUB95jfGceHmFsFPSZF7xipY
=qtjY
-----END PGP SIGNATURE-----

--------------enigE16F79782DC03758E73F6B9E--
