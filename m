Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E544C433E0
	for <linux-can@archiver.kernel.org>; Wed, 17 Mar 2021 08:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1528164E27
	for <linux-can@archiver.kernel.org>; Wed, 17 Mar 2021 08:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCQIw4 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 17 Mar 2021 04:52:56 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:22205 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCQIwl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Mar 2021 04:52:41 -0400
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d41 with ME
        id hLsV240033PnFJp03Lsbw6; Wed, 17 Mar 2021 09:52:38 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 17 Mar 2021 09:52:38 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: dev: do not increment rx stats when generating a CAN error skb
Date:   Wed, 17 Mar 2021 17:52:23 +0900
Message-Id: <20210317085223.91282-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

CAN error skb is an interface specific to socket CAN. The CAN error
skb does not correspond to any actual CAN frame sent on the wire. Only
an error flag is transmitted when an error occurs (c.f. ISO 11898-1
section 10.4.4.2 "Error flag").

For this reason, it makes no sense to increment the rx_packets and
rx_bytes fields of struct net_device_stats.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/dev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index d9281ae853f8..6855cbe3cae7 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -135,7 +135,6 @@ EXPORT_SYMBOL_GPL(can_change_state);
 static void can_restart(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	int err;
@@ -154,9 +153,6 @@ static void can_restart(struct net_device *dev)
 
 	cf->can_id |= CAN_ERR_RESTARTED;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	netif_rx_ni(skb);
 
 restart:
-- 
2.26.2

