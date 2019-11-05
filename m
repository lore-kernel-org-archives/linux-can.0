From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 32/33] can: mcp251x: mcp251x_restart_work_handler(): Fix potential force_quit race condition
Date: Tue,  5 Nov 2019 17:32:14 +0100
Message-ID: <20191105163215.30194-33-mkl@pengutronix.de>
References: <20191105163215.30194-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191105163215.30194-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Timo Schlüßler <schluessler@krause.de>

In mcp251x_restart_work_handler() the variable to stop the interrupt
handler (priv->force_quit) is reset after the chip is restarted and thus
a interrupt might occur.

This patch fixes the potential race condition by resetting force_quit
before enabling interrupts.

Signed-off-by: Timo Schlüßler <schluessler@krause.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index bee9f7b8dad6..bb20a9b75cc6 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -717,6 +717,7 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 	if (priv->after_suspend) {
 		mcp251x_hw_reset(spi);
 		mcp251x_setup(net, spi);
+		priv->force_quit = 0;
 		if (priv->after_suspend & AFTER_SUSPEND_RESTART) {
 			mcp251x_set_normal_mode(spi);
 		} else if (priv->after_suspend & AFTER_SUSPEND_UP) {
@@ -728,7 +729,6 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 			mcp251x_hw_sleep(spi);
 		}
 		priv->after_suspend = 0;
-		priv->force_quit = 0;
 	}
 
 	if (priv->restart_tx) {
-- 
2.24.0.rc1
