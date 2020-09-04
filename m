Return-Path: <SRS0=n72h=CN=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AD3C433E2
	for <linux-can@archiver.kernel.org>; Fri,  4 Sep 2020 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C18206F2
	for <linux-can@archiver.kernel.org>; Fri,  4 Sep 2020 13:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgIDNNV (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:13:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728588AbgIDNNP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 4 Sep 2020 09:13:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B0FFDF05AD95A8EF610F;
        Fri,  4 Sep 2020 21:13:03 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Sep 2020
 21:12:58 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] can: kvaser_pciefd: Remove unused macro KVASER_PCIEFD_KCAN_CTRL_EFRAME
Date:   Fri, 4 Sep 2020 21:10:26 +0800
Message-ID: <20200904131026.21817-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

KVASER_PCIEFD_KCAN_CTRL_EFRAME is never used after it was introduced.
So better to remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/can/kvaser_pciefd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 6f766918211a..c0b18ff107c7 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -131,7 +131,6 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 
 /* Kvaser KCAN definitions */
 #define KVASER_PCIEFD_KCAN_CTRL_EFLUSH (4 << 29)
-#define KVASER_PCIEFD_KCAN_CTRL_EFRAME (5 << 29)
 
 #define KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT 16
 /* Request status packet */
-- 
2.17.1

