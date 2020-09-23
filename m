Return-Path: <SRS0=s8nA=DA=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D818C2D0A8
	for <linux-can@archiver.kernel.org>; Wed, 23 Sep 2020 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A64214D8
	for <linux-can@archiver.kernel.org>; Wed, 23 Sep 2020 11:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIWLra (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWLra (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 07:47:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3EC0613CE
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 04:47:30 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kL3FA-0005DR-Cj; Wed, 23 Sep 2020 13:47:28 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     manivannan.sadhasivam@linaro.org,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] can: mcp25xxfd: mcp25xxfd_irq(): add missing initialization of variable set_normal mode
Date:   Wed, 23 Sep 2020 13:47:26 +0200
Message-Id: <20200923114726.2704426-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes the following warning:

    drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2155 mcp25xxfd_irq()
    error: uninitialized symbol 'set_normal_mode'.

by adding the missing initialization.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index bd2ba981ae36..912a73458a41 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -2073,7 +2073,7 @@ static irqreturn_t mcp25xxfd_irq(int irq, void *dev_id)
 
 	do {
 		u32 intf_pending, intf_pending_clearable;
-		bool set_normal_mode;
+		bool set_normal_mode = false;
 
 		err = regmap_bulk_read(priv->map_reg, MCP25XXFD_REG_INT,
 				       &priv->regs_status,
-- 
2.28.0

