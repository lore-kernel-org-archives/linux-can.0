From: Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: [PATCH net-next v2] can: ti_hecc: add missed clk_disable_unprepare() in error path
Date: Fri, 17 Jul 2020 16:04:39 +0800
Message-ID: <1594973079-27743-1-git-send-email-zhangchangzhong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:7778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbgGQIEx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 17 Jul 2020 04:04:53 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

The driver forgets to call clk_disable_unprepare() in error path after
a success calling for clk_prepare_enable().

Fix it by adding a clk_disable_unprepare() in error path.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/net/can/ti_hecc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 94b1491..228ecd4 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -950,7 +950,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
 		dev_err(&pdev->dev, "clk_prepare_enable() failed\n");
-		goto probe_exit_clk;
+		goto probe_exit_release_clk;
 	}
 
 	priv->offload.mailbox_read = ti_hecc_mailbox_read;
@@ -959,7 +959,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	err = can_rx_offload_add_timestamp(ndev, &priv->offload);
 	if (err) {
 		dev_err(&pdev->dev, "can_rx_offload_add_timestamp() failed\n");
-		goto probe_exit_clk;
+		goto probe_exit_disable_clk;
 	}
 
 	err = register_candev(ndev);
@@ -977,7 +977,9 @@ static int ti_hecc_probe(struct platform_device *pdev)
 
 probe_exit_offload:
 	can_rx_offload_del(&priv->offload);
-probe_exit_clk:
+probe_exit_disable_clk:
+	clk_disable_unprepare(priv->clk);
+probe_exit_release_clk:
 	clk_put(priv->clk);
 probe_exit_candev:
 	free_candev(ndev);
-- 
1.8.3.1
