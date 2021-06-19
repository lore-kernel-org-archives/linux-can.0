Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F5C2B9F4
	for <linux-can@archiver.kernel.org>; Sat, 19 Jun 2021 09:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9979361168
	for <linux-can@archiver.kernel.org>; Sat, 19 Jun 2021 09:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhFSKB4 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 19 Jun 2021 06:01:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5403 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhFSKB4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Jun 2021 06:01:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G6WQl4qCvz71T4;
        Sat, 19 Jun 2021 17:56:31 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 19 Jun 2021 17:59:43 +0800
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
Subject: [PATCH net-next 0/8] net: at91_can: clean up some code style issues
Date:   Sat, 19 Jun 2021 17:56:21 +0800
Message-ID: <1624096589-13452-1-git-send-email-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi759-chm.china.huawei.com (10.1.198.145)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patchset clean up some code style issues.

Peng Li (8):
  net: at91_can: remove redundant blank lines
  net: at91_can: add blank line after declarations
  net: at91_can: fix the code style issue about macro
  net: at91_can: use BIT macro
  net: at91_can: fix the alignment issue
  net: at91_can: add braces {} to all arms of the statement
  net: at91_can: remove redundant space
  net: at91_can: fix the comments style issue

 drivers/net/can/at91_can.c | 131 +++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 71 deletions(-)

-- 
2.8.1

