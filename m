Return-Path: <SRS0=VTa6=C3=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7DCC43466
	for <linux-can@archiver.kernel.org>; Fri, 18 Sep 2020 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8302073A
	for <linux-can@archiver.kernel.org>; Fri, 18 Sep 2020 17:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIRRZo (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIRRZn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Sep 2020 13:25:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C20C0613CE
        for <linux-can@vger.kernel.org>; Fri, 18 Sep 2020 10:25:43 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kJK8j-0006bc-LW; Fri, 18 Sep 2020 19:25:41 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     manivannan.sadhasivam@linaro.org, dev.kurt@vandijck-laurijssen.be,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v53 6/6] MAINTAINERS: Add reviewer entry for microchip mcp25xxfd SPI-CAN network driver
Date:   Fri, 18 Sep 2020 19:25:36 +0200
Message-Id: <20200918172536.2074504-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918172536.2074504-1-mkl@pengutronix.de>
References: <20200918172536.2074504-1-mkl@pengutronix.de>
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

