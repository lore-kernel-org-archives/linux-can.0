Return-Path: <SRS0=XQ7n=C6=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB0C47420
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC33D2084C
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgIUNjI (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgIUNiy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Sep 2020 09:38:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5239EC061755
        for <linux-can@vger.kernel.org>; Mon, 21 Sep 2020 06:38:54 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKM1s-0000ox-G9; Mon, 21 Sep 2020 15:38:52 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 16/38] can: mscan: mark expected switch fall-through
Date:   Mon, 21 Sep 2020 15:38:23 +0200
Message-Id: <20200921133845.2249271-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921133845.2249271-1-mkl@pengutronix.de>
References: <20200921133845.2249271-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

As -Wimplicit-fallthrough is now enabled the mscan driver shows this warning,
which is fixed by this patch:

drivers/net/can/mscan/mscan.c: In function ‘mscan_start_xmit’:
drivers/net/can/mscan/mscan.c:211:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
  211 |   netif_stop_queue(dev);
      |   ^~~~~~~~~~~~~~~~~~~~~
drivers/net/can/mscan/mscan.c:212:2: note: here
  212 |  case 2:
      |  ^~~~

Link: https://lore.kernel.org/r/20200915223527.1417033-17-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 99101d7027a8..0b3532dd50e2 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -209,6 +209,7 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		 * since buffer with lower id have higher priority (hell..)
 		 */
 		netif_stop_queue(dev);
+		fallthrough;
 	case 2:
 		if (buf_id < priv->prev_buf_id) {
 			priv->cur_pri++;
-- 
2.28.0

