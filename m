Return-Path: <SRS0=XQ7n=C6=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92081C43468
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F23320866
	for <linux-can@archiver.kernel.org>; Mon, 21 Sep 2020 13:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgIUNjH (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbgIUNjE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Sep 2020 09:39:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66E3C061755
        for <linux-can@vger.kernel.org>; Mon, 21 Sep 2020 06:39:03 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kKM21-0000ox-U4; Mon, 21 Sep 2020 15:39:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 38/38] MAINTAINERS: Add reviewer entry for microchip mcp25xxfd SPI-CAN network driver
Date:   Mon, 21 Sep 2020 15:38:45 +0200
Message-Id: <20200921133845.2249271-39-mkl@pengutronix.de>
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

From: Thomas Kopp <thomas.kopp@microchip.com>

This patch adds Thomas Kopp as a reviewer for the mcp25xxfd CAN driver.

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
Link: https://lore.kernel.org/r/20200916101334.1277-1-thomas.kopp@microchip.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcb63f0c9635..e3c1c70057e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10674,6 +10674,7 @@ F:	drivers/hid/hid-mcp2221.c
 MCP25XXFD SPI-CAN NETWORK DRIVER
 M:	Marc Kleine-Budde <mkl@pengutronix.de>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+R:	Thomas Kopp <thomas.kopp@microchip.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
-- 
2.28.0

