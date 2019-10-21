From: Pankaj Sharma <pankj.sharma@samsung.com>
Subject: [PATCH v3] can: m_can: add support for one shot mode
Date: Mon, 21 Oct 2019 17:34:40 +0530
Message-ID: <1571659480-29109-1-git-send-email-pankj.sharma@samsung.com>
References: <CGME20191021120513epcas5p2fd23f5dbdff6a0e6aa3b0726b30e4b60@epcas5p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, Pankaj Sharma <pankj.sharma@samsung.com>, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

According to the CAN Specification (see ISO 11898-1:2015, 8.3.4
Recovery Management), the M_CAN provides means for automatic
retransmission of frames that have lost arbitration or that
have been disturbed by errors during transmission. By default
automatic retransmission is enabled.

The Bosch MCAN controller has support for disabling automatic
retransmission.

To support time-triggered communication as described in ISO
11898-1:2015, chapter 9.2, the automatic retransmission may be
disabled via CCCR.DAR.

CAN_CTRLMODE_ONE_SHOT is used for disabling automatic retransmission.

Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
---

changes in v3: 
- resolving build errors for net-next branch

changes in v2:
- rebase to net-next

 drivers/net/can/m_can/m_can.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 562c8317e3aa..75e7490c4299 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -123,6 +123,7 @@ enum m_can_reg {
 #define CCCR_CME_CANFD_BRS	0x2
 #define CCCR_TXP		BIT(14)
 #define CCCR_TEST		BIT(7)
+#define CCCR_DAR		BIT(6)
 #define CCCR_MON		BIT(5)
 #define CCCR_CSR		BIT(4)
 #define CCCR_CSA		BIT(3)
@@ -1135,7 +1136,7 @@ static void m_can_chip_config(struct net_device *dev)
 	if (cdev->version == 30) {
 	/* Version 3.0.x */
 
-		cccr &= ~(CCCR_TEST | CCCR_MON |
+		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_DAR |
 			(CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
 			(CCCR_CME_MASK << CCCR_CME_SHIFT));
 
@@ -1145,7 +1146,7 @@ static void m_can_chip_config(struct net_device *dev)
 	} else {
 	/* Version 3.1.x or 3.2.x */
 		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE |
-			  CCCR_NISO);
+			  CCCR_NISO | CCCR_DAR);
 
 		/* Only 3.2.x has NISO Bit implemented */
 		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
@@ -1165,6 +1166,10 @@ static void m_can_chip_config(struct net_device *dev)
 	if (cdev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		cccr |= CCCR_MON;
 
+	/* Disable Auto Retransmission (all versions) */
+	if (cdev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		cccr |= CCCR_DAR;
+
 	/* Write config */
 	m_can_write(cdev, M_CAN_CCCR, cccr);
 	m_can_write(cdev, M_CAN_TEST, test);
@@ -1310,7 +1315,8 @@ static int m_can_dev_setup(struct m_can_classdev *m_can_dev)
 	m_can_dev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 					CAN_CTRLMODE_LISTENONLY |
 					CAN_CTRLMODE_BERR_REPORTING |
-					CAN_CTRLMODE_FD;
+					CAN_CTRLMODE_FD |
+					CAN_CTRLMODE_ONE_SHOT;
 
 	/* Set properties depending on M_CAN version */
 	switch (m_can_dev->version) {
-- 
2.17.1
