From: Marek Vasut <marex@denx.de>
Subject: [PATCH 1/6] net: can: ifi: Start NAPI poll on bus warning too
Date: Sun,  8 May 2016 00:34:11 +0200
Message-ID: <1462660456-6179-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58793 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbcEGWef (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 May 2016 18:34:35 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

Start the NAPI polling in case the bus warning interrupt happens,
since it is the poll function which checks and reports the warning.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index a1bd54f..1ad05f1 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -497,7 +497,8 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
 	const u32 rx_irq_mask = IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY |
-				IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER;
+				IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER |
+				IFI_CANFD_INTERRUPT_ERROR_WARNING;
 	const u32 tx_irq_mask = IFI_CANFD_INTERRUPT_TXFIFO_EMPTY |
 				IFI_CANFD_INTERRUPT_TXFIFO_REMOVE;
 	const u32 clr_irq_mask = ~(IFI_CANFD_INTERRUPT_SET_IRQ |
@@ -513,7 +514,7 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 	/* Clear all pending interrupts but ErrWarn */
 	writel(clr_irq_mask, priv->base + IFI_CANFD_INTERRUPT);
 
-	/* RX IRQ, start NAPI */
+	/* RX IRQ or bus warning, start NAPI */
 	if (isr & rx_irq_mask) {
 		ifi_canfd_irq_enable(ndev, 0);
 		napi_schedule(&priv->napi);
-- 
2.7.0

