Return-Path: <SRS0=XQ7n=C6=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57912C4727E
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDDC2084C
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgIUNjH (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgIUNjD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Sep 2020 09:39:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43118C0613D0
        for <linux-can@vger.kernel.org>; Mon, 21 Sep 2020 06:39:03 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKM21-0000ox-35; Mon, 21 Sep 2020 15:39:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 36/38] can: mcp25xxfd: add listen-only mode
Date:   Mon, 21 Sep 2020 15:38:43 +0200
Message-Id: <20200921133845.2249271-37-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921133845.2249271-1-mkl@pengutronix.de>
References: <20200921133845.2249271-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

This commit enables listen-only mode, which works internally like CANFD mode.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/r/20200918172536.2074504-5-mkl@pengutronix.de
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index 10e4b6d07f95..bd2ba981ae36 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -392,7 +392,8 @@ static int mcp25xxfd_ring_alloc(struct mcp25xxfd_priv *priv)
 	int ram_free, i;
 
 	tef_obj_size = sizeof(struct mcp25xxfd_hw_tef_obj);
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+	/* listen-only mode works like FD mode */
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD)) {
 		tx_obj_num = MCP25XXFD_TX_OBJ_NUM_CANFD;
 		tx_obj_size = sizeof(struct mcp25xxfd_hw_tx_obj_canfd);
 		rx_obj_size = sizeof(struct mcp25xxfd_hw_rx_obj_canfd);
@@ -807,7 +808,7 @@ mcp25xxfd_chip_rx_fifo_init_one(const struct mcp25xxfd_priv *priv,
 		MCP25XXFD_REG_FIFOCON_RXOVIE |
 		MCP25XXFD_REG_FIFOCON_TFNRFNIE;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD))
 		fifo_con |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
 				       MCP25XXFD_REG_FIFOCON_PLSIZE_64);
 	else
@@ -857,7 +858,7 @@ static int mcp25xxfd_chip_fifo_init(const struct mcp25xxfd_priv *priv)
 		MCP25XXFD_REG_FIFOCON_TXEN |
 		MCP25XXFD_REG_FIFOCON_TXATIE;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_FD))
 		val |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
 				  MCP25XXFD_REG_FIFOCON_PLSIZE_64);
 	else
@@ -930,7 +931,9 @@ static u8 mcp25xxfd_get_normal_mode(const struct mcp25xxfd_priv *priv)
 {
 	u8 mode;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		mode = MCP25XXFD_REG_CON_MODE_LISTENONLY;
+	else if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
 		mode = MCP25XXFD_REG_CON_MODE_MIXED;
 	else
 		mode = MCP25XXFD_REG_CON_MODE_CAN2_0;
@@ -2792,8 +2795,9 @@ static int mcp25xxfd_probe(struct spi_device *spi)
 	priv->can.do_get_berr_counter = mcp25xxfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp25xxfd_bittiming_const;
 	priv->can.data_bittiming_const = &mcp25xxfd_data_bittiming_const;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING |
-		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
+		CAN_CTRLMODE_FD_NON_ISO;
 	priv->ndev = ndev;
 	priv->spi = spi;
 	priv->rx_int = rx_int;
-- 
2.28.0

