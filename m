Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51490C433FE
	for <linux-can@archiver.kernel.org>; Wed,  9 Mar 2022 12:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiCIMmi (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiCIMmh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:42:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD621768F6
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:41:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRvdJ-0002ga-Kf
        for linux-can@vger.kernel.org; Wed, 09 Mar 2022 13:41:37 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A300946B9F
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 12:41:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5DCBE46B9C;
        Wed,  9 Mar 2022 12:41:36 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ea7efeb8;
        Wed, 9 Mar 2022 12:41:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 08/21] can: gs_usb: add HW timestamp mode bit
Date:   Wed,  9 Mar 2022 13:41:19 +0100
Message-Id: <20220309124132.291861-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309124132.291861-1-mkl@pengutronix.de>
References: <20220309124132.291861-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Newer versions of the widely used open source firmware candleLight
support hardware timestamps. The support is activated by setting the
GS_CAN_MODE_HW_TIMESTAMP in the GS_USB_BREQ_MODE request.

Although timestamp support is not yet supported by this driver, add
the missing bit for documentation purpose.

Link: https://github.com/candle-usb/candleLight_fw/commit/44431f4a4354a878fbd15b273bf04fce1dcdff7e
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index fa370549bd9e..62076c5e8e4e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -92,6 +92,7 @@ struct gs_device_config {
 #define GS_CAN_MODE_LOOP_BACK BIT(1)
 #define GS_CAN_MODE_TRIPLE_SAMPLE BIT(2)
 #define GS_CAN_MODE_ONE_SHOT BIT(3)
+#define GS_CAN_MODE_HW_TIMESTAMP BIT(4)
 
 struct gs_device_mode {
 	__le32 mode;
-- 
2.34.1


