From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] can: mcp251x: fix fall-through annotation
Date: Mon, 3 Sep 2018 13:25:41 -0500
Message-ID: <20180903182541.GA3956@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-can.vger.kernel.org

Properly place the "fall through" annotation at the bottom of the case,
which is what GCC is expecting to find.

This fix is part of the ongoing efforts to enabling -Wimplicit-fallthrough

Addresses-Coverity-ID: 114880 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/spi/mcp251x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index e908176..17257c7 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -875,7 +875,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 			if (new_state >= CAN_STATE_ERROR_WARNING &&
 			    new_state <= CAN_STATE_BUS_OFF)
 				priv->can.can_stats.error_warning++;
-		case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+			/* fall through */
+		case CAN_STATE_ERROR_WARNING:
 			if (new_state >= CAN_STATE_ERROR_PASSIVE &&
 			    new_state <= CAN_STATE_BUS_OFF)
 				priv->can.can_stats.error_passive++;
-- 
2.7.4
