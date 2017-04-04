From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: ifi: use correct register to read rx status
Date: Tue,  4 Apr 2017 17:59:48 +0200
Message-ID: <20170404155949.30965-2-mkl@pengutronix.de>
References: <20170404155949.30965-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170404155949.30965-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Markus Marb <markus@marb.org>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Markus Marb <markus@marb.org>

The incorrect offset was used when trying to read the RXSTCMD register.

Signed-off-by: Markus Marb <markus@marb.org>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 138f5ae75c0b..4d1fe8d95042 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -557,7 +557,7 @@ static int ifi_canfd_poll(struct napi_struct *napi, int quota)
 	int work_done = 0;
 
 	u32 stcmd = readl(priv->base + IFI_CANFD_STCMD);
-	u32 rxstcmd = readl(priv->base + IFI_CANFD_STCMD);
+	u32 rxstcmd = readl(priv->base + IFI_CANFD_RXSTCMD);
 	u32 errctr = readl(priv->base + IFI_CANFD_ERROR_CTR);
 
 	/* Handle bus state changes */
-- 
2.11.0
