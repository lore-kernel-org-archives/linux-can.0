From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Fri, 27 Sep 2013 12:43:10 +0200
Message-ID: <21061.24894.57898.36640@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
	<524455FD.7070808@pengutronix.de>
	<20130926155422.GQ12758@n2100.arm.linux.org.uk>
	<52445FBE.4060503@ti.com>
	<21061.20097.221946.197751@ipc1.ka-ro>
	<5245535F.6020804@pengutronix.de>
	<21061.22576.404020.384558@ipc1.ka-ro>
	<52455A7D.6030403@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:50431 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3I0Knc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Sep 2013 06:43:32 -0400
In-Reply-To: <52455A7D.6030403@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hi,

Marc Kleine-Budde writes:
> On 09/27/2013 12:04 PM, Lothar Wa=C3=9Fmann wrote:
>=20
> >> They layout of the flexcan varies in the different imx chips. I'm
> >> comparing the datasheets at the moment. As Russell pointed out the=
 area
> >> staring at offset 0x80 is by the reception FIFO engine.
> >>
> > The layout is correct when the Rx FIFO is disabled!
> >=20
> > removing 'FLEXCAN_MCR_FEN' from the MCR setting makes the driver wo=
rk
> > as expected (just without receive fifo).
> >=20
> > For the use case with the FIFO enabled, the layout has to be change=
d
> > obviously.
>=20
> Can you just remove the loop completely? I think it's not needed. It
> was in the original driver, when I picked it up.
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index e1ac75d..57ee3df 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -778,17 +778,6 @@ static int flexcan_chip_start(struct net_device =
*dev)
>         netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ct=
rl);
>         flexcan_write(reg_ctrl, &regs->ctrl);
>=20
> -       for (i =3D 0; i < ARRAY_SIZE(regs->cantxfg); i++) {
> -               flexcan_write(0, &regs->cantxfg[i].can_ctrl);
> -               flexcan_write(0, &regs->cantxfg[i].can_id);
> -               flexcan_write(0, &regs->cantxfg[i].data[0]);
> -               flexcan_write(0, &regs->cantxfg[i].data[1]);
> -
> -               /* put MB into rx queue */
> -               flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
> -                       &regs->cantxfg[i].can_ctrl);
> -       }
> -
>         /* acceptance mask/acceptance code (accept everything) */
>         flexcan_write(0x0, &regs->rxgmask);
>         flexcan_write(0x0, &regs->rx14mask);
>=20
OK, done that. Driver works perfectly well now on i.MX6Q. I'll retest
on i.MX53 later to make sure it's still working there too.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
