From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v3 24/27] can: replace devm_ioremap_nocache with devm_ioremap
Date: Sat, 23 Dec 2017 19:02:15 +0800
Message-ID: <1514026935-33713-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: ysxie@foxmail.com, Yisheng Xie <xieyisheng1@huawei.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Default ioremap is ioremap_nocache, so devm_ioremap has the same
function with devm_ioremap_nocache, which can just be killed to
save the size of devres.o

This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
which should not have any function change but prepare for killing
devm_ioremap_nocache.

Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/net/can/sja1000/sja1000_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index dc9c6db..c59500c 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -240,8 +240,8 @@ static int sp_probe(struct platform_device *pdev)
 				     resource_size(res_mem), DRV_NAME))
 		return -EBUSY;
 
-	addr = devm_ioremap_nocache(&pdev->dev, res_mem->start,
-				    resource_size(res_mem));
+	addr = devm_ioremap(&pdev->dev, res_mem->start,
+			    resource_size(res_mem));
 	if (!addr)
 		return -ENOMEM;
 
-- 
1.8.3.1
