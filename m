Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34BC433F5
	for <linux-can@archiver.kernel.org>; Thu, 21 Apr 2022 20:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245376AbiDUUbz (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389385AbiDUUbw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Apr 2022 16:31:52 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D678E4DF59;
        Thu, 21 Apr 2022 13:29:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VAhY.oD_1650572933;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VAhY.oD_1650572933)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 04:28:58 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     pisa@cmp.felk.cvut.cz
Cc:     ondrej.ille@gmail.com, wg@grandegger.com, mkl@pengutronix.de,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] can: ctucanfd: Remove unused including <linux/version.h>
Date:   Fri, 22 Apr 2022 04:28:52 +0800
Message-Id: <20220421202852.2693-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Eliminate the follow versioncheck warning:

./drivers/net/can/ctucanfd/ctucanfd_base.c: 34 linux/version.h not
needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 7a4550f60abb..be90136be442 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -31,7 +31,6 @@
 #include <linux/can/error.h>
 #include <linux/can/led.h>
 #include <linux/pm_runtime.h>
-#include <linux/version.h>
 
 #include "ctucanfd.h"
 #include "ctucanfd_kregs.h"
-- 
2.20.1.7.g153144c

