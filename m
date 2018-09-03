From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] can: peak_canfd: fix spelling mistake in fall-through
 annotation
Date: Mon, 3 Sep 2018 13:09:07 -0500
Message-ID: <20180903180907.GA627@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-can.vger.kernel.org

Replace "fallthough" with a proper "fall through" annotation.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index c458d5f..e4f4d65a 100644
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
2.7.4
