Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B00C54EE9
	for <linux-can@archiver.kernel.org>; Wed,  7 Sep 2022 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIGKix (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 7 Sep 2022 06:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIGKiv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2022 06:38:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6168576475
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 03:38:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVsSG-0001Ir-Sa
        for linux-can@vger.kernel.org; Wed, 07 Sep 2022 12:38:48 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 23EDEDC66A
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 10:38:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5260ADC65F;
        Wed,  7 Sep 2022 10:38:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 344dac5c;
        Wed, 7 Sep 2022 10:38:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/5] can: dev: register_candev(): ensure that bittiming const are valid
Date:   Wed,  7 Sep 2022 12:38:41 +0200
Message-Id: <20220907103845.3929288-2-mkl@pengutronix.de>
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

Implement a function can_bittiming_const_valid() to check the validity
of the provided bit timing constant. Call this function from
register_candev() to check the bit timing constants during CAN
interface registration.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index c1956b1e9faf..3b51055be40e 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -498,6 +498,18 @@ static int can_get_termination(struct net_device *ndev)
 	return 0;
 }
 
+static bool
+can_bittiming_const_valid(const struct can_bittiming_const *btc)
+{
+	if (!btc)
+		return true;
+
+	if (!btc->sjw_max)
+		return false;
+
+	return true;
+}
+
 /* Register the CAN network device */
 int register_candev(struct net_device *dev)
 {
@@ -518,6 +530,10 @@ int register_candev(struct net_device *dev)
 	if (!priv->data_bitrate_const != !priv->data_bitrate_const_cnt)
 		return -EINVAL;
 
+	if (!can_bittiming_const_valid(priv->bittiming_const) ||
+	    !can_bittiming_const_valid(priv->data_bittiming_const))
+		return -EINVAL;
+
 	if (!priv->termination_const) {
 		err = can_get_termination(dev);
 		if (err)
-- 
2.35.1


