Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBECC43460
	for <linux-can@archiver.kernel.org>; Wed,  7 Apr 2021 08:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EEB61222
	for <linux-can@archiver.kernel.org>; Wed,  7 Apr 2021 08:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhDGIBp (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242039AbhDGIBl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Apr 2021 04:01:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C78C061760
        for <linux-can@vger.kernel.org>; Wed,  7 Apr 2021 01:01:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lU37x-0001zg-LJ
        for linux-can@vger.kernel.org; Wed, 07 Apr 2021 10:01:29 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B2E3F6097FF
        for <linux-can@vger.kernel.org>; Wed,  7 Apr 2021 08:01:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F025F6097D5;
        Wed,  7 Apr 2021 08:01:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e9b1f8c8;
        Wed, 7 Apr 2021 08:01:19 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [net-next 5/6] can: mcp251xfd: mcp251xfd_regmap_crc_read_one(): Factor out crc check into separate function
Date:   Wed,  7 Apr 2021 10:01:17 +0200
Message-Id: <20210407080118.1916040-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407080118.1916040-1-mkl@pengutronix.de>
References: <20210407080118.1916040-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch factors out the crc check into a separate function. This is
preparation for the next patch.

Link: https://lore.kernel.org/r/20210406110617.1865592-4-mkl@pengutronix.de
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 314f868b3465..35557ac43c03 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -232,13 +232,31 @@ mcp251xfd_regmap_crc_write(void *context,
 						 count - data_offset);
 }
 
+static int
+mcp251xfd_regmap_crc_read_check_crc(const struct mcp251xfd_map_buf_crc * const buf_rx,
+				    const struct mcp251xfd_map_buf_crc * const buf_tx,
+				    unsigned int data_len)
+{
+	u16 crc_received, crc_calculated;
+
+	crc_received = get_unaligned_be16(buf_rx->data + data_len);
+	crc_calculated = mcp251xfd_crc16_compute2(&buf_tx->cmd,
+						  sizeof(buf_tx->cmd),
+						  buf_rx->data,
+						  data_len);
+	if (crc_received != crc_calculated)
+		return -EBADMSG;
+
+	return 0;
+}
+
+
 static int
 mcp251xfd_regmap_crc_read_one(struct mcp251xfd_priv *priv,
 			      struct spi_message *msg, unsigned int data_len)
 {
 	const struct mcp251xfd_map_buf_crc *buf_rx = priv->map_buf_crc_rx;
 	const struct mcp251xfd_map_buf_crc *buf_tx = priv->map_buf_crc_tx;
-	u16 crc_received, crc_calculated;
 	int err;
 
 	BUILD_BUG_ON(sizeof(buf_rx->cmd) != sizeof(__be16) + sizeof(u8));
@@ -248,15 +266,7 @@ mcp251xfd_regmap_crc_read_one(struct mcp251xfd_priv *priv,
 	if (err)
 		return err;
 
-	crc_received = get_unaligned_be16(buf_rx->data + data_len);
-	crc_calculated = mcp251xfd_crc16_compute2(&buf_tx->cmd,
-						  sizeof(buf_tx->cmd),
-						  buf_rx->data,
-						  data_len);
-	if (crc_received != crc_calculated)
-		return -EBADMSG;
-
-	return 0;
+	return mcp251xfd_regmap_crc_read_check_crc(buf_rx, buf_tx, data_len);
 }
 
 static int
-- 
2.30.2


