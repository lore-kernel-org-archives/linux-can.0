From: Marek Vasut <marex@denx.de>
Subject: [PATCH 6/6] net: can: ifi: Add more detailed error reporting
Date: Sun,  8 May 2016 00:34:16 +0200
Message-ID: <1462660456-6179-6-git-send-email-marex@denx.de>
References: <1462660456-6179-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:38383 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbcEGWec (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 May 2016 18:34:32 -0400
In-Reply-To: <1462660456-6179-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>

The updated specification for the IFI CANFD core contains description
of more detailed error reporting capability of the core. Implement
support for this detailed error reporting.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 109 ++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index ba6cd43..495879f 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -52,7 +52,8 @@
 #define IFI_CANFD_TXSTCMD_OVERFLOW		BIT(13)
 
 #define IFI_CANFD_INTERRUPT			0xc
-#define IFI_CANFD_INTERRUPT_ERROR_WARNING	((u32)BIT(1))
+#define IFI_CANFD_INTERRUPT_ERROR_WARNING	BIT(1)
+#define IFI_CANFD_INTERRUPT_ERROR_COUNTER	BIT(10)
 #define IFI_CANFD_INTERRUPT_TXFIFO_EMPTY	BIT(16)
 #define IFI_CANFD_INTERRUPT_TXFIFO_REMOVE	BIT(22)
 #define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY	BIT(24)
@@ -103,7 +104,26 @@
 
 #define IFI_CANFD_RES1				0x40
 
-#define IFI_CANFD_RES2				0x44
+#define IFI_CANFD_ERROR_CTR			0x44
+#define IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC	0x21302899
+#define IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST	BIT(0)
+#define IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST	BIT(1)
+#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST	BIT(2)
+#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST	BIT(3)
+#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST	BIT(4)
+#define IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST	BIT(5)
+#define IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST	BIT(6)
+#define IFI_CANFD_ERROR_CTR_OVERLOAD_ALL	BIT(8)
+#define IFI_CANFD_ERROR_CTR_ACK_ERROR_ALL	BIT(9)
+#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_ALL	BIT(10)
+#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_ALL	BIT(11)
+#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_ALL	BIT(12)
+#define IFI_CANFD_ERROR_CTR_CRC_ERROR_ALL	BIT(13)
+#define IFI_CANFD_ERROR_CTR_FORM_ERROR_ALL	BIT(14)
+#define IFI_CANFD_ERROR_CTR_BITPOSITION_OFFSET	16
+#define IFI_CANFD_ERROR_CTR_BITPOSITION_MASK	0xff
+#define IFI_CANFD_ERROR_CTR_ER_RESET		BIT(30)
+#define IFI_CANFD_ERROR_CTR_ER_ENABLE		((u32)BIT(31))
 
 #define IFI_CANFD_PAR				0x48
 
@@ -197,6 +217,8 @@ static void ifi_canfd_irq_enable(struct net_device *ndev, bool enable)
 	if (enable) {
 		enirq = IFI_CANFD_IRQMASK_TXFIFO_EMPTY |
 			IFI_CANFD_IRQMASK_RXFIFO_NEMPTY;
+		if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+			enirq |= IFI_CANFD_INTERRUPT_ERROR_COUNTER;
 	}
 
 	writel(IFI_CANFD_IRQMASK_SET_ERR |
@@ -335,6 +357,68 @@ static int ifi_canfd_handle_lost_msg(struct net_device *ndev)
 	return 1;
 }
 
+static int ifi_canfd_handle_lec_err(struct net_device *ndev, const u32 errctr)
+{
+	struct ifi_canfd_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	const u32 errmask = IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST |
+			    IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST |
+			    IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST |
+			    IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST |
+			    IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST |
+			    IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST |
+			    IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST;
+
+	if (!(errctr & errmask))	/* No error happened. */
+		return 0;
+
+	priv->can.can_stats.bus_error++;
+	stats->rx_errors++;
+
+	/* Propagate the error condition to the CAN stack. */
+	skb = alloc_can_err_skb(ndev, &cf);
+	if (unlikely(!skb))
+		return 0;
+
+	/* Read the error counter register and check for new errors. */
+	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+	if (errctr & IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST)
+		cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
+
+	if (errctr & IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST)
+		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+
+	if (errctr & IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST)
+		cf->data[2] |= CAN_ERR_PROT_BIT0;
+
+	if (errctr & IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST)
+		cf->data[2] |= CAN_ERR_PROT_BIT1;
+
+	if (errctr & IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST)
+		cf->data[2] |= CAN_ERR_PROT_STUFF;
+
+	if (errctr & IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST)
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+
+	if (errctr & IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST)
+		cf->data[2] |= CAN_ERR_PROT_FORM;
+
+	/* Reset the error counter, ack the IRQ and re-enable the counter. */
+	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
+	writel(IFI_CANFD_INTERRUPT_ERROR_COUNTER,
+	       priv->base + IFI_CANFD_INTERRUPT);
+	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);
+
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+	netif_receive_skb(skb);
+
+	return 1;
+}
+
 static int ifi_canfd_get_berr_counter(const struct net_device *ndev,
 				      struct can_berr_counter *bec)
 {
@@ -470,6 +554,7 @@ static int ifi_canfd_poll(struct napi_struct *napi, int quota)
 
 	u32 stcmd = readl(priv->base + IFI_CANFD_STCMD);
 	u32 rxstcmd = readl(priv->base + IFI_CANFD_STCMD);
+	u32 errctr = readl(priv->base + IFI_CANFD_ERROR_CTR);
 
 	/* Handle bus state changes */
 	if ((stcmd & stcmd_state_mask) ||
@@ -480,6 +565,10 @@ static int ifi_canfd_poll(struct napi_struct *napi, int quota)
 	if (rxstcmd & IFI_CANFD_RXSTCMD_OVERFLOW)
 		work_done += ifi_canfd_handle_lost_msg(ndev);
 
+	/* Handle lec errors on the bus */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		work_done += ifi_canfd_handle_lec_err(ndev, errctr);
+
 	/* Handle normal messages on RX */
 	if (!(rxstcmd & IFI_CANFD_RXSTCMD_EMPTY))
 		work_done += ifi_canfd_do_rx_poll(ndev, quota - work_done);
@@ -499,7 +588,8 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 	struct net_device_stats *stats = &ndev->stats;
 	const u32 rx_irq_mask = IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY |
 				IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER |
-				IFI_CANFD_INTERRUPT_ERROR_WARNING;
+				IFI_CANFD_INTERRUPT_ERROR_WARNING |
+				IFI_CANFD_INTERRUPT_ERROR_COUNTER;
 	const u32 tx_irq_mask = IFI_CANFD_INTERRUPT_TXFIFO_EMPTY |
 				IFI_CANFD_INTERRUPT_TXFIFO_REMOVE;
 	const u32 clr_irq_mask = ~(IFI_CANFD_INTERRUPT_SET_IRQ |
@@ -657,6 +747,12 @@ static void ifi_canfd_start(struct net_device *ndev)
 
 	ifi_canfd_irq_enable(ndev, 1);
 
+	/* Unlock, reset and enable the error counter. */
+	writel(IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC,
+	       priv->base + IFI_CANFD_ERROR_CTR);
+	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
+	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);
+
 	/* Enable controller */
 	writel(stcmd, priv->base + IFI_CANFD_STCMD);
 }
@@ -665,6 +761,10 @@ static void ifi_canfd_stop(struct net_device *ndev)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
 
+	/* Reset and disable the error counter. */
+	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
+	writel(0, priv->base + IFI_CANFD_ERROR_CTR);
+
 	/* Reset the IP */
 	writel(IFI_CANFD_STCMD_HARDRESET, priv->base + IFI_CANFD_STCMD);
 
@@ -868,7 +968,8 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 				       CAN_CTRLMODE_LISTENONLY |
 				       CAN_CTRLMODE_FD |
-				       CAN_CTRLMODE_FD_NON_ISO;
+				       CAN_CTRLMODE_FD_NON_ISO |
+				       CAN_CTRLMODE_BERR_REPORTING;
 
 	platform_set_drvdata(pdev, ndev);
 	SET_NETDEV_DEV(ndev, dev);
-- 
2.7.0

