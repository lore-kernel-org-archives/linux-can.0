Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D2FC4320E
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 14:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D68960560
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 14:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhGZNdY (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbhGZNdP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 09:33:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A34C061382
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 07:12:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m81LR-00028h-Pz
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 16:12:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7779C658298
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 14:12:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 43F3E6581F9;
        Mon, 26 Jul 2021 14:12:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 40c87189;
        Mon, 26 Jul 2021 14:11:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH net-next 32/46] can: peak_pci: fix checkpatch warnings
Date:   Mon, 26 Jul 2021 16:11:30 +0200
Message-Id: <20210726141144.862529-33-mkl@pengutronix.de>
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

This patch cleans several checkpatch warnings in the peak_pci driver.

Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Link: https://lore.kernel.org/r/20210616102811.2449426-0-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/peak_pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 5fec26c6df42..aff8a1dee135 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -152,12 +152,14 @@ static void peak_pci_write_reg(const struct sja1000_priv *priv,
 static inline void pita_set_scl_highz(struct peak_pciec_card *card)
 {
 	u8 gp_outen = readb(card->cfg_base + PITA_GPOEN) & ~PITA_GPIN_SCL;
+
 	writeb(gp_outen, card->cfg_base + PITA_GPOEN);
 }
 
 static inline void pita_set_sda_highz(struct peak_pciec_card *card)
 {
 	u8 gp_outen = readb(card->cfg_base + PITA_GPOEN) & ~PITA_GPIN_SDA;
+
 	writeb(gp_outen, card->cfg_base + PITA_GPOEN);
 }
 
@@ -242,7 +244,7 @@ static int peak_pciec_write_pca9553(struct peak_pciec_card *card,
 	int ret;
 
 	/* cache led mask */
-	if ((offset == 5) && (data == card->led_cache))
+	if (offset == 5 && data == card->led_cache)
 		return 0;
 
 	ret = i2c_transfer(&card->led_chip, &msg, 1);
@@ -424,7 +426,7 @@ static int peak_pciec_probe(struct pci_dev *pdev, struct net_device *dev)
 	/* channel is the first one: do the init part */
 	} else {
 		/* create the bit banging I2C adapter structure */
-		card = kzalloc(sizeof(struct peak_pciec_card), GFP_KERNEL);
+		card = kzalloc(sizeof(*card), GFP_KERNEL);
 		if (!card)
 			return -ENOMEM;
 
-- 
2.30.2


