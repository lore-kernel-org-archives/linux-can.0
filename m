From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] can: at91_can: mark expected switch fall-throughs
Date: Fri, 8 Feb 2019 12:44:44 -0600
Message-ID: <20190208184444.GA28484@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-can.vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

Notice that, in this particular case, the /* fall through */
comments are placed at the bottom of the case statement, which
is what GCC is expecting to find.

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/at91_can.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index d98c69045b17..1718c20f9c99 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
 				CAN_ERR_CRTL_TX_WARNING :
 				CAN_ERR_CRTL_RX_WARNING;
 		}
-	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+		/* fall through */
+	case CAN_STATE_ERROR_WARNING:
 		/*
 		 * from: ERROR_ACTIVE, ERROR_WARNING
 		 * to  : ERROR_PASSIVE, BUS_OFF
@@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
 		netdev_dbg(dev, "Error Active\n");
 		cf->can_id |= CAN_ERR_PROT;
 		cf->data[2] = CAN_ERR_PROT_ACTIVE;
-	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+		/* fall through */
+	case CAN_STATE_ERROR_WARNING:
 		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
 		reg_ier = AT91_IRQ_ERRP;
 		break;
-- 
2.20.1
