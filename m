Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F55C433E6
	for <linux-can@archiver.kernel.org>; Wed, 27 Jan 2021 09:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B55C20759
	for <linux-can@archiver.kernel.org>; Wed, 27 Jan 2021 09:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhA0JoT (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 27 Jan 2021 04:44:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbhA0Jld (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jan 2021 04:41:33 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l4hJR-0002IA-I6
        for linux-can@vger.kernel.org; Wed, 27 Jan 2021 10:40:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1E8C85CF839
        for <linux-can@vger.kernel.org>; Wed, 27 Jan 2021 09:40:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 02FFB5CF82C;
        Wed, 27 Jan 2021 09:40:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id afc944fc;
        Wed, 27 Jan 2021 09:40:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Dan Carpenter <dan.carpenter@oracle.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net] can: dev: prevent potential information leak in can_fill_info()
Date:   Wed, 27 Jan 2021 10:40:28 +0100
Message-Id: <20210127094028.2778793-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127094028.2778793-1-mkl@pengutronix.de>
References: <20210127094028.2778793-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The "bec" struct isn't necessarily always initialized. For example, the
mcp251xfd_get_berr_counter() function doesn't initialize anything if the
interface is down.

Fixes: 52c793f24054 ("can: netlink support for bus-error reporting and counters")
Link: https://lore.kernel.org/r/YAkaRdRJncsJO8Ve@mwanda
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 8b1ae023cb21..c73e2a65c904 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1163,7 +1163,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	struct can_ctrlmode cm = {.flags = priv->ctrlmode};
-	struct can_berr_counter bec;
+	struct can_berr_counter bec = { };
 	enum can_state state = priv->state;
 
 	if (priv->do_get_state)

base-commit: b491e6a7391e3ecdebdd7a097550195cc878924a
-- 
2.29.2


