From: Felix Riemann <felix.riemann@sma.de>
Subject: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are disabled
Date: Thu, 26 Mar 2020 11:43:18 +0100
Message-ID: <20200326104318.15086-1-felix.riemann@sma.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from wp548.webpack.hosteurope.de ([80.237.130.70]:52638 "EHLO
        wp548.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727928AbgCZLBs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 26 Mar 2020 07:01:48 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Felix Riemann <felix.riemann@sma.de>, Andre Kalb <andre.kalb@sma.de>

There are appears to be a race condition where interrupts caused
by bus offs get lost if it occurs while interrupts are disabled
or being re-enabled.

This tries to avoid the deadlock by rescheduling the NAPI worker
to handle the bus-off condition.

Signed-off-by: Felix Riemann <felix.riemann@sma.de>
Reviewed-by: Andre Kalb <andre.kalb@sma.de>
---
 drivers/net/can/c_can/c_can.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 8e9f5620c9a2..0952ac0b9123 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1123,8 +1123,25 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 	if (work_done < quota) {
 		napi_complete_done(napi, work_done);
 		/* enable all IRQs if we are not in bus off state */
-		if (priv->can.state != CAN_STATE_BUS_OFF)
+		if (priv->can.state != CAN_STATE_BUS_OFF) {
+			u32 ctrl;
 			c_can_irq_control(priv, true);
+
+			/* There appears to be a race condition when the device
+			 * enters bus off while interrupts are off or being
+			 * re-enabled causing the bus off to get lost.
+			 * This tries to avoid this condition.
+			 */
+			ctrl = priv->read_reg(priv, C_CAN_CTRL_REG);
+
+			if (ctrl & CONTROL_INIT) {
+				netdev_warn(dev, "lost bus off\n");
+				c_can_irq_control(priv, false);
+				/* Reschedule worker to handle bus off */
+				atomic_set(&priv->sie_pending, 1);
+				napi_reschedule(napi);
+			}
+		}
 	}
 
 	return work_done;
-- 
2.26.0
