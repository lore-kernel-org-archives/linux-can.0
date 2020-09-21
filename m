Return-Path: <SRS0=XQ7n=C6=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B439BC43465
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EF02075E
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgIUNqN (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgIUNqG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Sep 2020 09:46:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08AFC0613D1
        for <linux-can@vger.kernel.org>; Mon, 21 Sep 2020 06:46:05 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKM8o-0003ED-Fr; Mon, 21 Sep 2020 15:46:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/38] can: flexcan: fix spelling mistake "reserverd" -> "reserved"
Date:   Mon, 21 Sep 2020 15:45:21 +0200
Message-Id: <20200921134557.2251383-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921134557.2251383-1-mkl@pengutronix.de>
References: <20200921134557.2251383-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Fix a mistake in a register layout description.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20200214141751.21168-1-alexandre.belloni@bootlin.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 94d10ec954a0..19403e88daa3 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -230,7 +230,7 @@ struct flexcan_regs {
 	/* FIFO-mode:
 	 *			MB
 	 * 0x080...0x08f	0	RX message buffer
-	 * 0x090...0x0df	1-5	reserverd
+	 * 0x090...0x0df	1-5	reserved
 	 * 0x0e0...0x0ff	6-7	8 entry ID table
 	 *				(mx25, mx28, mx35, mx53)
 	 * 0x0e0...0x2df	6-7..37	8..128 entry ID table
-- 
2.28.0

