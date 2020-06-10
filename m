From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/6] can: mcp25xxfd: Optimize TEF read by avoiding unnecessary SPI transfers
Date: Wed, 10 Jun 2020 13:14:41 +0530
Message-ID: <20200610074442.10808-6-manivannan.sadhasivam@linaro.org>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-can.vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

We have already enough information to know how many tx-messages have
been terminated so that we do not have to query TEF every time if
there is anything pending but we can read the tefs blindly.

This avoids 1 SPI transfer per TEF read.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
index 5ea1e525e776..6f066cb95844 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
@@ -263,6 +263,13 @@ int mcp25xxfd_can_tx_handle_int_tefif_fifo(struct mcp25xxfd_can_priv *cpriv)
 					MCP25XXFD_CAN_TEFCON_UINC);
 }
 
+/* reading TEF entries can be made even more efficient by reading
+ * multiple TEF entries in one go.
+ * Under the assumption that we have count(TEF) >= count(TX_FIFO)
+ * we can even release TEFs early (before we read them)
+ * (and potentially restarting the transmit-queue early aswell)
+ */
+
 static int
 mcp25xxfd_can_tx_handle_int_tefif_conservative(struct mcp25xxfd_can_priv *cpriv)
 {
@@ -293,6 +300,25 @@ mcp25xxfd_can_tx_handle_int_tefif_conservative(struct mcp25xxfd_can_priv *cpriv)
 	return 0;
 }
 
+static int
+mcp25xxfd_can_tx_handle_int_tefif_optimized(struct mcp25xxfd_can_priv *cpriv,
+					    u32 finished)
+{
+	int i, fifo, ret;
+
+	/* now iterate those */
+	for (i = 0, fifo = cpriv->fifos.tx.start; i < cpriv->fifos.tx.count;
+	     i++, fifo++) {
+		if (finished & BIT(fifo)) {
+			ret = mcp25xxfd_can_tx_handle_int_tefif_fifo(cpriv);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 int mcp25xxfd_can_tx_handle_int_tefif(struct mcp25xxfd_can_priv *cpriv)
 {
 	unsigned long flags;
@@ -310,6 +336,13 @@ int mcp25xxfd_can_tx_handle_int_tefif(struct mcp25xxfd_can_priv *cpriv)
 
 	spin_unlock_irqrestore(&cpriv->fifos.tx_queue->lock, flags);
 
+	/* run in optimized mode if possible */
+	if (finished)
+		return mcp25xxfd_can_tx_handle_int_tefif_optimized(cpriv,
+								   finished);
+	/* otherwise play it safe */
+	netdev_warn(cpriv->can.dev,
+		    "Something is wrong - we got a TEF interrupt but we were not able to detect a finished fifo\n");
 	return mcp25xxfd_can_tx_handle_int_tefif_conservative(cpriv);
 }
 
-- 
2.17.1
