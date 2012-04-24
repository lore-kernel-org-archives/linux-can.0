From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 2/3] can: c_can: fix an interrupt thrash issue with
 c_can driver
Date: Tue, 24 Apr 2012 11:27:32 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E997D29@DBDE01.ent.ti.com>
References: <1334915886-30076-1-git-send-email-anilkumar@ti.com>
 <4F965DD7.1000804@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47212 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157Ab2DXL1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 07:27:40 -0400
In-Reply-To: <4F965DD7.1000804@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

On Tue, Apr 24, 2012 at 13:31:27, Marc Kleine-Budde wrote:
> On 04/20/2012 11:58 AM, AnilKumar Ch wrote:
> > This patch fixes an interrupt thrash issue with c_can driver.
> > 
> > In c_can_isr() function interrupts are disabled and enabled only in
> > c_can_poll() function. c_can_isr() & c_can_poll() both read the
> > irqstatus flag. However, irqstatus is always read as 0 in c_can_poll()
> > because all C_CAN interrupts are disabled in c_can_isr(). This causes
> > all interrupts to be re-enabled in c_can_poll() which in turn causes
> > another interrupt since the event is not really handled. This keeps
> > happening causing a flood of interrupts.
> 
> Do both c_can and d_can behave the same way?

I do not have c_can hardware to confirm, but from the specification
it looks like it should be applicable to c_can. On d_can, this is
definitely true from my testing.

[...]

> >  static int c_can_poll(struct napi_struct *napi, int quota)
> >  {
> > -	u16 irqstatus;
> >  	int lec_type = 0;
> >  	int work_done = 0;
> >  	struct net_device *dev = napi->dev;
> >  	struct c_can_priv *priv = netdev_priv(dev);
> >  
> > -	irqstatus = priv->read_reg(priv, &priv->regs->interrupt);
> 
> I suggest:
> 	irqstatus = priv->irqstatus;
> 
> This would be a quite small patch, because you can keep using irqstatus
> below.

Agree, I will change.

Regards
AnilKumar
