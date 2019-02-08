From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] can: mcp251x: mark expected switch fall-through
Date: Fri, 8 Feb 2019 13:02:41 -0600
Message-ID: <20190208190241.GA20200@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-can.vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

Notice that, in this particular case, the /* fall through */
comment is placed at the bottom of the case statement, which
is what GCC is expecting to find.

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/spi/mcp251x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index e90817608645..17257c73c302 100644
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
2.20.1
