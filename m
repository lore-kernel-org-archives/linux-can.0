From: Viktor Babrian <babrian.viktor@renyi.mta.hu>
Subject: [PATCH 3.19-rc3] c_can: SIE disabled when berr-reporting is off to
 reduce irq flood
Date: Sun, 18 Jan 2015 19:30:58 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1501181809150.32136@login>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login>
 <20150113153243.26859.47218@shannon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.renyi.hu ([193.224.79.18]:37534 "EHLO smtp.renyi.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbbARSbJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 18 Jan 2015 13:31:09 -0500
In-Reply-To: <20150113153243.26859.47218@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>


Status interrupt is to be disabled if bus error reporting is off in order 
to reduce interrupt flood when e.g. a frame is not acked. Side effect is 
that when berr-reporting off, warn->pass and pass-warn state transitions 
may be reported later (upon a successful rx/tx event) or even go 
undetected. With proper implementation, these transitions could always be 
detected (but still later). It is considered better to have a non-accurate 
report of these transitions than having a non-responding system in 
possible scenarios.

Signed-off-by: Viktor Babrian <babrian.viktor@renyi.mta.hu>
---
--- linux-3.19-rc3/drivers/net/can/c_can/c_can.c	2015-01-06 
02:05:20.000000000 +0100
+++ linux/drivers/net/can/c_can/c_can.c	2015-01-18 17:46:09.000000000 
+0100
@@ -242,8 +242,11 @@ static void c_can_irq_control(struct c_c
  {
  	u32 ctrl = priv->read_reg(priv,	C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;

+	/* do not enable status irq if bus error reporting is not needed 
*/
  	if (enable)
-		ctrl |= CONTROL_IRQMSK;
+		ctrl |= (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) 
?
+			CONTROL_IRQMSK :
+			(CONTROL_IRQMSK & ~CONTROL_SIE);

  	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
  }

