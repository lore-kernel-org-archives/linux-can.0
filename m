From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/12] can: m_can.c: fix setup of CCCR register: clear CCCR NISO bit before checking can.ctrlmode
Date: Mon, 23 Jul 2018 14:58:33 +0200
Message-ID: <20180723125843.391-3-mkl@pengutronix.de>
References: <20180723125843.391-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180723125843.391-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Roman Fietze <roman.fietze@telemotive.de>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Roman Fietze <roman.fietze@telemotive.de>

Inside m_can_chip_config(), when setting up the new value of the CCCR,
the CCCR_NISO bit is not cleared like the others, CCCR_TEST, CCCR_MON,
CCCR_BRSE and CCCR_FDOE, before checking the can.ctrlmode bits for
CAN_CTRLMODE_FD_NON_ISO.

This way once the controller was configured for CAN_CTRLMODE_FD_NON_ISO,
this mode could never be cleared again.

This fix is only relevant for controllers with version 3.1.x or 3.2.x.
Older versions do not support NISO.

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b397a33f3d32..8e2b7f873c4d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1109,7 +1109,8 @@ static void m_can_chip_config(struct net_device *dev)
 
 	} else {
 	/* Version 3.1.x or 3.2.x */
-		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE);
+		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE |
+			  CCCR_NISO);
 
 		/* Only 3.2.x has NISO Bit implemented */
 		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
-- 
2.18.0
