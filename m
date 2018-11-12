From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/20] can: kvaser_usb: Fix potential uninitialized variable use
Date: Mon, 12 Nov 2018 12:57:10 +0100
Message-ID: <20181112115728.18331-3-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Jimmy Assarsson <jimmyassarsson@gmail.com>

If alloc_can_err_skb() fails, cf is never initialized.
Move assignment of cf inside check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index c084bae5ec0a..5fc0be564274 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1019,6 +1019,11 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 					new_state : CAN_STATE_ERROR_ACTIVE;
 
 			can_change_state(netdev, cf, tx_state, rx_state);
+
+			if (priv->can.restart_ms &&
+			    old_state >= CAN_STATE_BUS_OFF &&
+			    new_state < CAN_STATE_BUS_OFF)
+				cf->can_id |= CAN_ERR_RESTARTED;
 		}
 
 		if (new_state == CAN_STATE_BUS_OFF) {
@@ -1028,11 +1033,6 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 
 			can_bus_off(netdev);
 		}
-
-		if (priv->can.restart_ms &&
-		    old_state >= CAN_STATE_BUS_OFF &&
-		    new_state < CAN_STATE_BUS_OFF)
-			cf->can_id |= CAN_ERR_RESTARTED;
 	}
 
 	if (!skb) {
-- 
2.19.1
