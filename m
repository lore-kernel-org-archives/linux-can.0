Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC67C433EF
	for <linux-can@archiver.kernel.org>; Mon, 20 Jun 2022 15:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiFTPnD (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 20 Jun 2022 11:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244215AbiFTPm6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2022 11:42:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADD018C
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2022 08:42:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o3JYF-0002sw-6e
        for linux-can@vger.kernel.org; Mon, 20 Jun 2022 17:42:55 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 173C59A1A1
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2022 15:42:54 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CECD89A197;
        Mon, 20 Jun 2022 15:42:53 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b0fe59d8;
        Mon, 20 Jun 2022 14:39:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mcp251xfd: mcp251xfd_stop(): add missing hrtimer_cancel()
Date:   Mon, 20 Jun 2022 16:39:42 +0200
Message-Id: <20220620143942.891811-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit 169d00a25658 ("can: mcp251xfd: add TX IRQ coalescing
support") software based TX coalescing was added to the driver. The
key idea is to keep the TX complete IRQ disabled for some time after
processing it and re-enable later by a hrtimer. When bringing the
interface down, this timer has to be stopped.

Add the missing hrtimer_cancel() of the tx_irq_time hrtimer to
mcp251xfd_stop().

Fixes: 169d00a25658 ("can: mcp251xfd: add TX IRQ coalescing support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index b21252390216..34b160024ce3 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1650,6 +1650,7 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	netif_stop_queue(ndev);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	hrtimer_cancel(&priv->rx_irq_timer);
+	hrtimer_cancel(&priv->tx_irq_timer);
 	mcp251xfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
 	can_rx_offload_disable(&priv->offload);
-- 
2.35.1


