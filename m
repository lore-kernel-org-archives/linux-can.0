Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD6C64E90
	for <linux-can@archiver.kernel.org>; Mon, 30 Nov 2020 14:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7E52076E
	for <linux-can@archiver.kernel.org>; Mon, 30 Nov 2020 14:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgK3OQF (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgK3OQE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Nov 2020 09:16:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E2C061A4C
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 06:14:46 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kjjwy-0007ff-So
        for linux-can@vger.kernel.org; Mon, 30 Nov 2020 15:14:44 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 15F1159FB00
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 14:14:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D46E159FACA;
        Mon, 30 Nov 2020 14:14:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b18b0cca;
        Mon, 30 Nov 2020 14:14:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [net-next 05/14] can: mcp251xfd: move struct mcp251xfd_tef_ring definition
Date:   Mon, 30 Nov 2020 15:14:23 +0100
Message-Id: <20201130141432.278219-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130141432.278219-1-mkl@pengutronix.de>
References: <20201130141432.278219-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch moves the struct mcp251xfd_tef_ring upwards, so that the union
mcp251xfd_write_reg_buf and struct spi_transfer can be made members of it.

Link: https://lore.kernel.org/r/20201126132144.351154-5-mkl@pengutronix.de
Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 76585a40d16e..299dbf72e24b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -459,14 +459,6 @@ struct mcp251xfd_hw_rx_obj_canfd {
 	u8 data[sizeof_field(struct canfd_frame, data)];
 };
 
-struct mcp251xfd_tef_ring {
-	unsigned int head;
-	unsigned int tail;
-
-	/* u8 obj_num equals tx_ring->obj_num */
-	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
-};
-
 struct __packed mcp251xfd_buf_cmd {
 	__be16 cmd;
 };
@@ -506,6 +498,14 @@ struct mcp251xfd_tx_obj {
 	union mcp251xfd_tx_obj_load_buf buf;
 };
 
+struct mcp251xfd_tef_ring {
+	unsigned int head;
+	unsigned int tail;
+
+	/* u8 obj_num equals tx_ring->obj_num */
+	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
+};
+
 struct mcp251xfd_tx_ring {
 	unsigned int head;
 	unsigned int tail;
-- 
2.29.2


