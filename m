From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] can: flexcan: improve error message
Date: Wed, 28 Dec 2016 14:12:41 -0200
Message-ID: <1482941561-28094-1-git-send-email-festevam@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34541 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbcL1QMk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Dec 2016 11:12:40 -0500
Received: by mail-qt0-f194.google.com with SMTP id p16so24429162qta.1
        for <linux-can@vger.kernel.org>; Wed, 28 Dec 2016 08:12:39 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

When register_flexcandev() fails it is better to mention 'flexcandev'
in the error message for better clarity.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 16f7cad..f1da809 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1234,7 +1234,7 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	err = register_flexcandev(dev);
 	if (err) {
-		dev_err(&pdev->dev, "registering netdev failed\n");
+		dev_err(&pdev->dev, "registering flexcandev failed\n");
 		goto failed_register;
 	}
 
-- 
2.7.4

