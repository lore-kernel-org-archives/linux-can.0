Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1320BC4332F
	for <linux-can@archiver.kernel.org>; Thu, 24 Feb 2022 08:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiBXIaQ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiBXI3o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Feb 2022 03:29:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E45276D7F
        for <linux-can@vger.kernel.org>; Thu, 24 Feb 2022 00:28:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nN9Ud-0004Pi-MJ
        for linux-can@vger.kernel.org; Thu, 24 Feb 2022 09:28:55 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9FE423C2E8
        for <linux-can@vger.kernel.org>; Thu, 24 Feb 2022 08:27:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6A5393C2B0;
        Thu, 24 Feb 2022 08:27:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id cb40c8e2;
        Thu, 24 Feb 2022 08:27:28 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 18/36] can: mcp251xfd: mcp251xfd_chip_stop(): convert to a void function
Date:   Thu, 24 Feb 2022 09:27:08 +0100
Message-Id: <20220224082726.3000007-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224082726.3000007-1-mkl@pengutronix.de>
References: <20220224082726.3000007-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The mcp251xfd_chip_stop() function tries the best to stop the chip and
put it into sleep mode. It continues, even if some intermediate steps
fail. As none of the callers use the return value, let this function
return void.

Link: https://lore.kernel.org/all/20220207131047.282110-6-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 4c8c45f246d8..e8e736eeb69c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -633,14 +633,14 @@ static int mcp251xfd_chip_interrupts_disable(const struct mcp251xfd_priv *priv)
 	return regmap_write(priv->map_reg, MCP251XFD_REG_CRC, 0);
 }
 
-static int mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
-			       const enum can_state state)
+static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
+				const enum can_state state)
 {
 	priv->can.state = state;
 
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_rx_int_disable(priv);
-	return mcp251xfd_chip_sleep(priv);
+	mcp251xfd_chip_sleep(priv);
 }
 
 static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
-- 
2.34.1


