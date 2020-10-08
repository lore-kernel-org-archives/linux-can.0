Return-Path: <SRS0=rMTL=DP=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE044C433DF
	for <linux-can@archiver.kernel.org>; Thu,  8 Oct 2020 21:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C5E22242
	for <linux-can@archiver.kernel.org>; Thu,  8 Oct 2020 21:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgJHVkf (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 8 Oct 2020 17:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbgJHVke (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Oct 2020 17:40:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E08FC0613D3
        for <linux-can@vger.kernel.org>; Thu,  8 Oct 2020 14:40:34 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kQdeH-0001aU-In; Thu, 08 Oct 2020 23:40:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] net: j1939: j1939_session_fresh_new(): fix missing initialization of skbcnt
Date:   Thu,  8 Oct 2020 23:40:22 +0200
Message-Id: <20201008214022.2044402-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008214022.2044402-1-mkl@pengutronix.de>
References: <20201008214022.2044402-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch add the initialization of skbcnt, similar to:

    e009f95b1543 can: j1935: j1939_tp_tx_dat_new(): fix missing initialization of skbcnt

Let's play save and initialize this skbcnt as well.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 88cf1062e1e9..e09d087ba240 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1488,6 +1488,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
-- 
2.28.0

