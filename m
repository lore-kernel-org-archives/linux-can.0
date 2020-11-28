Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25137C64E90
	for <linux-can@archiver.kernel.org>; Sat, 28 Nov 2020 22:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E968A22263
	for <linux-can@archiver.kernel.org>; Sat, 28 Nov 2020 22:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgK1Vt7 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8882 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgK1SZG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 28 Nov 2020 13:25:06 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CjsvG41slz6vRv;
        Sat, 28 Nov 2020 21:35:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 28 Nov 2020
 21:35:58 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
Subject: [PATCH 0/2] can: Fix the error handling in c_can_power_up and kvaser_pciefd_open
Date:   Sat, 28 Nov 2020 21:39:20 +0800
Message-ID: <20201128133922.3276973-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The patch series fix the error handling to avoid the reference
leak and wrong state for the net device.

Zhang Qilong (2):
  can: c_can: Fix error handling in c_can_power_up
  can: kvaser_pciefd: Fix error handling in kvaser_pciefd_open

 drivers/net/can/c_can/c_can.c   | 18 ++++++++++++++----
 drivers/net/can/kvaser_pciefd.c |  4 +++-
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.25.4

