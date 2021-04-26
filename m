Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C991C433B4
	for <linux-can@archiver.kernel.org>; Mon, 26 Apr 2021 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8CA61249
	for <linux-can@archiver.kernel.org>; Mon, 26 Apr 2021 10:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhDZKKB (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 26 Apr 2021 06:10:01 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:42910 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232173AbhDZKJ7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Apr 2021 06:09:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UWoKdug_1619431698;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UWoKdug_1619431698)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Apr 2021 18:09:16 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     wg@grandegger.com
Cc:     mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] can: softing: Remove redundant variable ptr
Date:   Mon, 26 Apr 2021 18:08:16 +0800
Message-Id: <1619431696-81853-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Variable ptr is being assigned a value from a calculation
however the variable is never read, so this redundant variable
can be removed.

Cleans up the following clang-analyzer warning:

drivers/net/can/softing/softing_main.c:279:3: warning: Value stored to
'ptr' is never read [clang-analyzer-deadcode.DeadStores].

drivers/net/can/softing/softing_main.c:242:3: warning: Value stored to
'ptr' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/can/softing/softing_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index c44f341..cfc1325 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -239,7 +239,6 @@ static int softing_handle_1(struct softing *card)
 				DPRAM_INFO_BUSSTATE2 : DPRAM_INFO_BUSSTATE]);
 		/* timestamp */
 		tmp_u32 = le32_to_cpup((void *)ptr);
-		ptr += 4;
 		ktime = softing_raw2ktime(card, tmp_u32);
 
 		++netdev->stats.rx_errors;
@@ -276,7 +275,6 @@ static int softing_handle_1(struct softing *card)
 		ktime = softing_raw2ktime(card, tmp_u32);
 		if (!(msg.can_id & CAN_RTR_FLAG))
 			memcpy(&msg.data[0], ptr, 8);
-		ptr += 8;
 		/* update socket */
 		if (cmd & CMD_ACK) {
 			/* acknowledge, was tx msg */
-- 
1.8.3.1

