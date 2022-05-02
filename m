Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440A4C433F5
	for <linux-can@archiver.kernel.org>; Mon,  2 May 2022 07:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376371AbiEBICt (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 2 May 2022 04:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbiEBICs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 May 2022 04:02:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC32C670
        for <linux-can@vger.kernel.org>; Mon,  2 May 2022 00:59:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlQxj-0002RW-9N
        for linux-can@vger.kernel.org; Mon, 02 May 2022 09:59:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DEE3272E1E
        for <linux-can@vger.kernel.org>; Mon,  2 May 2022 07:59:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9275372E03;
        Mon,  2 May 2022 07:59:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 591e8488;
        Mon, 2 May 2022 07:59:16 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/9] can: m_can: remove a copy of the NAPI_POLL_WEIGHT define
Date:   Mon,  2 May 2022 09:59:07 +0200
Message-Id: <20220502075914.1905039-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502075914.1905039-1-mkl@pengutronix.de>
References: <20220502075914.1905039-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

Defining local versions of NAPI_POLL_WEIGHT with the same values in
the drivers just makes refactoring harder.

Link: https://lore.kernel.org/all/20220429174446.196655-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2779bba390f2..e6d2da4a9f41 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -77,9 +77,6 @@ enum m_can_reg {
 	M_CAN_TXEFA	= 0xf8,
 };
 
-/* napi related */
-#define M_CAN_NAPI_WEIGHT	64
-
 /* message ram configuration data length */
 #define MRAM_CFG_LEN	8
 
@@ -951,7 +948,7 @@ static int m_can_rx_peripheral(struct net_device *dev)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int work_done;
 
-	work_done = m_can_rx_handler(dev, M_CAN_NAPI_WEIGHT);
+	work_done = m_can_rx_handler(dev, NAPI_POLL_WEIGHT);
 
 	/* Don't re-enable interrupts if the driver had a fatal error
 	 * (e.g., FIFO read failure).
@@ -1474,7 +1471,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 
 	if (!cdev->is_peripheral)
 		netif_napi_add(dev, &cdev->napi,
-			       m_can_poll, M_CAN_NAPI_WEIGHT);
+			       m_can_poll, NAPI_POLL_WEIGHT);
 
 	/* Shared properties of all M_CAN versions */
 	cdev->version = m_can_version;
@@ -1994,7 +1991,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 
 	if (cdev->is_peripheral) {
 		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
-						M_CAN_NAPI_WEIGHT);
+						NAPI_POLL_WEIGHT);
 		if (ret)
 			goto clk_disable;
 	}
-- 
2.35.1


