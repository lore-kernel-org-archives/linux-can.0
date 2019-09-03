From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/4] can: mcp251x: Call wrapper instead of regulator_disable()
Date: Tue,  3 Sep 2019 15:42:58 +0300
Message-ID: <20190903124259.60920-4-andriy.shevchenko@linux.intel.com>
References: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-can.vger.kernel.org

There is no need to check for regulator presence in the ->suspend()
since a wrapper does it for us. Due to this we may unconditionally set
AFTER_SUSPEND_POWER flag.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/can/spi/mcp251x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 0b7e743ca0a0..6ee0ea51399a 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1162,10 +1162,8 @@ static int __maybe_unused mcp251x_can_suspend(struct device *dev)
 		priv->after_suspend = AFTER_SUSPEND_DOWN;
 	}
 
-	if (!IS_ERR_OR_NULL(priv->power)) {
-		regulator_disable(priv->power);
-		priv->after_suspend |= AFTER_SUSPEND_POWER;
-	}
+	mcp251x_power_enable(priv->power, 0);
+	priv->after_suspend |= AFTER_SUSPEND_POWER;
 
 	return 0;
 }
-- 
2.23.0.rc1
