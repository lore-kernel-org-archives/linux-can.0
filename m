Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E7C433E0
	for <linux-can@archiver.kernel.org>; Tue,  5 Jan 2021 21:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EC222D71
	for <linux-can@archiver.kernel.org>; Tue,  5 Jan 2021 21:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbhAEVmY (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 5 Jan 2021 16:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbhAEVmY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Jan 2021 16:42:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE9C061795
        for <linux-can@vger.kernel.org>; Tue,  5 Jan 2021 13:41:43 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kwu5G-0001dD-1Z
        for linux-can@vger.kernel.org; Tue, 05 Jan 2021 22:41:42 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 49D055BA551
        for <linux-can@vger.kernel.org>; Tue,  5 Jan 2021 21:41:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 886055BA546;
        Tue,  5 Jan 2021 21:41:39 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3c9c299f;
        Tue, 5 Jan 2021 21:41:38 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: mcp251xfd: mcp251xfd_handle_tefif(): fix TEF vs. TX race condition
Date:   Tue,  5 Jan 2021 22:41:37 +0100
Message-Id: <20210105214138.3150886-2-mkl@pengutronix.de>
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

The mcp251xfd driver uses a TX FIFO for sending CAN frames and a TX Event FIFO
(TEF) for completed TX-requests.

The TEF event handling in the mcp251xfd_handle_tefif() function has a race
condition. It first increments the tx-ring's tail counter to signal that
there's room in the TX and TEF FIFO, then it increments the TEF FIFO in
hardware.

A running mcp251xfd_start_xmit() on a different CPU might not stop the txqueue
(as the tx-ring still shows free space). The next mcp251xfd_start_xmit() will
push a message into the chip and the TX complete event might overflow the TEF
FIFO.

This patch changes the order to fix the problem.

Fixes: 68c0c1c7f966 ("can: mcp251xfd: tef-path: reduce number of SPI core requests to set UINC bit")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 77129d5f410b..85a1a8b7c0e7 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1368,13 +1368,10 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 		struct spi_transfer *last_xfer;
 
-		tx_ring->tail += len;
-
 		/* Increment the TEF FIFO tail pointer 'len' times in
 		 * a single SPI message.
-		 */
-
-		/* Note:
+		 *
+		 * Note:
 		 *
 		 * "cs_change == 1" on the last transfer results in an
 		 * active chip select after the complete SPI
@@ -1391,6 +1388,8 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		if (err)
 			return err;
 
+		tx_ring->tail += len;
+
 		err = mcp251xfd_check_tef_tail(priv);
 		if (err)
 			return err;
-- 
2.29.2


