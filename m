From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH] can: ti_hecc: fix close when napi poll is active
Date: Sat,  7 Apr 2018 22:21:39 +0200
Message-ID: <1523132500-26070-1-git-send-email-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: jhofstee@victronenergy.com, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

When closing this CAN interface while napi poll is active, for example with:
`ip link set can0 down` several interfaces freeze. This seemed to be caused
by napi_disable called from ti_hecc_close expecting the scheduled probe to
either return quota or call napi_complete. Since the poll functions has a
check for netif_running it returns 0 and doesn't call napi_complete and hence
violates the napi its expectation.

So remove this check, so either napi_complete is called or quota is returned.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 drivers/net/can/ti_hecc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index db6ea93..42813d3 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -603,9 +603,6 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
 	u32 mbx_mask;
 	unsigned long pending_pkts, flags;
 
-	if (!netif_running(ndev))
-		return 0;
-
 	while ((pending_pkts = hecc_read(priv, HECC_CANRMP)) &&
 		num_pkts < quota) {
 		mbx_mask = BIT(priv->rx_next); /* next rx mailbox to process */
-- 
2.7.4
