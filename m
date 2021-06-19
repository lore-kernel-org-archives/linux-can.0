Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E928BC49EA3
	for <linux-can@archiver.kernel.org>; Sat, 19 Jun 2021 09:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CE7611CE
	for <linux-can@archiver.kernel.org>; Sat, 19 Jun 2021 09:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhFSKCB (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 19 Jun 2021 06:02:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5050 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhFSKB5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Jun 2021 06:01:57 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G6WNb4B2TzXh5g;
        Sat, 19 Jun 2021 17:54:39 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 19 Jun 2021 17:59:44 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 19 Jun 2021 17:59:43 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lipeng321@huawei.com>,
        <huangguangbin2@huawei.com>
Subject: [PATCH net-next 2/8] net: at91_can: add blank line after declarations
Date:   Sat, 19 Jun 2021 17:56:23 +0800
Message-ID: <1624096589-13452-3-git-send-email-huangguangbin2@huawei.com>
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

This patch fixes the checkpatch error about missing a blank line
after declarations.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 drivers/net/can/at91_can.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index a2da76796b57..058c18fac167 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -515,6 +515,7 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
 static inline void at91_activate_rx_low(const struct at91_priv *priv)
 {
 	u32 mask = get_mb_rx_low_mask(priv);
+
 	at91_write(priv, AT91_TCR, mask);
 }
 
@@ -529,6 +530,7 @@ static inline void at91_activate_rx_mb(const struct at91_priv *priv,
 		unsigned int mb)
 {
 	u32 mask = 1 << mb;
+
 	at91_write(priv, AT91_TCR, mask);
 }
 
@@ -807,6 +809,7 @@ static int at91_poll(struct napi_struct *napi, int quota)
 	if (work_done < quota) {
 		/* enable IRQs for frame errors and all mailboxes >= rx_next */
 		u32 reg_ier = AT91_IRQ_ERR_FRAME;
+
 		reg_ier |= get_irq_mb_rx(priv) & ~AT91_MB_MASK(priv->rx_next);
 
 		napi_complete_done(napi, work_done);
-- 
2.8.1

