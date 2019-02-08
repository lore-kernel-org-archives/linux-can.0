From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] can: peak_canfd: mark expected switch fall-through
Date: Fri, 8 Feb 2019 12:57:59 -0600
Message-ID: <20190208185759.GA4062@embeddedor>
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

Notice that, in this particular case, a spelling mistake
is fixed.

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index c458d5fdc8d3..e4f4d65a76b4 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -668,7 +668,7 @@ static int pciefd_can_probe(struct pciefd_board *pciefd)
 		pciefd_can_writereg(priv, CANFD_CLK_SEL_80MHZ,
 				    PCIEFD_REG_CAN_CLK_SEL);
 
-		/* fallthough */
+		/* fall through */
 	case CANFD_CLK_SEL_80MHZ:
 		priv->ucan.can.clock.freq = 80 * 1000 * 1000;
 		break;
-- 
2.20.1
