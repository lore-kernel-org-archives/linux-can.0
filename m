Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFE5C4332F
	for <linux-can@archiver.kernel.org>; Thu, 10 Mar 2022 14:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243979AbiCJOcf (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbiCJObe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 09:31:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A9DEACAB
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 06:29:17 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nSJn1-0005yE-W7
        for linux-can@vger.kernel.org; Thu, 10 Mar 2022 15:29:16 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8012847DBE
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 14:29:10 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 059BA47DB1;
        Thu, 10 Mar 2022 14:29:09 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8297442f;
        Thu, 10 Mar 2022 14:29:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/29] can: gs_usb: GS_CAN_FLAG_OVERFLOW: make use of BIT()
Date:   Thu, 10 Mar 2022 15:28:46 +0100
Message-Id: <20220310142903.341658-13-mkl@pengutronix.de>
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

This patch converts the driver to use BIT() to define flags.

Link: https://lore.kernel.org/all/20220309124132.291861-5-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 6231c34b29e9..23dba5c162c6 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -136,7 +136,7 @@ struct gs_device_bt_const {
 	__le32 brp_inc;
 } __packed;
 
-#define GS_CAN_FLAG_OVERFLOW 1
+#define GS_CAN_FLAG_OVERFLOW BIT(0)
 
 struct gs_host_frame {
 	u32 echo_id;
-- 
2.35.1


