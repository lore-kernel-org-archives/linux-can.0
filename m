Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976EAC43214
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 14:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A0F6008E
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 14:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhGZNdR (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhGZNcz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 09:32:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02946C0617BA
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 07:12:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m81LJ-0001tp-AA
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 16:12:29 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EEAF5658256
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 14:12:10 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 31A4A6581C7;
        Mon, 26 Jul 2021 14:11:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3a94529d;
        Mon, 26 Jul 2021 14:11:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Peng Li <lipeng321@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 25/46] net: at91_can: fix the code style issue about macro
Date:   Mon, 26 Jul 2021 16:11:23 +0200
Message-Id: <20210726141144.862529-26-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726141144.862529-1-mkl@pengutronix.de>
References: <20210726141144.862529-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

Macros with complex values should be enclosed in parentheses

Link: https://lore.kernel.org/r/1624096589-13452-4-git-send-email-huangguangbin2@huawei.com
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 3d3dc08f133a..20c67b8490d3 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -43,14 +43,14 @@ enum at91_reg {
 };
 
 /* Mailbox registers (0 <= i <= 15) */
-#define AT91_MMR(i)		(enum at91_reg)(0x200 + ((i) * 0x20))
-#define AT91_MAM(i)		(enum at91_reg)(0x204 + ((i) * 0x20))
-#define AT91_MID(i)		(enum at91_reg)(0x208 + ((i) * 0x20))
-#define AT91_MFID(i)		(enum at91_reg)(0x20C + ((i) * 0x20))
-#define AT91_MSR(i)		(enum at91_reg)(0x210 + ((i) * 0x20))
-#define AT91_MDL(i)		(enum at91_reg)(0x214 + ((i) * 0x20))
-#define AT91_MDH(i)		(enum at91_reg)(0x218 + ((i) * 0x20))
-#define AT91_MCR(i)		(enum at91_reg)(0x21C + ((i) * 0x20))
+#define AT91_MMR(i)		((enum at91_reg)(0x200 + ((i) * 0x20)))
+#define AT91_MAM(i)		((enum at91_reg)(0x204 + ((i) * 0x20)))
+#define AT91_MID(i)		((enum at91_reg)(0x208 + ((i) * 0x20)))
+#define AT91_MFID(i)		((enum at91_reg)(0x20C + ((i) * 0x20)))
+#define AT91_MSR(i)		((enum at91_reg)(0x210 + ((i) * 0x20)))
+#define AT91_MDL(i)		((enum at91_reg)(0x214 + ((i) * 0x20)))
+#define AT91_MDH(i)		((enum at91_reg)(0x218 + ((i) * 0x20)))
+#define AT91_MCR(i)		((enum at91_reg)(0x21C + ((i) * 0x20)))
 
 /* Register bits */
 #define AT91_MR_CANEN		BIT(0)
-- 
2.30.2


