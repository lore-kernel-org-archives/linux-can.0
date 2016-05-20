From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [PATCH 05/10] can: flexcan: make use of rx-fifo's irq_offload_simple
Date: Fri, 20 May 2016 13:31:26 +0200
Message-ID: <CAJ=nTsvWXck3r6+Nm9GenT8FHNzkPY4_pG_NzbC-ouTw6OkZgw@mail.gmail.com>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
	<1462791154-13375-6-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33165 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbcETLb2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 May 2016 07:31:28 -0400
Received: by mail-lb0-f171.google.com with SMTP id k7so13532039lbm.0
        for <linux-can@vger.kernel.org>; Fri, 20 May 2016 04:31:27 -0700 (PDT)
In-Reply-To: <1462791154-13375-6-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Christian Magnusson <Christian.Magnusson@semcon.com>

2016-05-09 12:52 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:
>  static irqreturn_t flexcan_irq(int irq, void *dev_id)
> @@ -727,25 +699,22 @@ static irqreturn_t flexcan_irq(int irq, void *d=
ev_id)
>         if (reg_esr & FLEXCAN_ESR_ALL_INT)
>                 flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->e=
sr);
>
> -       /* schedule NAPI in case of:
> -        * - rx IRQ
> -        * - state change IRQ
> -        * - bus error IRQ and bus error reporting is activated
> -        */
> -       if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
> -           (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> +       /* bus error IRQ and bus error reporting is activated */
> +       if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>             flexcan_has_and_handle_berr(priv, reg_esr)) {
>                 /* The error bits are cleared on read,
>                  * save them for later use.
>                  */
>                 priv->reg_esr =3D reg_esr & FLEXCAN_ESR_ERR_BUS;
> -               flexcan_write(priv->reg_imask1_default &
> -                             ~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs=
->imask1);
>                 flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_=
ERR_ALL,
>                               &regs->ctrl);
> -               napi_schedule(&priv->napi);
> +               can_rx_fifo_irq_error(&priv->fifo);
>         }
>
> +       /* reception interrupt */
> +       if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE)
> +               can_rx_fifo_irq_offload_simple(&priv->fifo);
> +

Upon some further testing we noticed that upon "bus-errors" and
berr-reporting =3D on the controller never recovered.

If we get ONE bus-error, it will be set indefinitely and report a
ERRORFRAME on each received frame.

root@mx4-v61-1000000:/mnt/config# ./candump any,0:0,#FFFFFFFF
using interface name 'any'.
  can0  002   [1]  00
  can0  20000088   [8]  00 00 04 00 00 00 00 00   ERRORFRAME
  can1  002   [1]  00
  can1  002   [1]  01
  can1  20000088   [8]  00 00 04 00 00 00 00 00   ERRORFRAME
  can0  002   [1]  01
  can0  20000088   [8]  00 00 04 00 00 00 00 00   ERRORFRAME
  can1  002   [1]  02
  can1  20000088   [8]  00 00 04 00 00 00 00 00   ERRORFRAME
  can0  002   [1]  02
  can0  20000088   [8]  00 00 04 00 00 00 00 00   ERRORFRAME
  can0  002   [1]  03
  can0  20000088   [8]  00 00 04 00 00 00 00 00   ERRORFRAME

And the reson is because that the following code is not longer run on
a "reception interrupt".

>                 /* The error bits are cleared on read,
>                  * save them for later use.
>                  */
>                 priv->reg_esr =3D reg_esr & FLEXCAN_ESR_ERR_BUS;

Which means priv->reg_esr will never be cleared, and on each
flexcan_poll_state/flexcan_poll_bus_err call we will have a "error
bit" set and trigger ERRORFRAMES.

Thanks to Christian (on CC) who found this problem and proposed a solut=
ion.

One solution is to move "save of reg_esr" out from the condition and
do it regardless of what interrupt source triggered the interrupt.

Christian also suggested a solution of clearing "priv->reg_esr" in
flexcan_poll_state when are done with it.


--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
