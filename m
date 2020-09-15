Return-Path: <SRS0=ffhE=CY=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706DFC433E2
	for <linux-can@archiver.kernel.org>; Tue, 15 Sep 2020 22:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428F9206BE
	for <linux-can@archiver.kernel.org>; Tue, 15 Sep 2020 22:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgIOWf6 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbgIOWfo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89905C061222
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:39 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJY1-0002Tb-Nj; Wed, 16 Sep 2020 00:35:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 23/37] can: spi: Kconfig: remove unneeded dependencies form Kconfig symbols
Date:   Wed, 16 Sep 2020 00:35:13 +0200
Message-Id: <20200915223527.1417033-24-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commits

    653ee35ce6d5 ("can: hi311x: remove custom DMA mapped buffer")
    Fixes: df58525df395 ("can: mcp251x: remove custom DMA mapped buffer")

both the hi3111x and the mcp251x driver don't make use of the DMA API
any more. So we can safely remove the HAS_DMA dependency.

While we're here, remove the unneeded CAN_DEV and SPI dependencies from
the CAN_HI311X symbol, as the parent menus already have these
dependencies.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/spi/Kconfig b/drivers/net/can/spi/Kconfig
index f780c79aac6f..a332008d8495 100644
--- a/drivers/net/can/spi/Kconfig
+++ b/drivers/net/can/spi/Kconfig
@@ -4,13 +4,11 @@ menu "CAN SPI interfaces"
 
 config CAN_HI311X
 	tristate "Holt HI311x SPI CAN controllers"
-	depends on CAN_DEV && SPI && HAS_DMA
 	help
 	  Driver for the Holt HI311x SPI CAN controllers.
 
 config CAN_MCP251X
 	tristate "Microchip MCP251x and MCP25625 SPI CAN controllers"
-	depends on HAS_DMA
 	help
 	  Driver for the Microchip MCP251x and MCP25625 SPI CAN
 	  controllers.
-- 
2.28.0

