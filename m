From: Pankaj Sharma <pankj.sharma@samsung.com>
Subject: [PATCH v2] can: m_can: add support for handling arbitration error
Date: Mon, 21 Oct 2019 17:43:36 +0530
Message-ID: <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
References: <CGME20191021121350epcas5p3313e54a3bc5c8600c52a6db299893f78@epcas5p3.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, jhofstee@victronenergy.com, simon.horman@netronome.com, Pankaj Sharma <pankj.sharma@samsung.com>, Sriram Dash <sriram.dash@samsung.com>
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

changes in v2:
- common m_can_ prefix for is_protocol_err function
- handling stats even if the allocation of the skb fails
- resolving build errors on net-next branch

 drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 75e7490c4299..a736297a875f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -778,6 +778,38 @@ static inline bool is_lec_err(u32 psr)
 	return psr && (psr != LEC_UNUSED);
 }
 
+static inline bool m_can_is_protocol_err(u32 irqstatus)
+{
+	return irqstatus & IR_ERR_LEC_31X;
+}
+
+static int m_can_handle_protocol_error(struct net_device *dev, u32 irqstatus)
+{
+	struct net_device_stats *stats = &dev->stats;
+	struct m_can_classdev *cdev = netdev_priv(dev);
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	/* propagate the error condition to the CAN stack */
+	skb = alloc_can_err_skb(dev, &cf);
+	if (unlikely(!skb)) {
+		netdev_dbg(dev, "allocation of skb failed\n");
+		stats->tx_errors++;
+		return 0;
+	}
+	if (cdev->version >= 31 && (irqstatus & IR_PEA)) {
+		netdev_dbg(dev, "Protocol error in Arbitration fail\n");
+		stats->tx_errors++;
+		cdev->can.can_stats.arbitration_lost++;
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
@@ -792,6 +824,11 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 	    is_lec_err(psr))
 		work_done += m_can_handle_lec_err(dev, psr & LEC_UNUSED);
 
+	/* handle protocol errors in arbitration phase */
+	if ((cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
+	    m_can_is_protocol_err(irqstatus))
+		work_done += m_can_handle_protocol_error(dev, irqstatus);
+
 	/* other unproccessed error interrupts */
 	m_can_handle_other_err(dev, irqstatus);
 
-- 
2.17.1
