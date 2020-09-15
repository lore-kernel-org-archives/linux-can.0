Return-Path: <SRS0=ffhE=CY=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA32C433E2
	for <linux-can@archiver.kernel.org>; Tue, 15 Sep 2020 22:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08833206BE
	for <linux-can@archiver.kernel.org>; Tue, 15 Sep 2020 22:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgIOWgL (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgIOWfz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62944C0611BC
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:42 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJY4-0002Tb-LF; Wed, 16 Sep 2020 00:35:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 32/37] can: rx-offload: can_rx_offload_add_manual(): add new initialization function
Date:   Wed, 16 Sep 2020 00:35:22 +0200
Message-Id: <20200915223527.1417033-33-mkl@pengutronix.de>
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

This patch adds a new initialization function:
can_rx_offload_add_manual()

It should be used to add support rx-offload to a driver, if the callback
mechanism should not be used. Use e.g. can_rx_offload_queue_sorted() to queue
skbs into rx-offload.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-offload.c   | 11 +++++++++++
 include/linux/can/rx-offload.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index e8328910a234..3b180269a92d 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -351,6 +351,17 @@ int can_rx_offload_add_fifo(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_add_fifo);
 
+int can_rx_offload_add_manual(struct net_device *dev,
+			      struct can_rx_offload *offload,
+			      unsigned int weight)
+{
+	if (offload->mailbox_read)
+		return -EINVAL;
+
+	return can_rx_offload_init_queue(dev, offload, weight);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_add_manual);
+
 void can_rx_offload_enable(struct can_rx_offload *offload)
 {
 	napi_enable(&offload->napi);
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index 1b78a0cfb615..f1b38088b765 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -35,6 +35,9 @@ int can_rx_offload_add_timestamp(struct net_device *dev,
 int can_rx_offload_add_fifo(struct net_device *dev,
 			    struct can_rx_offload *offload,
 			    unsigned int weight);
+int can_rx_offload_add_manual(struct net_device *dev,
+			      struct can_rx_offload *offload,
+			      unsigned int weight);
 int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 					 u64 reg);
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
-- 
2.28.0

