From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 07/29] can: peak_usb: report bus recovery as well
Date: Thu, 10 Oct 2019 14:17:28 +0200
Message-ID: <20191010121750.27237-8-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Jeroen Hofstee <jhofstee@victronenergy.com>

While the state changes are reported when the error counters increase
and decrease, there is no event when the bus recovers and the error
counters decrease again. So add those as well.

Change the state going downward to be ERROR_PASSIVE -> ERROR_WARNING ->
ERROR_ACTIVE instead of directly to ERROR_ACTIVE again.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 5a66c9f53aae..d2539c95adb6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -436,8 +436,8 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 		}
 		if ((n & PCAN_USB_ERROR_BUS_LIGHT) == 0) {
 			/* no error (back to active state) */
-			mc->pdev->dev.can.state = CAN_STATE_ERROR_ACTIVE;
-			return 0;
+			new_state = CAN_STATE_ERROR_ACTIVE;
+			break;
 		}
 		break;
 
@@ -460,9 +460,9 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 		}
 
 		if ((n & PCAN_USB_ERROR_BUS_HEAVY) == 0) {
-			/* no error (back to active state) */
-			mc->pdev->dev.can.state = CAN_STATE_ERROR_ACTIVE;
-			return 0;
+			/* no error (back to warning state) */
+			new_state = CAN_STATE_ERROR_WARNING;
+			break;
 		}
 		break;
 
@@ -501,6 +501,11 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 		mc->pdev->dev.can.can_stats.error_warning++;
 		break;
 
+	case CAN_STATE_ERROR_ACTIVE:
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+		break;
+
 	default:
 		/* CAN_STATE_MAX (trick to handle other errors) */
 		cf->can_id |= CAN_ERR_CRTL;
-- 
2.23.0
