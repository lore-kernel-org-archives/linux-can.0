From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Thu, 3 Apr 2014 17:11:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404031703120.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <17044566.IbTu3WUyuf@ws-stein> <533D774C.4050703@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:32808 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbaDCPLN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 11:11:13 -0400
In-Reply-To: <533D774C.4050703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

B1;3202;0cOn Thu, 3 Apr 2014, Marc Kleine-Budde wrote:

> Adding tglx to Cc
> 
> On 04/03/2014 04:55 PM, Alexander Stein wrote:
> > Just for the records in this thread:
> > 
> > based on tag 'linux-can-fixes-for-3.15-20140401' on repository git://gitorious.org/linux-can/linux-can I have noticed message losts(only one message each time). Interestingly 'candump any,0~0,#FFFFFFFF' didn't show yn error frames.
> > From 500000 CAN frames I lost 72 frames.

The split RX buffer handling is causing the hardware to drop frames
without giving any notice. We debugged that in the last days and can
prove that it is an hardware issue. Fun, isn't it ?

The package drop happens always at the point where the 8th message
buffer is read out and all the lower buffers are reenabled. So
something confuses the state machine of the message handler here.

If we disable the split buffer handling, then the drop out stops. That
might cause packet reordering though. Find below a test patch.

We have yet to find a workaround for that.

Thanks,

	tglx
-------------------
Subject: can: c_can : Disable rx split as workaround
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 03 Apr 2014 16:10:43 +0200

The split causes packet loss. No split can cause reordering. Choose
what you like better.

Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/Kconfig |    6 ++++++
 drivers/net/can/c_can/c_can.c |    7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

Index: linux/drivers/net/can/c_can/Kconfig
===================================================================
--- linux.orig/drivers/net/can/c_can/Kconfig
+++ linux/drivers/net/can/c_can/Kconfig
@@ -14,6 +14,12 @@ config CAN_C_CAN_PLATFORM
 	  SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
 	  boards like am335x, dm814x, dm813x and dm811x.
 
+config CAN_C_CAN_NO_RX_SPLIT
+	bool "Disable RX Split buffer"
+	---help---
+	  RX Split buffer prevents packet reordering but can cause packet
+	  loss. Select the lesser of the two evils.
+
 config CAN_C_CAN_PCI
 	tristate "Generic PCI Bus based C_CAN/D_CAN driver"
 	depends on PCI
Index: linux/drivers/net/can/c_can/c_can.c
===================================================================
--- linux.orig/drivers/net/can/c_can/c_can.c
+++ linux/drivers/net/can/c_can/c_can.c
@@ -805,8 +805,12 @@ static int c_can_read_objects(struct net
 	while ((obj = ffs(pend)) && quota > 0) {
 		pend &= ~BIT(obj - 1);
 
+#ifndef CONFIG_CAN_C_CAN_NO_RX_SPLIT
 		mcmd = obj < C_CAN_MSG_RX_LOW_LAST ?
 			IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
+#else
+		mcmd = IF_COMM_RCV_HIGH;
+#endif
 
 		c_can_object_get(dev, IF_RX, obj, mcmd);
 		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
@@ -828,6 +832,7 @@ static int c_can_read_objects(struct net
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);
 
+#ifndef CONFIG_CAN_C_CAN_NO_RX_SPLIT
 		if (obj < C_CAN_MSG_RX_LOW_LAST)
 			priv->rxmasked |= BIT(obj - 1);
 		else if (obj == C_CAN_MSG_RX_LOW_LAST) {
@@ -835,7 +840,7 @@ static int c_can_read_objects(struct net
 			/* activate all lower message objects */
 			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
 		}
-
+#endif
 		pkts++;
 		quota--;
 	} while ((obj = ffs(pend)) && quota > 0);




