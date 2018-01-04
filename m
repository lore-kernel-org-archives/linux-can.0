From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/4] can: ems_usb: improve error reporting for error warning and error passive
Date: Thu,  4 Jan 2018 16:33:55 +0100
Message-ID: <20180104153355.11243-5-mkl@pengutronix.de>
References: <20180104153355.11243-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180104153355.11243-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Martin Lederhilger <m.lederhilger@ds-automotion.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Martin Lederhilger <m.lederhilger@ds-automotion.com>

This patch adds the missing CAN_ERR_CRTL to cf->can_id in case of
CAN_STATE_ERROR_WARNING or CAN_STATE_ERROR_PASSIVE

Signed-off-by: Martin Lederhilger <m.lederhilger@ds-automotion.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index b00358297424..12ff0020ecd6 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -395,6 +395,7 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 
 		if (dev->can.state == CAN_STATE_ERROR_WARNING ||
 		    dev->can.state == CAN_STATE_ERROR_PASSIVE) {
+			cf->can_id |= CAN_ERR_CRTL;
 			cf->data[1] = (txerr > rxerr) ?
 			    CAN_ERR_CRTL_TX_PASSIVE : CAN_ERR_CRTL_RX_PASSIVE;
 		}
-- 
2.15.1
