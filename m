Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1241C433E0
	for <linux-can@archiver.kernel.org>; Wed, 27 Jan 2021 09:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1DD20770
	for <linux-can@archiver.kernel.org>; Wed, 27 Jan 2021 09:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhA0J3P (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 27 Jan 2021 04:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbhA0JZX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jan 2021 04:25:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CCAC06178A
        for <linux-can@vger.kernel.org>; Wed, 27 Jan 2021 01:22:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l4h2A-0008DI-6O
        for linux-can@vger.kernel.org; Wed, 27 Jan 2021 10:22:42 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8CF5E5CF11D
        for <linux-can@vger.kernel.org>; Wed, 27 Jan 2021 09:22:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B25E15CF0DC;
        Wed, 27 Jan 2021 09:22:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a7d4a738;
        Wed, 27 Jan 2021 09:22:28 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Su Yanjun <suyanjun218@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 06/12] can: mcp251xfd: replace sizeof(u32) with val_bytes in regmap
Date:   Wed, 27 Jan 2021 10:22:21 +0100
Message-Id: <20210127092227.2775573-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127092227.2775573-1-mkl@pengutronix.de>
References: <20210127092227.2775573-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Su Yanjun <suyanjun218@gmail.com>

The sizeof(u32) is hardcoded. It's better to use the config value from the
regmap.

It increases the size of target object, but it's flexible when new mcp chip
need other val_bytes.

Link: https://lore.kernel.org/r/20210122081334.213957-1-suyanjun218@gmail.com
Signed-off-by: Su Yanjun <suyanjun218@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 00e9855c23d1..897c9310266a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1308,6 +1308,7 @@ mcp251xfd_tef_obj_read(const struct mcp251xfd_priv *priv,
 		       const u8 offset, const u8 len)
 {
 	const struct mcp251xfd_tx_ring *tx_ring = priv->tx;
+	const int val_bytes = regmap_get_val_bytes(priv->map_rx);
 
 	if (IS_ENABLED(CONFIG_CAN_MCP251XFD_SANITY) &&
 	    (offset > tx_ring->obj_num ||
@@ -1322,7 +1323,7 @@ mcp251xfd_tef_obj_read(const struct mcp251xfd_priv *priv,
 	return regmap_bulk_read(priv->map_rx,
 				mcp251xfd_get_tef_obj_addr(offset),
 				hw_tef_obj,
-				sizeof(*hw_tef_obj) / sizeof(u32) * len);
+				sizeof(*hw_tef_obj) / val_bytes * len);
 }
 
 static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
@@ -1510,12 +1511,13 @@ mcp251xfd_rx_obj_read(const struct mcp251xfd_priv *priv,
 		      struct mcp251xfd_hw_rx_obj_canfd *hw_rx_obj,
 		      const u8 offset, const u8 len)
 {
+	const int val_bytes = regmap_get_val_bytes(priv->map_rx);
 	int err;
 
 	err = regmap_bulk_read(priv->map_rx,
 			       mcp251xfd_get_rx_obj_addr(ring, offset),
 			       hw_rx_obj,
-			       len * ring->obj_size / sizeof(u32));
+			       len * ring->obj_size / val_bytes);
 
 	return err;
 }
@@ -2137,6 +2139,7 @@ static int mcp251xfd_handle_spicrcif(struct mcp251xfd_priv *priv)
 static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 {
 	struct mcp251xfd_priv *priv = dev_id;
+	const int val_bytes = regmap_get_val_bytes(priv->map_reg);
 	irqreturn_t handled = IRQ_NONE;
 	int err;
 
@@ -2162,7 +2165,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 		err = regmap_bulk_read(priv->map_reg, MCP251XFD_REG_INT,
 				       &priv->regs_status,
 				       sizeof(priv->regs_status) /
-				       sizeof(u32));
+				       val_bytes);
 		if (err)
 			goto out_fail;
 
-- 
2.29.2


