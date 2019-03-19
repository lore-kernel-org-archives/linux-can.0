From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v11 5/5] can: m_can: Fix checkpatch issues on existing code
Date: Tue, 19 Mar 2019 12:26:51 -0500
Message-ID: <20190319172651.10012-5-dmurphy@ti.com>
References: <20190319172651.10012-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319172651.10012-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

Fix checkpatch issues found during the m_can framework creation.
The code the issues were in, was in untouched code and these
changes should be done separately as to not be confused with the
framework changes.

Fix these 3 check issues:
CHECK: Unnecessary parentheses around 'cdev->can.state != CAN_STATE_ERROR_WARNING'
	if (psr & PSR_EW &&
	    (cdev->can.state != CAN_STATE_ERROR_WARNING)) {

CHECK: Unnecessary parentheses around 'cdev->can.state != CAN_STATE_ERROR_PASSIVE'
	if ((psr & PSR_EP) &&
	    (cdev->can.state != CAN_STATE_ERROR_PASSIVE)) {

CHECK: Unnecessary parentheses around 'cdev->can.state != CAN_STATE_BUS_OFF'
	if ((psr & PSR_BO) &&
	    (cdev->can.state != CAN_STATE_BUS_OFF)) {

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v11 - New change to clean up last remaining checkpatch issues on original code.

 drivers/net/can/m_can/m_can.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 0759c61a7e5a..1245da6f79ff 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -750,22 +750,19 @@ static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int work_done = 0;
 
-	if ((psr & PSR_EW) &&
-	    (cdev->can.state != CAN_STATE_ERROR_WARNING)) {
+	if (psr & PSR_EW && cdev->can.state != CAN_STATE_ERROR_WARNING) {
 		netdev_dbg(dev, "entered error warning state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_ERROR_WARNING);
 	}
 
-	if ((psr & PSR_EP) &&
-	    (cdev->can.state != CAN_STATE_ERROR_PASSIVE)) {
+	if (psr & PSR_EP && cdev->can.state != CAN_STATE_ERROR_PASSIVE) {
 		netdev_dbg(dev, "entered error passive state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_ERROR_PASSIVE);
 	}
 
-	if ((psr & PSR_BO) &&
-	    (cdev->can.state != CAN_STATE_BUS_OFF)) {
+	if (psr & PSR_BO && cdev->can.state != CAN_STATE_BUS_OFF) {
 		netdev_dbg(dev, "entered error bus off state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_BUS_OFF);
-- 
2.20.1.390.gb5101f9297
