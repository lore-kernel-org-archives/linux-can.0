From: Pankaj Sharma <pankj.sharma@samsung.com>
Subject: [PATCH] can: m_can: add support for handling arbitration error
Date: Mon, 14 Oct 2019 17:04:04 +0530
Message-ID: <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
References: <CGME20191014113437epcas5p2143d7e85d5a50dad79a4a60a9d666fe4@epcas5p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, Pankaj Sharma <pankj.sharma@samsung.com>, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

The Bosch MCAN hardware (3.1.0 and above) supports interrupt flag to
detect Protocol error in arbitration phase.

Transmit error statistics is currently not updated from the MCAN driver.
Protocol error in arbitration phase is a TX error and the network
statistics should be updated accordingly.

The member "tx_error" of "struct net_device_stats" should be incremented
as arbitration is a transmit protocol error. Also "arbitration_lost" of
"struct can_device_stats" should be incremented to report arbitration
lost.

Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
---
 drivers/net/can/m_can/m_can.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b95b382eb308..7efafee0eec8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -778,6 +778,39 @@ static inline bool is_lec_err(u32 psr)
 	return psr && (psr != LEC_UNUSED);
 }
 
+static inline bool is_protocol_err(u32 irqstatus)
+{
+	if (irqstatus & IR_ERR_LEC_31X)
+		return 1;
+	else
+		return 0;
+}
+
+static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
+{
+	struct net_device_stats *stats = &dev->stats;
+	struct m_can_priv *priv = netdev_priv(dev);
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	/* propagate the error condition to the CAN stack */
+	skb = alloc_can_err_skb(dev, &cf);
+	if (unlikely(!skb))
+		return 0;
+
+	if (priv->version >= 31 && (irqstatus & IR_PEA)) {
+		netdev_dbg(dev, "Protocol error in Arbitration fail\n");
+		stats->tx_errors++;
+		priv->can.can_stats.arbitration_lost++;
+		cf->can_id |= CAN_ERR_LOSTARB;
+		cf->data[0] |= CAN_ERR_LOSTARB_UNSPEC;
+	}
+
+	netif_receive_skb(skb);
+
+	return 1;
+}
+
 static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 				   u32 psr)
 {
@@ -792,6 +825,11 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 	    is_lec_err(psr))
 		work_done += m_can_handle_lec_err(dev, psr & LEC_UNUSED);
 
+	/* handle protocol errors in arbitration phase */
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
+	    is_protocol_err(irqstatus))
+		work_done += m_can_handle_protocol_error(dev, irqstatus);
+
 	/* other unproccessed error interrupts */
 	m_can_handle_other_err(dev, irqstatus);
 
-- 
2.17.1
