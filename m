Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6106C2D0E4
	for <linux-can@archiver.kernel.org>; Mon, 23 Nov 2020 11:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCB0207FF
	for <linux-can@archiver.kernel.org>; Mon, 23 Nov 2020 11:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgKWLf0 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgKWLf0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Nov 2020 06:35:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72694C0613CF
        for <linux-can@vger.kernel.org>; Mon, 23 Nov 2020 03:35:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1khA7w-0000gJ-LF; Mon, 23 Nov 2020 12:35:24 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Niels Petter <petter@ka-long.de>
Subject: [net] can: mcp251xfd: mcp251xfd_probe(): bail out if no IRQ was given
Date:   Mon, 23 Nov 2020 12:35:22 +0100
Message-Id: <20201123113522.3820052-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch add a check to the mcp251xfd_probe() function to bail out and give
the user a proper error message if no IRQ is specified. Otherwise the driver
will probe just fine but ifup will fail with a meaningless "RTNETLINK answers:
Invalid argument" error message.

Reported-by: Niels Petter <petter@ka-long.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9c215f7c5f81..8a39be076e14 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2738,6 +2738,10 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	u32 freq;
 	int err;
 
+	if (!spi->irq)
+		return dev_err_probe(&spi->dev, -ENXIO,
+				     "No IRQ specified (maybe node \"interrupts-extended\" in DT missing)!\n");
+
 	rx_int = devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
 					 GPIOD_IN);
 	if (PTR_ERR(rx_int) == -EPROBE_DEFER)
-- 
2.29.2

