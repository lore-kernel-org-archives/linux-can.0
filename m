Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D899C6FA89
	for <linux-can@archiver.kernel.org>; Wed,  7 Sep 2022 10:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiIGKi4 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 7 Sep 2022 06:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIGKiw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2022 06:38:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D13B7757F
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 03:38:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVsSH-0001JB-GY
        for linux-can@vger.kernel.org; Wed, 07 Sep 2022 12:38:49 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 97400DC671
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 10:38:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C56D6DC664;
        Wed,  7 Sep 2022 10:38:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 48cc466b;
        Wed, 7 Sep 2022 10:38:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/5] can: bittiming: can_calc_bittiming(): clean up SJW sanitizing
Date:   Wed,  7 Sep 2022 12:38:43 +0200
Message-Id: <20220907103845.3929288-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907103845.3929288-1-mkl@pengutronix.de>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Prepare the SJW handling in can_calc_bittiming() for the changes
coming in the next patches. Always ensure that SJW in within the
limits.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index ce6bef2444a2..cb9521c8ae8e 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -154,13 +154,12 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	bt->phase_seg1 = tseg1 - bt->prop_seg;
 	bt->phase_seg2 = tseg2;
 
-	/* check for sjw user settings */
-	if (!bt->sjw || !btc->sjw_max) {
+	/* If user space provides no sjw, use 1 as default */
+	if (!bt->sjw)
 		bt->sjw = 1;
-	} else {
-		/* sjw must not be higher than sjw_max and tseg2 */
-		bt->sjw = min3(bt->sjw, btc->sjw_max, tseg2);
-	}
+
+	/* sjw must not be higher than sjw_max and tseg2 */
+	bt->sjw = min3(bt->sjw, btc->sjw_max, tseg2);
 
 	bt->brp = best_brp;
 
-- 
2.35.1


