Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1F3C2B9F4
	for <linux-can@archiver.kernel.org>; Mon, 28 Jun 2021 15:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BAA6144F
	for <linux-can@archiver.kernel.org>; Mon, 28 Jun 2021 15:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhF1PQv (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:16:51 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:57751 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhF1PPL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:15:11 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id NfCP250070zjR6y03fCjiu; Mon, 28 Jun 2021 17:12:44 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:12:44 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 1/4] can: netlink: allow user to turn off unsupported features
Date:   Tue, 29 Jun 2021 00:06:04 +0900
Message-Id: <20210628150607.1128574-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628150607.1128574-1-mailhol.vincent@wanadoo.fr>
References: <20210628150607.1128574-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The sanity checks on the control modes will reject any request related
to an unsupported features, even turning it off.

Example on an interface which do not support CAN-FD:

$ ip link set can0 type can bitrate 500000 fd off
RTNETLINK answers: Operation not supported

This patch lets such command go through (but requests to turn on an
unsupported feature are still denied).

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 147c23d7dab7..80425636049d 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -116,7 +116,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		maskedflags = cm->flags & cm->mask;
 
 		/* check whether provided bits are allowed to be passed */
-		if (cm->mask & ~(priv->ctrlmode_supported | ctrlstatic))
+		if (maskedflags & ~(priv->ctrlmode_supported | ctrlstatic))
 			return -EOPNOTSUPP;
 
 		/* do not check for static fd-non-iso if 'fd' is disabled */
-- 
2.31.1

