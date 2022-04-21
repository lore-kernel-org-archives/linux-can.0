Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35163C433F5
	for <linux-can@archiver.kernel.org>; Thu, 21 Apr 2022 20:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356446AbiDUUfo (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiDUUfn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Apr 2022 16:35:43 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A384C4AE16;
        Thu, 21 Apr 2022 13:32:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VAhaFaY_1650573164;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VAhaFaY_1650573164)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 04:32:49 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     pisa@cmp.felk.cvut.cz
Cc:     ondrej.ille@gmail.com, wg@grandegger.com, mkl@pengutronix.de,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] can: ctucanfd: Remove unnecessary print function dev_err()
Date:   Fri, 22 Apr 2022 04:32:42 +0800
Message-Id: <20220421203242.7335-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Eliminate the follow coccicheck warnings:

./drivers/net/can/ctucanfd/ctucanfd_platform.c:67:2-9: line 67 is
redundant because platform_get_irq() already prints an error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/can/ctucanfd/ctucanfd_platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_platform.c b/drivers/net/can/ctucanfd/ctucanfd_platform.c
index 5e4806068662..89d54c2151e1 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_platform.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_platform.c
@@ -64,7 +64,6 @@ static int ctucan_platform_probe(struct platform_device *pdev)
 	}
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "Cannot find interrupt.\n");
 		ret = irq;
 		goto err;
 	}
-- 
2.20.1.7.g153144c

