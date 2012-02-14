From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: sja1000 fix isr hang when hw is unplugged under load
Date: Tue, 14 Feb 2012 20:27:09 +0100
Message-ID: <4F3AB58D.60309@hartkopp.net>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:30658 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759855Ab2BNT1K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Feb 2012 14:27:10 -0500
Received: from [192.168.178.40] (p5B0B117C.dip0.t-ipconnect.de [91.11.17.124])
	by smtp.strato.de (klopstock mo40) (RZmta 27.6 DYNA|AUTH)
	with ESMTPA id L042ado1EITc86 for <linux-can@vger.kernel.org>;
	Tue, 14 Feb 2012 20:26:55 +0100 (MET)
In-Reply-To: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

In the case of hotplug enabled devices (PCMCIA/PCIeC) the removal of the
hardware can cause an infinite loop in the common sja1000 isr.

Use the already retrieved status register to indicate a possible hardware
removal and double check by reading the mode register in sja1000_probe_chip.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ebbcfca..37773fb 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -492,6 +492,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	while ((isrc = priv->read_reg(priv, REG_IR)) && (n < SJA1000_MAX_IRQ)) {
 		n++;
 		status = priv->read_reg(priv, REG_SR);
+		/* check for absent controller due to hw unplug */
+		if (status == 0xFF && !sja1000_probe_chip(dev))
+			return IRQ_NONE;
 
 		if (isrc & IRQ_WUI)
 			netdev_warn(dev, "wakeup interrupt\n");
@@ -508,6 +511,9 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			while (status & SR_RBS) {
 				sja1000_rx(dev);
 				status = priv->read_reg(priv, REG_SR);
+				/* check for absent controller */
+				if (status == 0xFF && !sja1000_probe_chip(dev))
+					return IRQ_NONE;
 			}
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {



