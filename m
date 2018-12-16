From: Colin King <colin.king@canonical.com>
Subject: [PATCH] can: m_can: fix overly indented if statement
Date: Sun, 16 Dec 2018 13:37:49 +0000
Message-ID: <20181216133749.5478-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an if statement that is indented too much by one level,
remove the extra tab to fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/can/m_can/m_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9b449400376b..a5d22a022f41 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1492,9 +1492,9 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 		m_can_write(priv, M_CAN_TXBAR, (1 << putidx));
 
 		/* stop network queue if fifo full */
-			if (m_can_tx_fifo_full(priv) ||
-			    m_can_next_echo_skb_occupied(dev, putidx))
-				netif_stop_queue(dev);
+		if (m_can_tx_fifo_full(priv) ||
+		    m_can_next_echo_skb_occupied(dev, putidx))
+			netif_stop_queue(dev);
 	}
 
 	return NETDEV_TX_OK;
-- 
2.19.1
