From: Viktor Babrian <babrian.viktor@renyi.mta.hu>
Subject: Re: [PATCH 3.19-rc3] c_can: end transmission on network stop
Date: Sun, 18 Jan 2015 20:01:40 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1501181931400.32136@login>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login>
 <20150113153243.26859.47218@shannon> <alpine.DEB.2.02.1501181809150.32136@login>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.renyi.hu ([193.224.79.18]:38010 "EHLO smtp.renyi.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbbARTBl (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 18 Jan 2015 14:01:41 -0500
In-Reply-To: <alpine.DEB.2.02.1501181809150.32136@login>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Andri Yngvason <andri.yngvason@marel.com>, Tom Evans <tom_usenet@optusnet.com.au>, Marc Kleine-Budde <mkl@pengutronix.de>


Controller put into init mode in betwork stop to end pending 
transmission. The issue is observed in cases when transmitted frame is not 
acked.

Signed-off-by: Viktor Babrian <babrian.viktor@renyi.mta.hu>
---
--- linux-3.19-rc3/drivers/net/can/c_can/c_can.c	2015-01-06 
02:05:20.000000000 +0100
+++ linux/drivers/net/can/c_can/c_can.c	2015-01-18 18:07:09.000000000 
+0100
@@ -615,6 +615,9 @@ static void c_can_stop(struct net_device

  	c_can_irq_control(priv, false);

+	/* put ctrl to init on stop to end ongoing transmission */
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_INIT);
+
  	/* deactivate pins */
  	pinctrl_pm_select_sleep_state(dev->dev.parent);
  	priv->can.state = CAN_STATE_STOPPED;

