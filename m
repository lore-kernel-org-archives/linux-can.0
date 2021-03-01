Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB4BC433DB
	for <linux-can@archiver.kernel.org>; Mon,  1 Mar 2021 11:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D356564DE0
	for <linux-can@archiver.kernel.org>; Mon,  1 Mar 2021 11:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhCALXF (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 1 Mar 2021 06:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhCALWk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Mar 2021 06:22:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB0C061793
        for <linux-can@vger.kernel.org>; Mon,  1 Mar 2021 03:21:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lGgbu-0002zL-Qp
        for linux-can@vger.kernel.org; Mon, 01 Mar 2021 12:21:10 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1B21E5EB11F
        for <linux-can@vger.kernel.org>; Mon,  1 Mar 2021 11:21:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CE7065EB0FA;
        Mon,  1 Mar 2021 11:21:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e897b9e2;
        Mon, 1 Mar 2021 11:21:02 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 3/6] can: flexcan: invoke flexcan_chip_freeze() to enter freeze mode
Date:   Mon,  1 Mar 2021 12:20:57 +0100
Message-Id: <20210301112100.197939-4-mkl@pengutronix.de>
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

From: Joakim Zhang <qiangqing.zhang@nxp.com>

Invoke flexcan_chip_freeze() to enter freeze mode, since need poll
freeze mode acknowledge.

Fixes: e955cead03117 ("CAN: Add Flexcan CAN controller driver")
Link: https://lore.kernel.org/r/20210218110037.16591-4-qiangqing.zhang@nxp.com
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e66a51dbea0a..134c05757a3b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1480,10 +1480,13 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	flexcan_set_bittiming(dev);
 
+	/* set freeze, halt */
+	err = flexcan_chip_freeze(priv);
+	if (err)
+		goto out_chip_disable;
+
 	/* MCR
 	 *
-	 * enable freeze
-	 * halt now
 	 * only supervisor access
 	 * enable warning int
 	 * enable individual RX masking
@@ -1492,9 +1495,8 @@ static int flexcan_chip_start(struct net_device *dev)
 	 */
 	reg_mcr = priv->read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
-	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
-		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_IRMQ | FLEXCAN_MCR_IDAM_C |
-		FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+	reg_mcr |= FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_IRMQ |
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 
 	/* MCR
 	 *
-- 
2.30.1


