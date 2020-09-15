Return-Path: <SRS0=ffhE=CY=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDD7C43461
	for <linux-can@archiver.kernel.org>; Tue, 15 Sep 2020 22:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FE0206BE
	for <linux-can@archiver.kernel.org>; Tue, 15 Sep 2020 22:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgIOWhF (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgIOWfi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41DEC061355
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:33 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJXv-0002Tb-Tt; Wed, 16 Sep 2020 00:35:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 10/37] can: dev: can_put_echo_skb(): print number of echo_skb that is occupied
Date:   Wed, 16 Sep 2020 00:35:00 +0200
Message-Id: <20200915223527.1417033-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch prints the number of the occupied echo_skb, to ease
implementing and debugging of new drivers.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 68834a2853c9..dd443e5d8cb7 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -463,7 +463,7 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		priv->echo_skb[idx] = skb;
 	} else {
 		/* locking problem with netif_stop_queue() ?? */
-		netdev_err(dev, "%s: BUG! echo_skb is occupied!\n", __func__);
+		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
 		kfree_skb(skb);
 	}
 }
-- 
2.28.0

