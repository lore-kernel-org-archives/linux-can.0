Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF2C2B9F4
	for <linux-can@archiver.kernel.org>; Sat, 19 Jun 2021 09:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C94D611CE
	for <linux-can@archiver.kernel.org>; Sat, 19 Jun 2021 09:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhFSKCA (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 19 Jun 2021 06:02:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5052 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhFSKB5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Jun 2021 06:01:57 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G6WNb23x9zXgZd;
        Sat, 19 Jun 2021 17:54:39 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 19 Jun 2021 17:59:44 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 19 Jun 2021 17:59:44 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lipeng321@huawei.com>,
        <huangguangbin2@huawei.com>
Subject: [PATCH net-next 4/8] net: at91_can: use BIT macro
Date:   Sat, 19 Jun 2021 17:56:25 +0800
Message-ID: <1624096589-13452-5-git-send-email-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1624096589-13452-1-git-send-email-huangguangbin2@huawei.com>
References: <1624096589-13452-1-git-send-email-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi759-chm.china.huawei.com (10.1.198.145)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

This patch uses the BIT macro for setting individual bits,
to fix the following checkpatch.pl issue:
CHECK: Prefer using the BIT macro.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 drivers/net/can/at91_can.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 8ea638d04cc7..279878165e5b 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -87,19 +87,19 @@ enum at91_mb_mode {
 };
 
 /* Interrupt mask bits */
-#define AT91_IRQ_ERRA		(1 << 16)
-#define AT91_IRQ_WARN		(1 << 17)
-#define AT91_IRQ_ERRP		(1 << 18)
-#define AT91_IRQ_BOFF		(1 << 19)
-#define AT91_IRQ_SLEEP		(1 << 20)
-#define AT91_IRQ_WAKEUP		(1 << 21)
-#define AT91_IRQ_TOVF		(1 << 22)
-#define AT91_IRQ_TSTP		(1 << 23)
-#define AT91_IRQ_CERR		(1 << 24)
-#define AT91_IRQ_SERR		(1 << 25)
-#define AT91_IRQ_AERR		(1 << 26)
-#define AT91_IRQ_FERR		(1 << 27)
-#define AT91_IRQ_BERR		(1 << 28)
+#define AT91_IRQ_ERRA		BIT(16)
+#define AT91_IRQ_WARN		BIT(17)
+#define AT91_IRQ_ERRP		BIT(18)
+#define AT91_IRQ_BOFF		BIT(19)
+#define AT91_IRQ_SLEEP		BIT(20)
+#define AT91_IRQ_WAKEUP		BIT(21)
+#define AT91_IRQ_TOVF		BIT(22)
+#define AT91_IRQ_TSTP		BIT(23)
+#define AT91_IRQ_CERR		BIT(24)
+#define AT91_IRQ_SERR		BIT(25)
+#define AT91_IRQ_AERR		BIT(26)
+#define AT91_IRQ_FERR		BIT(27)
+#define AT91_IRQ_BERR		BIT(28)
 
 #define AT91_IRQ_ERR_ALL	(0x1fff0000)
 #define AT91_IRQ_ERR_FRAME	(AT91_IRQ_CERR | AT91_IRQ_SERR | \
-- 
2.8.1

