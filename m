From: Dinghao Liu <dinghao.liu@zju.edu.cn>
Subject: [PATCH] can: flexcan: Fix runtime PM imbalance on error
Date: Fri, 22 May 2020 17:43:40 +0800
Message-ID: <20200522094340.18059-1-dinghao.liu@zju.edu.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

When register_flexcandev() returns an error code, a
pairing runtime PM usage counter decrement is needed
to keep the counter balanced.

Also, call pm_runtime_disable() when register_flexcandev()
returns an error code.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/net/can/flexcan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 94d10ec954a0..ea193426e5ae 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1666,6 +1666,8 @@ static int flexcan_probe(struct platform_device *pdev)
 	return 0;
 
  failed_register:
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	free_candev(dev);
 	return err;
 }
-- 
2.17.1
