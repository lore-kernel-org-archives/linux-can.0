From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/4] can: sja1000: force the string buffer NULL-terminated
Date: Fri,  2 Aug 2019 14:00:35 +0200
Message-ID: <20190802120038.18154-2-mkl@pengutronix.de>
References: <20190802120038.18154-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190802120038.18154-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Wang Xiayang <xywang.sjtu@sjtu.edu.cn>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>

strncpy() does not ensure NULL-termination when the input string size
equals to the destination buffer size IFNAMSIZ. The output string
'name' is passed to dev_info which relies on NULL-termination.

Use strlcpy() instead.

This issue is identified by a Coccinelle script.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/peak_pcmcia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index 185c7f7d38a4..5e0d5e8101c8 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -479,7 +479,7 @@ static void pcan_free_channels(struct pcan_pccard *card)
 		if (!netdev)
 			continue;
 
-		strncpy(name, netdev->name, IFNAMSIZ);
+		strlcpy(name, netdev->name, IFNAMSIZ);
 
 		unregister_sja1000dev(netdev);
 
-- 
2.20.1
