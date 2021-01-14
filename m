Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765D7C433DB
	for <linux-can@archiver.kernel.org>; Thu, 14 Jan 2021 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374622343F
	for <linux-can@archiver.kernel.org>; Thu, 14 Jan 2021 07:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbhANH6C (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbhANH6B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jan 2021 02:58:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD216C0617BC
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 23:56:35 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kzxUg-0007PQ-Ft
        for linux-can@vger.kernel.org; Thu, 14 Jan 2021 08:56:34 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2F1AA5C3663
        for <linux-can@vger.kernel.org>; Thu, 14 Jan 2021 07:56:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 105635C360B;
        Thu, 14 Jan 2021 07:56:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 60628871;
        Thu, 14 Jan 2021 07:56:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [net-next 09/17] can: length: can_fd_len2dlc(): simplify length calculcation
Date:   Thu, 14 Jan 2021 08:56:09 +0100
Message-Id: <20210114075617.1402597-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114075617.1402597-1-mkl@pengutronix.de>
References: <20210114075617.1402597-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If the length paramter in len2dlc() exceeds the size of the len2dlc array, we
return 0xF. This is equal to the last 16 members of the array.

This patch removes these members from the array, uses ARRAY_SIZE() for the
length check, and returns CANFD_MAX_DLC (which is 0xf).

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20210111141930.693847-9-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/length.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
index 5e7d481717ea..64673a8d1234 100644
--- a/drivers/net/can/dev/length.c
+++ b/drivers/net/can/dev/length.c
@@ -27,15 +27,13 @@ static const u8 len2dlc[] = {
 	13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
 	14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
 	14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
-	15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
-	15, 15, 15, 15, 15, 15, 15, 15	/* 57 - 64 */
 };
 
 /* map the sanitized data length to an appropriate data length code */
 u8 can_fd_len2dlc(u8 len)
 {
-	if (unlikely(len > 64))
-		return 0xF;
+	if (len >= ARRAY_SIZE(len2dlc))
+		return CANFD_MAX_DLC;
 
 	return len2dlc[len];
 }
-- 
2.29.2


