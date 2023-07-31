Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B1C001DE
	for <linux-can@archiver.kernel.org>; Mon, 31 Jul 2023 07:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGaHxd (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 31 Jul 2023 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGaHxd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jul 2023 03:53:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA89D130;
        Mon, 31 Jul 2023 00:53:31 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDr7K5n1YzrRtl;
        Mon, 31 Jul 2023 15:52:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 15:53:29 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <haibo.chen@nxp.com>, <u.kleine-koenig@pengutronix.de>,
        <socketcan@hartkopp.net>, <yangyingliang@huawei.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] can: flexcan: fix the return value handle for platform_get_irq()
Date:   Mon, 31 Jul 2023 15:52:52 +0800
Message-ID: <20230731075252.359965-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

There is no possible for platform_get_irq() to return 0
and the return value of platform_get_irq() is more sensible
to show the error reason.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ff0fc18baf13..52745cfef975 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2089,8 +2089,8 @@ static int flexcan_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -2167,13 +2167,13 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
-		if (priv->irq_boff <= 0) {
-			err = -ENODEV;
+		if (priv->irq_boff < 0) {
+			err = priv->irq_boff;
 			goto failed_platform_get_irq;
 		}
 		priv->irq_err = platform_get_irq(pdev, 2);
-		if (priv->irq_err <= 0) {
-			err = -ENODEV;
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
 			goto failed_platform_get_irq;
 		}
 	}
-- 
2.34.1

