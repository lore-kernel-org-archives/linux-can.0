From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH] can: flexcan: add 2nd clock to support imx53 and newer
Date: Wed, 18 Jul 2012 11:05:23 +0200
Message-ID: <20486.31827.477680.302450@ipc1.ka-ro>
References: <1342562748-24701-1-git-send-email-mkl@pengutronix.de>
	<50061B86.7080200@gmail.com>
	<500675C2.9090303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:51435 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab2GRJFl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 05:05:41 -0400
In-Reply-To: <500675C2.9090303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi,

Marc Kleine-Budde writes:
> On 07/18/2012 04:12 AM, Hui Wang wrote:
> > Marc Kleine-Budde wrote:
> >> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >>
> >> This patch add support for a second clock to the flexcan driver. O=
n
> >> modern
> >> freescale ARM cores like the imx53 and imx6q two clocks ("ipg" and=
 "per")
> >> must be enabled in order to access the CAN core.
> >> -        clock_freq =3D clk_get_rate(clk);
> >>      }
> >> =20
> >>      mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> @@ -1039,7 +1052,8 @@ static int __devinit flexcan_probe(struct
> >> platform_device *pdev)
> >>          CAN_CTRLMODE_BERR_REPORTING;
> >>      priv->base =3D base;
> >>      priv->dev =3D dev;
> >> -    priv->clk =3D clk;
> >> +    priv->clk_ipg =3D clk_ipg;
> >> +    priv->clk_per =3D clk_per;
> >>      priv->pdata =3D pdev->dev.platform_data;
> >>      priv->devtype_data =3D devtype_data;
> >> =20
> >> @@ -1067,9 +1081,11 @@ static int __devinit flexcan_probe(struct
> >> platform_device *pdev)
> >>   failed_map:
> >>      release_mem_region(mem->start, mem_size);
> >>   failed_get:
> >> -    if (clk)
> >> -        clk_put(clk);
> >>   failed_clock:
> >> +    if (clk_per)
> >>  =20
> > Use if (!IS_ERR(clk_per))
>=20
> Yes, good catch.
>=20
> Is it allowed to call clk_put with a NULL pointer? Both clocks can be
> NULL, if the frequency is defined via the device tree, this is case f=
or
> powerpc.
>=20
This has been discussed here already several times. Everything
returned by clk_get() that does not satisfy the IS_ERR() check, is a
valid clk cookie and can be used for the clk API calls.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
