Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C25C4332F
	for <linux-can@archiver.kernel.org>; Thu, 10 Mar 2022 14:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243975AbiCJOcf (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343990AbiCJObe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 09:31:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A3EACB5
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 06:29:19 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nSJn4-000671-2r
        for linux-can@vger.kernel.org; Thu, 10 Mar 2022 15:29:18 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 36F0147DD4
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 14:29:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BD24247DC4;
        Thu, 10 Mar 2022 14:29:10 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c11b4240;
        Thu, 10 Mar 2022 14:29:05 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/29] can: gs_usb: gs_make_candev(): call SET_NETDEV_DEV() after handling all bt_const->feature
Date:   Thu, 10 Mar 2022 15:28:49 +0100
Message-Id: <20220310142903.341658-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310142903.341658-1-mkl@pengutronix.de>
References: <20220310142903.341658-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch moves the call to SET_NETDEV_DEV() after all handling
(including cleanup) of the bt_const->feature is done. This looks more
consistent.

Link: https://lore.kernel.org/all/20220309124132.291861-8-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 7ba492150cdb..fa370549bd9e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -849,14 +849,14 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	if (feature & GS_CAN_FEATURE_ONE_SHOT)
 		dev->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
 
-	SET_NETDEV_DEV(netdev, &intf->dev);
-
 	if (le32_to_cpu(dconf->sw_version) > 1)
 		if (feature & GS_CAN_FEATURE_IDENTIFY)
 			netdev->ethtool_ops = &gs_usb_ethtool_ops;
 
 	kfree(bt_const);
 
+	SET_NETDEV_DEV(netdev, &intf->dev);
+
 	rc = register_candev(dev->netdev);
 	if (rc) {
 		free_candev(dev->netdev);
-- 
2.35.1


