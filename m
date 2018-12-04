From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH net-next] can: flexcan: flexcan_chip_start(): fix the error return code in flexcan_setup_stop_mode()
Date: Tue, 4 Dec 2018 06:26:20 +0000
Message-ID: <1543904780-30235-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The error return code PTR_ERR(gpr_np) is always 0 since gpr_np is
equal to NULL in this error handling case. Fix it by return -ENOENT.

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eaf..f412d84 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1432,7 +1432,7 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 	gpr_np = of_find_node_by_phandle(phandle);
 	if (!gpr_np) {
 		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
-		return PTR_ERR(gpr_np);
+		return -ENOENT;
 	}
 
 	priv = netdev_priv(dev);
