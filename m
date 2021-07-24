Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D50C4338F
	for <linux-can@archiver.kernel.org>; Sat, 24 Jul 2021 20:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E31A460E8C
	for <linux-can@archiver.kernel.org>; Sat, 24 Jul 2021 20:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGXULv (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 24 Jul 2021 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGXULv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Jul 2021 16:11:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BB5C061575
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 13:52:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7Od9-0005C4-QK
        for linux-can@vger.kernel.org; Sat, 24 Jul 2021 22:52:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E606765717C
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 20:52:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 86909657178;
        Sat, 24 Jul 2021 20:52:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 86c7b5e7;
        Sat, 24 Jul 2021 20:52:17 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mcp251xfd: mcp251xfd_open(): request IRQ as shared
Date:   Sat, 24 Jul 2021 22:52:13 +0200
Message-Id: <20210724205212.737328-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The driver's IRQ handler supports shared IRQs, so request a shared IRQ
handler.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 90b06052549d..2b1e57552e1c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2527,8 +2527,8 @@ static int mcp251xfd_open(struct net_device *ndev)
 	can_rx_offload_enable(&priv->offload);
 
 	err = request_threaded_irq(spi->irq, NULL, mcp251xfd_irq,
-				   IRQF_ONESHOT, dev_name(&spi->dev),
-				   priv);
+				   IRQF_SHARED | IRQF_ONESHOT,
+				   dev_name(&spi->dev), priv);
 	if (err)
 		goto out_can_rx_offload_disable;
 
-- 
2.30.2


