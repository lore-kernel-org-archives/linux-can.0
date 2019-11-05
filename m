From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 24/33] can: ti_hecc: release the mailbox a bit earlier
Date: Tue,  5 Nov 2019 17:32:06 +0100
Message-ID: <20191105163215.30194-25-mkl@pengutronix.de>
References: <20191105163215.30194-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191105163215.30194-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Jeroen Hofstee <jhofstee@victronenergy.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Jeroen Hofstee <jhofstee@victronenergy.com>

Release the mailbox after reading it, so it can be reused a bit earlier.
Since "can: rx-offload: continue on error" all pending message bits are
cleared directly, so remove clearing them in ti_hecc.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index d6a84f8ff863..6ea29126c60b 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -530,8 +530,9 @@ static unsigned int ti_hecc_mailbox_read(struct can_rx_offload *offload,
 					 u32 *timestamp, unsigned int mbxno)
 {
 	struct ti_hecc_priv *priv = rx_offload_to_priv(offload);
-	u32 data;
+	u32 data, mbx_mask;
 
+	mbx_mask = BIT(mbxno);
 	data = hecc_read_mbx(priv, mbxno, HECC_CANMID);
 	if (data & HECC_CANMID_IDE)
 		cf->can_id = (data & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -551,6 +552,7 @@ static unsigned int ti_hecc_mailbox_read(struct can_rx_offload *offload,
 	}
 
 	*timestamp = hecc_read_stamp(priv, mbxno);
+	hecc_write(priv, HECC_CANRMP, mbx_mask);
 
 	return 1;
 }
@@ -701,7 +703,6 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 		while ((rx_pending = hecc_read(priv, HECC_CANRMP))) {
 			can_rx_offload_irq_offload_timestamp(&priv->offload,
 							     rx_pending);
-			hecc_write(priv, HECC_CANRMP, rx_pending);
 		}
 	}
 
-- 
2.24.0.rc1
