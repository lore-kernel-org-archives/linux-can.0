From: "Holger Schurig" <holgerschurig@gmail.com>
Subject: [PATCH] flexcan: clear RxFIFO in the IRQ routine
Date: Mon, 22 Jun 2015 15:50:14 +0200
Message-ID: <55881298.e827b40a.1e1a1.ffffe365@mx.google.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38064 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbFVNuR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2015 09:50:17 -0400
Received: by wibdq8 with SMTP id dq8so75955572wib.1
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2015 06:50:16 -0700 (PDT)
Received: from localhost (p4FD4FA24.dip0.t-ipconnect.de. [79.212.250.36])
        by mx.google.com with ESMTPSA id s8sm17392413wik.5.2015.06.22.06.50.14
        for <linux-can@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 06:50:16 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>

If the latency between flexcan_irq() and the napi-schedules flexcan_poll()
is over 500 us, then at 500 kB/s CAN packets can be lost.  Therefore this
patch reads all available CAN packets from flexcan's (hardware) RxFIFO in
the IRQ subsystem.  It then puts these packets into a kfifo. This kfifo is
then emptied in the scheduled flexcan_poll().

Note that you still can loose packets if the latency from the actual IRQ
until flexcan_irq() starts is high enought.

Based on work from Tom Evans.

Signed-off-by: Holger Schurig <holgerschurig@gmail.com>

Index: linux-3.18/drivers/net/can/flexcan.c
===================================================================
--- linux-3.18.orig/drivers/net/can/flexcan.c	2015-06-22 15:37:51.003299645 +0200
+++ linux-3.18/drivers/net/can/flexcan.c	2015-06-22 15:39:03.619955782 +0200
@@ -24,6 +24,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
+#include <linux/kfifo.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/if_arp.h>
@@ -258,6 +259,7 @@ struct flexcan_priv {
 	struct flexcan_platform_data *pdata;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
+	DECLARE_KFIFO(kfifo, struct can_frame, 16);
 };
 
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
@@ -648,35 +650,12 @@ static void flexcan_read_fifo(const stru
 	flexcan_read(&regs->timer);
 }
 
-static int flexcan_read_frame(struct net_device *dev)
-{
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
-
-	skb = alloc_can_skb(dev, &cf);
-	if (unlikely(!skb)) {
-		stats->rx_dropped++;
-		return 0;
-	}
-
-	flexcan_read_fifo(dev, cf);
-	netif_receive_skb(skb);
-
-	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
-
-	can_led_event(dev, CAN_LED_EVENT_RX);
-
-	return 1;
-}
-
 static int flexcan_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
-	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg_iflag1, reg_esr;
+	u32 reg_esr;
 	int work_done = 0;
 
 	/*
@@ -688,24 +667,40 @@ static int flexcan_poll(struct napi_stru
 	/* handle state changes */
 	work_done += flexcan_poll_state(dev, reg_esr);
 
-	/* handle RX-FIFO */
-	reg_iflag1 = flexcan_read(&regs->iflag1);
-	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
-	       work_done < quota) {
-		work_done += flexcan_read_frame(dev);
-		reg_iflag1 = flexcan_read(&regs->iflag1);
+	/* handle KFIFO */
+	while (!kfifo_is_empty(&priv->kfifo) && work_done < quota) {
+		struct can_frame *cf;
+		struct sk_buff *skb;
+		int n;
+
+		work_done++; // always increase to prevent endless loop
+
+		skb = alloc_can_skb(dev, &cf);
+		if (unlikely(!skb)) {
+			dev->stats.rx_dropped++;
+			continue;
+		}
+
+		n = kfifo_out(&priv->kfifo, cf, 1);
+		if (unlikely(n != 1)) {
+			dev->stats.rx_dropped++;
+			continue;
+		}
+
+		netif_receive_skb(skb);
+
+		dev->stats.rx_packets++;
+		dev->stats.rx_bytes += cf->can_dlc;
+
+		can_led_event(dev, CAN_LED_EVENT_RX);
 	}
 
 	/* report bus errors */
 	if (flexcan_has_and_handle_berr(priv, reg_esr) && work_done < quota)
 		work_done += flexcan_poll_bus_err(dev, reg_esr);
 
-	if (work_done < quota) {
+	if (work_done < quota)
 		napi_complete(napi);
-		/* enable IRQs */
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
-	}
 
 	return work_done;
 }
@@ -738,10 +733,20 @@ static irqreturn_t flexcan_irq(int irq,
 		 * save them for later use.
 		 */
 		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
-			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		       &regs->ctrl);
+
+		/* Read the hardware FIFO into our kfifo */
+		while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
+			struct can_frame cf;
+			int n;
+			flexcan_read_fifo(dev, &cf);
+			n = kfifo_put(&priv->kfifo, cf);
+			if (unlikely(n) != 1) {
+				dev->stats.rx_over_errors++;
+				dev->stats.rx_dropped++;
+			}
+
+			reg_iflag1 = flexcan_read(&regs->iflag1);
+		}
 		napi_schedule(&priv->napi);
 	}
 
@@ -1229,6 +1234,7 @@ static int flexcan_probe(struct platform
 	priv->clk_per = clk_per;
 	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->devtype_data = devtype_data;
+	INIT_KFIFO(priv->kfifo);
 
 	priv->reg_xceiver = reg_xceiver;
 
--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
