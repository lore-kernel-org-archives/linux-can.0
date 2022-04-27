Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16823C433F5
	for <linux-can@archiver.kernel.org>; Wed, 27 Apr 2022 13:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiD0Nqt (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbiD0Nqo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Apr 2022 09:46:44 -0400
Received: from vsp-unauthed02.binero.net (vsp-unauthed02.binero.net [195.74.38.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7C93B4365
        for <linux-can@vger.kernel.org>; Wed, 27 Apr 2022 06:43:30 -0700 (PDT)
X-Halon-ID: 043cdc90-c630-11ec-9627-0050569116f7
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id 043cdc90-c630-11ec-9627-0050569116f7;
        Wed, 27 Apr 2022 15:43:28 +0200 (CEST)
From:   Andreas Larsson <andreas@gaisler.com>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-kernel@vger.kernel.org, software@gaisler.com,
        Daniel Hellstrom <daniel@gaisler.com>
Subject: [PATCH 1/3] can: grcan: Use ofdev->dev when allocating DMA memory
Date:   Wed, 27 Apr 2022 15:43:05 +0200
Message-Id: <20220427134307.22981-2-andreas@gaisler.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427134307.22981-1-andreas@gaisler.com>
References: <20220427134307.22981-1-andreas@gaisler.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>

Use the device of the device tree node should be rather than the device
of the struct net_device when allocating DMA buffers.

Since commit 53b7670e5735 ("sparc: factor the dma coherent mapping into
helper") the driver oopses when using the wrong device on sparc32.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/net/can/grcan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index d0c5a7a60daf..f7c3cf941f61 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -248,6 +248,7 @@ struct grcan_device_config {
 struct grcan_priv {
 	struct can_priv can;	/* must be the first member */
 	struct net_device *dev;
+	struct device *ofdev_dev;
 	struct napi_struct napi;
 
 	struct grcan_registers __iomem *regs;	/* ioremap'ed registers */
@@ -921,7 +922,7 @@ static void grcan_free_dma_buffers(struct net_device *dev)
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_dma *dma = &priv->dma;
 
-	dma_free_coherent(&dev->dev, dma->base_size, dma->base_buf,
+	dma_free_coherent(priv->ofdev_dev, dma->base_size, dma->base_buf,
 			  dma->base_handle);
 	memset(dma, 0, sizeof(*dma));
 }
@@ -946,7 +947,8 @@ static int grcan_allocate_dma_buffers(struct net_device *dev,
 
 	/* Extra GRCAN_BUFFER_ALIGNMENT to allow for alignment */
 	dma->base_size = lsize + ssize + GRCAN_BUFFER_ALIGNMENT;
-	dma->base_buf = dma_alloc_coherent(&dev->dev,
+
+	dma->base_buf = dma_alloc_coherent(priv->ofdev_dev,
 					   dma->base_size,
 					   &dma->base_handle,
 					   GFP_KERNEL);
@@ -1587,6 +1589,7 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	memcpy(&priv->config, &grcan_module_config,
 	       sizeof(struct grcan_device_config));
 	priv->dev = dev;
+	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
 	priv->can.bittiming_const = &grcan_bittiming_const;
 	priv->can.do_set_bittiming = grcan_set_bittiming;
-- 
2.17.1

