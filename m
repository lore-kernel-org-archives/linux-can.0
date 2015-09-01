From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/8] can: flexcan: activate individual RX masking and initialize reg_rximr
Date: Tue,  1 Sep 2015 12:31:56 +0200
Message-ID: <1441103522-15593-3-git-send-email-mkl@pengutronix.de>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42879 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbbIAKcK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 06:32:10 -0400
In-Reply-To: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

Modern flexcan IP cores support two RX modes. One is using the 6 fames deep
hardware FIFO, the other is using up to 64 mailboxes (in non FIFO mode). For
now only the HW FIFO mode is activated.

In order to make use of the RX mailboxes the individual RX masking feature has
to be activated, otherwise matching mailboxes are overwritten during the
reception process. This however switches on the individual RX masking, which
uses reg_rximr registers for masking.

This patch activates the individual RX masking feature unconditionally and
initializes the mask registers (reg_rximr) with 0x0 == "don't care", which
switches off any filtering.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 457688f2929e..4c65a6795c77 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -815,6 +815,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	 * only supervisor access
 	 * enable warning int
 	 * disable local echo
+	 * enable individual RX masking
 	 * choose format C
 	 * set max mailbox number
 	 */
@@ -822,7 +823,8 @@ static int flexcan_chip_start(struct net_device *dev)
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS |
-		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+		FLEXCAN_MCR_IRMQ | FLEXCAN_MCR_IDAM_C |
+		FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
@@ -881,6 +883,10 @@ static int flexcan_chip_start(struct net_device *dev)
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_DISABLE_RXFG)
 		flexcan_write(0x0, &regs->rxfgmask);
 
+	/* clear acceptance filters */
+	for (i = 0; i < ARRAY_SIZE(regs->mb); i++)
+		flexcan_write(0, &regs->rximr[i]);
+
 	/* On Vybrid, disable memory error detection interrupts
 	 * and freeze mode.
 	 * This also works around errata e5295 which generates
-- 
2.5.0

