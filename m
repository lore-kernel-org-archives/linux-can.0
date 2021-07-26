Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A191C432BE
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6112260560
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 14:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhGZNdV (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbhGZNdO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 09:33:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44295C0611BB
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 07:12:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m81LO-000241-Ec
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 16:12:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 79A13658279
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 14:12:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5CBEC6581E0;
        Mon, 26 Jul 2021 14:11:59 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9862abe9;
        Mon, 26 Jul 2021 14:11:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Peng Li <lipeng321@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 28/46] net: at91_can: add braces {} to all arms of the statement
Date:   Mon, 26 Jul 2021 16:11:26 +0200
Message-Id: <20210726141144.862529-29-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726141144.862529-1-mkl@pengutronix.de>
References: <20210726141144.862529-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

Braces {} should be used on all arms of this statement.

Link: https://lore.kernel.org/r/1624096589-13452-7-git-send-email-huangguangbin2@huawei.com
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 8fab80887117..87c2555933e4 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -585,9 +585,9 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
 	reg_msr = at91_read(priv, AT91_MSR(mb));
 	cf->len = can_cc_dlc2len((reg_msr >> 16) & 0xf);
 
-	if (reg_msr & AT91_MSR_MRTR)
+	if (reg_msr & AT91_MSR_MRTR) {
 		cf->can_id |= CAN_RTR_FLAG;
-	else {
+	} else {
 		*(u32 *)(cf->data + 0) = at91_read(priv, AT91_MDL(mb));
 		*(u32 *)(cf->data + 4) = at91_read(priv, AT91_MDH(mb));
 	}
@@ -1020,15 +1020,15 @@ static void at91_irq_err(struct net_device *dev)
 		reg_sr = at91_read(priv, AT91_SR);
 
 		/* we need to look at the unmasked reg_sr */
-		if (unlikely(reg_sr & AT91_IRQ_BOFF))
+		if (unlikely(reg_sr & AT91_IRQ_BOFF)) {
 			new_state = CAN_STATE_BUS_OFF;
-		else if (unlikely(reg_sr & AT91_IRQ_ERRP))
+		} else if (unlikely(reg_sr & AT91_IRQ_ERRP)) {
 			new_state = CAN_STATE_ERROR_PASSIVE;
-		else if (unlikely(reg_sr & AT91_IRQ_WARN))
+		} else if (unlikely(reg_sr & AT91_IRQ_WARN)) {
 			new_state = CAN_STATE_ERROR_WARNING;
-		else if (likely(reg_sr & AT91_IRQ_ERRA))
+		} else if (likely(reg_sr & AT91_IRQ_ERRA)) {
 			new_state = CAN_STATE_ERROR_ACTIVE;
-		else {
+		} else {
 			netdev_err(dev, "BUG! hardware in undefined state\n");
 			return;
 		}
-- 
2.30.2


