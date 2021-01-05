Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA73CC433E6
	for <linux-can@archiver.kernel.org>; Tue,  5 Jan 2021 21:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5612922D73
	for <linux-can@archiver.kernel.org>; Tue,  5 Jan 2021 21:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbhAEVmZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 5 Jan 2021 16:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbhAEVmY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Jan 2021 16:42:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956CC061793
        for <linux-can@vger.kernel.org>; Tue,  5 Jan 2021 13:41:43 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kwu5G-0001dL-8n
        for linux-can@vger.kernel.org; Tue, 05 Jan 2021 22:41:42 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8C0CF5BA555
        for <linux-can@vger.kernel.org>; Tue,  5 Jan 2021 21:41:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A73B85BA548;
        Tue,  5 Jan 2021 21:41:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id da0288f2;
        Tue, 5 Jan 2021 21:41:39 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: mcp251xfd: mcp251xfd_handle_rxif_ring(): first increment RX tail pointer in HW, then in driver
Date:   Tue,  5 Jan 2021 22:41:38 +0100
Message-Id: <20210105214138.3150886-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210105214138.3150886-1-mkl@pengutronix.de>
References: <20210105214138.3150886-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The previous patch fixes a TEF vs. TX race condition, by first updating the TEF
tail pointer in hardware, and then updating the driver internal pointer.

The same pattern exists in the RX-path, too. This should be no problem, as the
driver accesses the RX-FIFO from the interrupt handler only, thus the access is
properly serialized. Fix the order here, too, so that the TEF- and RX-path look
similar.

Fixes: 1f652bb6bae7 ("can: mcp25xxfd: rx-path: reduce number of SPI core requests to set UINC bit")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 85a1a8b7c0e7..36235afb0bc6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1552,10 +1552,8 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 
 		/* Increment the RX FIFO tail pointer 'len' times in a
 		 * single SPI message.
-		 */
-		ring->tail += len;
-
-		/* Note:
+		 *
+		 * Note:
 		 *
 		 * "cs_change == 1" on the last transfer results in an
 		 * active chip select after the complete SPI
@@ -1571,6 +1569,8 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 		last_xfer->cs_change = 1;
 		if (err)
 			return err;
+
+		ring->tail += len;
 	}
 
 	return 0;
-- 
2.29.2


