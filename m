From: AnilKumar Ch <anilkumar@ti.com>
Subject: [RESEND PATCH v3 2/5] can: c_can: fix an interrupt thrash issue with c_can driver
Date: Wed, 23 May 2012 17:45:10 +0530
Message-ID: <1337775313-28219-3-git-send-email-anilkumar@ti.com>
References: <1337775313-28219-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44665 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229Ab2EWMPm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 May 2012 08:15:42 -0400
In-Reply-To: <1337775313-28219-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch fixes an interrupt thrash issue with c_can driver.

In c_can_isr() function interrupts are disabled and enabled only in
c_can_poll() function. c_can_isr() & c_can_poll() both read the
irqstatus flag. However, irqstatus is always read as 0 in c_can_poll()
because all C_CAN interrupts are disabled in c_can_isr(). This causes
all interrupts to be re-enabled in c_can_poll() which in turn causes
another interrupt since the event is not really handled. This keeps
happening causing a flood of interrupts.

To fix this, read the irqstatus register in isr and use the same cached
value in the poll function.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
Link to previous submission
	http://marc.info/?t=133664994000003&r=1&w=2

 drivers/net/can/c_can/c_can.c |    7 +++----
 drivers/net/can/c_can/c_can.h |    1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 9ac28df..fa01621 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -952,7 +952,7 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 	struct net_device *dev = napi->dev;
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	irqstatus = priv->read_reg(priv, &priv->regs->interrupt);
+	irqstatus = priv->irqstatus;
 	if (!irqstatus)
 		goto end;
 
@@ -1030,12 +1030,11 @@ end:
 
 static irqreturn_t c_can_isr(int irq, void *dev_id)
 {
-	u16 irqstatus;
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	irqstatus = priv->read_reg(priv, &priv->regs->interrupt);
-	if (!irqstatus)
+	priv->irqstatus = priv->read_reg(priv, &priv->regs->interrupt);
+	if (!priv->irqstatus)
 		return IRQ_NONE;
 
 	/* disable all interrupts and schedule the NAPI */
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 9b7fbef..5f32d34 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -76,6 +76,7 @@ struct c_can_priv {
 	unsigned int tx_next;
 	unsigned int tx_echo;
 	void *priv;		/* for board-specific data */
+	u16 irqstatus;
 };
 
 struct net_device *alloc_c_can_dev(void);
-- 
1.7.0.4

