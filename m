From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: flexcan missing error state transitions
Date: Mon, 28 Aug 2017 11:23:24 +0000
Message-ID: <150391940455.32436.2657378736949568599@maxwell>
References: <376b00a0.1c22.15e1d13e43a.Coremail.zhuyi882004@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:16752
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751172AbdH1LXd (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 28 Aug 2017 07:23:33 -0400
In-Reply-To: <376b00a0.1c22.15e1d13e43a.Coremail.zhuyi882004@126.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?b?5pyx54ea?= <zhuyi882004@126.com>, mkl@pengutronix.de, wg@grandegger.com, linux-can@vger.kernel.org
Cc: hs@denx.de, mark.jonas@de.bosch.com, tingquan.ruan@cn.bosch.com, yi.zhu5@cn.bosch.com

Quoting =E6=9C=B1=E7=87=9A (2017-08-26 05:46:36)
> > That sounds rather shaky. Wouldn't it be more robust to have the timer =
be
> > periodic? Besides, over-sampling is preferable in order to avoid missed
> > transitions, right? See diff below.
> I can understand why you feel shaky, but I think use periodic timer will =
not
> do meaningful work here - just polling state which do not change.
> =

> The reason is flexcan_irq_state() will be called upon any interrupt, that
> already guarantees state is up-to-date if there is traffic on the bus, wh=
ich
> is the trigger of any possible state transitions. In this case, any kind =
of
> polling is not required (however, this patch will still do once extra pol=
ling,
> which I'd like to avoid as well, but seems no easy solution). Extra polli=
ng
> will get the same state as before if there is no more traffic, and if the
> traffic is ongoing, the interrupt will be fired.
> =

> The only case above approach cannot handle is there is only singled out n=
ode
> on the bus, where the traffic cannot continue. Although the core will per=
form
> auto-retransmission, but it will not generate flood of error interrupts,
> instead only generate an ACK error (/+WARN) interrupt, where the FLT_CONF=
 is
> not up-to-date yet when the flexcan_irq_state() been called, and there is=
 no
> trigger to update the state again when the register is changed. That's the
> point of this patch to compensate this trigger by poll once at the right =
time.
> Extra polling will get the same state too if the bus is still open, and i=
f the
> bus is recovered, the interrupt will be fired again.
> =

> Regarding missed transitions, yes, if user chose a too short delay, then =
he
> will miss the error passive transition, that's why the delay is configura=
ble
> via DT.
> =

> > > diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> > ...
> > > +static void flexcan_update_state_timeout(unsigned long data)
> > > +{
> > > +   struct net_device *dev =3D3D (struct net_device*)data;
> > > +   struct flexcan_priv *priv =3D3D netdev_priv(dev);
> > > +   struct flexcan_regs __iomem *regs =3D3D priv->regs;
> > > +   u32 reg_esr;
> > > +
> > > +   /* update state atomically */
> > > +   disable_irq(dev->irq);
> > > +   reg_esr =3D flexcan_read(&regs->esr);
> > > +   flexcan_irq_state(dev, reg_esr);
> > You could restart the timer here if the error state is not error-active=
. Then
> > you would not have the problem of having to choose an interval so caref=
ully.
> Yes, you're right. But I think it is good to think carefully which delay =
is
> really necessary than just drop a randomly number here. With periodic tim=
er,
> if very short delay assigned, then the performance will be hit, if reason=
able
> delay assigned, then unnecessary polling will be done.
> > > +   enable_irq(dev->irq);
> > > +}
> > ...
> =

> I understand that use periodic timer is a more generic approach which even
> possible to replace the interrupt driven on broken core (if want to), but=
 I
> want to avoid unnecessary polling as much as possible (and still get the
> correct state transitions).
> =

> What do you think?

Hi Yi,

I have users who can change the baudrate but they can not change the device
tree. The baudrate can even be changed by service technicians. I.e. it's fi=
eld
configurable. How would I configure the timeout to work well for rates betw=
een
125k and 1M?

Do you think that a periodic timer would load the system more than an IRQ-f=
lood
due to a bad error situation?

Best regards,
Andri
