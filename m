Return-Path: <SRS0=gX5R=DX=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22C2C433DF
	for <linux-can@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DB720878
	for <linux-can@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408596AbgJPUwR (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408571AbgJPUwP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Oct 2020 16:52:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD56C0613D3
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2020 13:52:15 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kTWhx-00084g-SD; Fri, 16 Oct 2020 22:52:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 2/3] can: mcp251xfd: mcp251xfd_chip_timestamp_init():
Date:   Fri, 16 Oct 2020 22:52:10 +0200
Message-Id: <20201016205211.1141590-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016205211.1141590-1-mkl@pengutronix.de>
References: <20201016205211.1141590-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c36f5f14d50c..b8304b7096d1 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -665,10 +665,11 @@ static int mcp251xfd_chip_clock_init(const struct mcp251xfd_priv *priv)
 	osc = MCP251XFD_REG_OSC_LPMEN |
 		FIELD_PREP(MCP251XFD_REG_OSC_CLKODIV_MASK,
 			   MCP251XFD_REG_OSC_CLKODIV_10);
-	err = regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
-	if (err)
-		return err;
+	return regmap_write(priv->map_reg, MCP251XFD_REG_OSC, osc);
+}
 
+static int mcp251xfd_chip_timestamp_init(const struct mcp251xfd_priv *priv)
+{
 	/* Set Time Base Counter Prescaler to 1.
 	 *
 	 * This means an overflow of the 32 bit Time Base Counter
@@ -1038,6 +1039,10 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_stop;
 
+	err = mcp251xfd_chip_timestamp_init(priv);
+	if (err)
+		goto out_chip_stop;
+
 	err = mcp251xfd_set_bittiming(priv);
 	if (err)
 		goto out_chip_stop;
-- 
2.28.0

