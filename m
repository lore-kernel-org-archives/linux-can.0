Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BB4C43331
	for <linux-can@archiver.kernel.org>; Fri,  5 Mar 2021 13:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B92964F60
	for <linux-can@archiver.kernel.org>; Fri,  5 Mar 2021 13:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhCENCf (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 5 Mar 2021 08:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhCENCX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 08:02:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B02DC061574
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 05:02:23 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lIA61-0006MT-UY
        for linux-can@vger.kernel.org; Fri, 05 Mar 2021 14:02:21 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AABC25EE85A
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 13:02:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C84475EE837;
        Fri,  5 Mar 2021 13:02:13 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ea2142ea;
        Fri, 5 Mar 2021 13:02:13 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dario Binacchi <dariobin@libero.it>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6 06/12] can: c_can: fix remaining checkpatch warnings
Date:   Fri,  5 Mar 2021 14:02:05 +0100
Message-Id: <20210305130211.2860914-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305130211.2860914-1-mkl@pengutronix.de>
References: <20210305130211.2860914-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes the remaining checkpatch warnings in the driver.

Link: https://lore.kernel.org/r/20210304154240.2747987-7-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c     | 3 ++-
 drivers/net/can/c_can/c_can_pci.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index eb9b1ab09484..b820002fb81e 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -765,7 +765,8 @@ static u32 c_can_adjust_pending(u32 pend)
 	/* Find the first set bit after the gap. We walk backwards
 	 * from the last set bit.
 	 */
-	for (lasts--; pend & (1 << (lasts - 1)); lasts--);
+	for (lasts--; pend & (1 << (lasts - 1)); lasts--)
+		;
 
 	return pend & ~((1 << lasts) - 1);
 }
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 8cd9578b30b4..ad5683cdf1b8 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -266,7 +266,7 @@ static const struct c_can_pci_data c_can_pch = {
 
 #define C_CAN_ID(_vend, _dev, _driverdata) {		\
 	PCI_DEVICE(_vend, _dev),			\
-	.driver_data = (unsigned long)&_driverdata,	\
+	.driver_data = (unsigned long)&(_driverdata),	\
 }
 
 static const struct pci_device_id c_can_pci_tbl[] = {
-- 
2.30.1


