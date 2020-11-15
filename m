Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE181C63697
	for <linux-can@archiver.kernel.org>; Sun, 15 Nov 2020 17:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7092120639
	for <linux-can@archiver.kernel.org>; Sun, 15 Nov 2020 17:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgKORlq (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 15 Nov 2020 12:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgKORlq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 12:41:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841A7C0613D1
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 09:41:46 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1keM21-0005uQ-S0; Sun, 15 Nov 2020 18:41:41 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 09/15] can: tcan4x5x: replace depends on REGMAP_SPI with depends on SPI
Date:   Sun, 15 Nov 2020 18:41:25 +0100
Message-Id: <20201115174131.2089251-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115174131.2089251-1-mkl@pengutronix.de>
References: <20201115174131.2089251-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

regmap is a library function that gets selected by drivers that need it. No
driver modules should depend on it. Instead depends on SPI and select
REGMAP_SPI. Depending on REGMAP_SPI makes this driver only build if another
driver already selected REGMAP_SPI, as the symbol can't be selected through the
menu kernel configuration.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Link: http://lore.kernel.org/r/20200413141013.506613-1-enric.balletbo@collabora.com
Reviewed-by: Dan Murphy <dmurphy@ti.com>
Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
index 48be627c85c2..5f9f8192dd0b 100644
--- a/drivers/net/can/m_can/Kconfig
+++ b/drivers/net/can/m_can/Kconfig
@@ -16,7 +16,8 @@ config CAN_M_CAN_PLATFORM
 
 config CAN_M_CAN_TCAN4X5X
 	depends on CAN_M_CAN
-	depends on REGMAP_SPI
+	depends on SPI
+	select REGMAP_SPI
 	tristate "TCAN4X5X M_CAN device"
 	help
 	  Say Y here if you want support for Texas Instruments TCAN4x5x
-- 
2.29.2

