Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E1AC433B4
	for <linux-can@archiver.kernel.org>; Wed,  7 Apr 2021 08:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87EB560BD3
	for <linux-can@archiver.kernel.org>; Wed,  7 Apr 2021 08:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbhDGIBp (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbhDGIBl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Apr 2021 04:01:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51EC06175F
        for <linux-can@vger.kernel.org>; Wed,  7 Apr 2021 01:01:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lU37x-0001z5-Cf
        for linux-can@vger.kernel.org; Wed, 07 Apr 2021 10:01:29 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5EF256097F7
        for <linux-can@vger.kernel.org>; Wed,  7 Apr 2021 08:01:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 78A1E6097CD;
        Wed,  7 Apr 2021 08:01:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9e5cd9cc;
        Wed, 7 Apr 2021 08:01:19 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        coverity-bot <keescook+coverity-bot@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [net-next 2/6] can: m_can: m_can_receive_skb(): add missing error handling to can_rx_offload_queue_sorted() call
Date:   Wed,  7 Apr 2021 10:01:14 +0200
Message-Id: <20210407080118.1916040-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407080118.1916040-1-mkl@pengutronix.de>
References: <20210407080118.1916040-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit 1be37d3b0414 ("can: m_can: fix periph RX path: use
rx-offload to ensure skbs are sent from softirq context") the RX path
for peripherals (i.e. SPI based m_can controllers) was converted to
the rx-offload infrastructure. However, the error handling for
can_rx_offload_queue_sorted() was forgotten.
can_rx_offload_queue_sorted() will return with an error if the
internal queue is full.

This patch adds the missing error handling, by increasing the
rx_fifo_errors.

Fixes: 1be37d3b0414 ("can: m_can: fix periph RX path: use rx-offload to ensure skbs are sent from softirq context")
Link: https://lore.kernel.org/r/20210401084515.1455013-1-mkl@pengutronix.de
Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1503583 ("Error handling issues")
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Torin Cooper-Bennun <torin@maxiluxsystems.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 890ed826a355..34073cd077e4 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -466,10 +466,17 @@ static void m_can_receive_skb(struct m_can_classdev *cdev,
 			      struct sk_buff *skb,
 			      u32 timestamp)
 {
-	if (cdev->is_peripheral)
-		can_rx_offload_queue_sorted(&cdev->offload, skb, timestamp);
-	else
+	if (cdev->is_peripheral) {
+		struct net_device_stats *stats = &cdev->net->stats;
+		int err;
+
+		err = can_rx_offload_queue_sorted(&cdev->offload, skb,
+						  timestamp);
+		if (err)
+			stats->rx_fifo_errors++;
+	} else {
 		netif_receive_skb(skb);
+	}
 }
 
 static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
-- 
2.30.2


