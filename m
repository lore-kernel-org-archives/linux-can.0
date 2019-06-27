From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 41/95] can: flexcan: Remove unneeded registration message
Date: Wed, 26 Jun 2019 20:29:26 -0400
Message-ID: <20190627003021.19867-41-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit eb503004a7e563d543c9cb869907156de7efe720 ]

Currently the following message is observed when the flexcan
driver is probed:

flexcan 2090000.flexcan: device registered (reg_base=(ptrval), irq=23)

The reason for printing 'ptrval' is explained at
Documentation/core-api/printk-formats.rst:

"Pointers printed without a specifier extension (i.e unadorned %p) are
hashed to prevent leaking information about the kernel memory layout. This
has the added benefit of providing a unique identifier. On 64-bit machines
the first 32 bits are zeroed. The kernel will print ``(ptrval)`` until it
gathers enough entropy."

Instead of passing %pK, which can print the correct address, simply
remove the entire message as it is not really that useful.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1c66fb2ad76b..05e5609f87f8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1583,9 +1583,6 @@ static int flexcan_probe(struct platform_device *pdev)
 			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
 	}
 
-	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
-		 priv->regs, dev->irq);
-
 	return 0;
 
  failed_register:
-- 
2.20.1
