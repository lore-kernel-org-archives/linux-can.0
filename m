Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A6C433DB
	for <linux-can@archiver.kernel.org>; Thu, 28 Jan 2021 10:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9964DCC
	for <linux-can@archiver.kernel.org>; Thu, 28 Jan 2021 10:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhA1Kty (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 28 Jan 2021 05:49:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53045 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhA1Ktq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jan 2021 05:49:46 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l54pA-0000qQ-Bu
        for linux-can@vger.kernel.org; Thu, 28 Jan 2021 11:46:52 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 0B1235D06C3
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 10:46:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4C8BD5D06AA;
        Thu, 28 Jan 2021 10:46:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b2c4c7d0;
        Thu, 28 Jan 2021 10:46:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/8] can: mcp251xfd: mcp251xfd_probe(): sort errata table alphabetically, fix indention
Date:   Thu, 28 Jan 2021 11:46:38 +0100
Message-Id: <20210128104644.2982125-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128104644.2982125-1-mkl@pengutronix.de>
References: <20210128104644.2982125-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch sorts the errata table alphabetically and fixes the indention.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 015227422372..c6ccd0054152 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2953,10 +2953,10 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	 * 2518	20 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	 9375000 Hz	 93.75%	600000000 Hz	bad	assigned-clocks = <&ccu CLK_SPIx>
 	 * 2518	40 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	16666667 Hz	 83.33%	600000000 Hz	good	assigned-clocks = <&ccu CLK_SPIx>
 	 * 2518	40 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	18750000 Hz	 93.75%	600000000 Hz	bad	assigned-clocks = <&ccu CLK_SPIx>
+	 * 2517	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	good	default
+	 * 2518	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	good	default
 	 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi		 8333333 Hz	 83.33%	 16666667 Hz	good	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
 	 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi		 9523809 Hz	 95.34%	 28571429 Hz	bad	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
-	 * 2517 40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	good	default
-	 * 2518 40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	good	default
 	 *
 	 */
 	priv->spi_max_speed_hz_orig = spi->max_speed_hz;
-- 
2.29.2


