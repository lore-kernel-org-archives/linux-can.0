From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 13/16] can: flexcan: activate individual RX masking and initialize reg_rximr
Date: Wed, 18 Jan 2017 15:52:24 +0100
Message-ID: <20170118145227.24916-14-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43125 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751414AbdARPs7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:48:59 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

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
index 57ad79cadd60..27121f9cd59b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -779,6 +779,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	 * only supervisor access
 	 * enable warning int
 	 * disable local echo
+	 * enable individual RX masking
 	 * choose format C
 	 * set max mailbox number
 	 */
@@ -786,7 +787,8 @@ static int flexcan_chip_start(struct net_device *dev)
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS |
-		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+		FLEXCAN_MCR_IRMQ | FLEXCAN_MCR_IDAM_C |
+		FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
@@ -845,6 +847,10 @@ static int flexcan_chip_start(struct net_device *dev)
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
2.11.0

