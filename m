From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH 2/5] can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
Date: Fri, 26 Jan 2018 16:27:20 +0200
Message-ID: <20180126142723.3212-3-anssi.hannula@bitwise.fi>
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:60712 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752386AbeAZOht (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 26 Jan 2018 09:37:49 -0500
In-Reply-To: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>, stable@vger.kernel.org

If the device gets into a state where RXNEMP (RX FIFO not empty)
interrupt is asserted without RXOK (new frame received successfully)
interrupt being asserted, xcan_rx_poll() will continue to try to clear
RXNEMP without actually reading frames from RX FIFO. If the RX FIFO is
not empty, the interrupt will not be cleared and napi_schedule() will
just be called again.

This situation can occur when:

(a) xcan_rx() returns without reading RX FIFO due to an error condition.
The code tries to clear both RXOK and RXNEMP but RXNEMP will not clear
due to a frame still being in the FIFO. The frame will never be read
from the FIFO as RXOK is no longer set.

(b) A frame is received between xcan_rx_poll() reading interrupt status
and clearing RXOK. RXOK will be cleared, but RXNEMP will again remain
set as the new message is still in the FIFO.

I'm able to trigger case (b) by flooding the bus with frames under load.

There does not seem to be any benefit in using both RXNEMP and RXOK in
the way the driver does, and the polling example in the reference manual
(UG585 v1.10 18.3.7 Read Messages from RxFIFO) also says that either
RXOK or RXNEMP can be used for detecting incoming messages.

Fix the issue and simplify the RX processing by only using RXNEMP
without RXOK.

Tested with the integrated CAN on Zynq-7000 SoC.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: <stable@vger.kernel.org>
---
 drivers/net/can/xilinx_can.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 389a960..1bda47a 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -101,7 +101,7 @@ enum xcan_reg {
 #define XCAN_INTR_ALL		(XCAN_IXR_TXOK_MASK | XCAN_IXR_BSOFF_MASK |\
 				 XCAN_IXR_WKUP_MASK | XCAN_IXR_SLP_MASK | \
 				 XCAN_IXR_RXNEMP_MASK | XCAN_IXR_ERROR_MASK | \
-				 XCAN_IXR_ARBLST_MASK | XCAN_IXR_RXOK_MASK)
+				 XCAN_IXR_ARBLST_MASK)
 
 /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
 #define XCAN_BTR_SJW_SHIFT		7  /* Synchronous jump width */
@@ -708,15 +708,7 @@ static int xcan_rx_poll(struct napi_struct *napi, int quota)
 
 	isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
 	while ((isr & XCAN_IXR_RXNEMP_MASK) && (work_done < quota)) {
-		if (isr & XCAN_IXR_RXOK_MASK) {
-			priv->write_reg(priv, XCAN_ICR_OFFSET,
-				XCAN_IXR_RXOK_MASK);
-			work_done += xcan_rx(ndev);
-		} else {
-			priv->write_reg(priv, XCAN_ICR_OFFSET,
-				XCAN_IXR_RXNEMP_MASK);
-			break;
-		}
+		work_done += xcan_rx(ndev);
 		priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_RXNEMP_MASK);
 		isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
 	}
@@ -727,7 +719,7 @@ static int xcan_rx_poll(struct napi_struct *napi, int quota)
 	if (work_done < quota) {
 		napi_complete_done(napi, work_done);
 		ier = priv->read_reg(priv, XCAN_IER_OFFSET);
-		ier |= (XCAN_IXR_RXOK_MASK | XCAN_IXR_RXNEMP_MASK);
+		ier |= XCAN_IXR_RXNEMP_MASK;
 		priv->write_reg(priv, XCAN_IER_OFFSET, ier);
 	}
 	return work_done;
@@ -799,9 +791,9 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 	}
 
 	/* Check for the type of receive interrupt and Processing it */
-	if (isr & (XCAN_IXR_RXNEMP_MASK | XCAN_IXR_RXOK_MASK)) {
+	if (isr & XCAN_IXR_RXNEMP_MASK) {
 		ier = priv->read_reg(priv, XCAN_IER_OFFSET);
-		ier &= ~(XCAN_IXR_RXNEMP_MASK | XCAN_IXR_RXOK_MASK);
+		ier &= ~XCAN_IXR_RXNEMP_MASK;
 		priv->write_reg(priv, XCAN_IER_OFFSET, ier);
 		napi_schedule(&priv->napi);
 	}
-- 
2.8.3

