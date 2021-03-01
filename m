Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C30C433E6
	for <linux-can@archiver.kernel.org>; Mon,  1 Mar 2021 11:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85FE64DF1
	for <linux-can@archiver.kernel.org>; Mon,  1 Mar 2021 11:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhCALXc (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 1 Mar 2021 06:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhCALWk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Mar 2021 06:22:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14293C0617A9
        for <linux-can@vger.kernel.org>; Mon,  1 Mar 2021 03:21:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lGgbw-00033z-Mk
        for linux-can@vger.kernel.org; Mon, 01 Mar 2021 12:21:12 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 612EE5EB131
        for <linux-can@vger.kernel.org>; Mon,  1 Mar 2021 11:21:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F2C145EB104;
        Mon,  1 Mar 2021 11:21:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2b74a04b;
        Mon, 1 Mar 2021 11:21:02 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 6/6] can: tcan4x5x: tcan4x5x_init(): fix initialization - clear MRAM before entering Normal Mode
Date:   Mon,  1 Mar 2021 12:21:00 +0100
Message-Id: <20210301112100.197939-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301112100.197939-1-mkl@pengutronix.de>
References: <20210301112100.197939-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Torin Cooper-Bennun <torin@maxiluxsystems.com>

This patch prevents a potentially destructive race condition. The
device is fully operational on the bus after entering Normal Mode, so
zeroing the MRAM after entering this mode may lead to loss of
information, e.g. new received messages.

This patch fixes the problem by first initializing the MRAM, then
bringing the device into Normale Mode.

Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Link: https://lore.kernel.org/r/20210226163440.313628-1-torin@maxiluxsystems.com
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index b7caec769ddb..4147cecfbbd6 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -237,14 +237,14 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
+	/* Zero out the MCAN buffers */
+	m_can_init_ram(cdev);
+
 	ret = regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
 				 TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_NORMAL);
 	if (ret)
 		return ret;
 
-	/* Zero out the MCAN buffers */
-	m_can_init_ram(cdev);
-
 	return ret;
 }
 
-- 
2.30.1


