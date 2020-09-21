Return-Path: <SRS0=XQ7n=C6=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ECEC43468
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593922084C
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbgIUNix (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgIUNiu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Sep 2020 09:38:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA414C0613CF
        for <linux-can@vger.kernel.org>; Mon, 21 Sep 2020 06:38:49 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKM1n-0000ox-Og; Mon, 21 Sep 2020 15:38:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Colin Ian King <colin.king@canonical.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/38] can: grcan: fix spelling mistake "buss" -> "bus"
Date:   Mon, 21 Sep 2020 15:38:08 +0200
Message-Id: <20200921133845.2249271-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921133845.2249271-1-mkl@pengutronix.de>
References: <20200921133845.2249271-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a netdev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20200806105616.46790-1-colin.king@canonical.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/grcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 378200b682fa..5d1f15843181 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -726,7 +726,7 @@ static void grcan_err(struct net_device *dev, u32 sources, u32 status)
 			txrx = "on rx ";
 			stats->rx_errors++;
 		}
-		netdev_err(dev, "Fatal AHB buss error %s- halting device\n",
+		netdev_err(dev, "Fatal AHB bus error %s- halting device\n",
 			   txrx);
 
 		spin_lock_irqsave(&priv->lock, flags);
-- 
2.28.0

