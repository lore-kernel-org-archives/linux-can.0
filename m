Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0908EEB64DC
	for <linux-can@archiver.kernel.org>; Tue, 18 Jul 2023 16:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjGRQhZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 18 Jul 2023 12:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGRQhY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 12:37:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092D910C
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 09:37:24 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLnhS-0006vK-GO
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 18:37:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E16931F4432
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 16:37:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F40361F442E;
        Tue, 18 Jul 2023 16:37:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 66476c5a;
        Tue, 18 Jul 2023 16:37:19 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Mao Zhu <zhumao001@208suo.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: ucan: Remove repeated word
Date:   Tue, 18 Jul 2023 18:37:18 +0200
Message-Id: <20230718163718.461137-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Mao Zhu <zhumao001@208suo.com>

Delete one of repeated word 'information' in comment.

Signed-off-by: Mao Zhu <zhumao001@208suo.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

taking Mao Zhu's multipart HTML mail, apply by hand and resend it as
v2 via git send-email.

regards,
Marc

 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index a0f7bcec719c..39a63b7313a4 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -284,7 +284,7 @@ struct ucan_priv {
 	 */
 	spinlock_t echo_skb_lock;
 
-	/* usb device information information */
+	/* usb device information */
 	u8 intf_index;
 	u8 in_ep_addr;
 	u8 out_ep_addr;
-- 
2.40.1


