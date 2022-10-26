Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DBFA373D
	for <linux-can@archiver.kernel.org>; Wed, 26 Oct 2022 08:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiJZIk5 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 26 Oct 2022 04:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiJZIki (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Oct 2022 04:40:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81206386B0
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 01:40:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onbxR-0006jL-Ri
        for linux-can@vger.kernel.org; Wed, 26 Oct 2022 10:40:17 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9B6B710A0CB
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 08:40:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4667E10A0AC;
        Wed, 26 Oct 2022 08:40:13 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 00373d8f;
        Wed, 26 Oct 2022 08:40:08 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/29] can: gs_usb: gs_can_open(): sort checks for ctrlmode
Date:   Wed, 26 Oct 2022 10:39:49 +0200
Message-Id: <20221026084007.1583333-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221026084007.1583333-1-mkl@pengutronix.de>
References: <20221026084007.1583333-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sort the checks for dev->can.ctrlmode by values of CAN_CTRLMODE_*, so
that it's clear where to add new checks.

While there, remove the comment that the Atmel UC3C hardware doesn't
support One Shot Mode. The One Shot mode is only available and to be
activated by the user, if the device specifies the feature bit
GS_CAN_FEATURE_ONE_SHOT.

Link: https://lore.kernel.org/all/20221019221016.1659260-3-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index aa6c84b7db06..5dad0ebb3d3e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -843,8 +843,6 @@ static int gs_can_open(struct net_device *netdev)
 
 	ctrlmode = dev->can.ctrlmode;
 	if (ctrlmode & CAN_CTRLMODE_FD) {
-		flags |= GS_CAN_MODE_FD;
-
 		if (dev->feature & GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX)
 			dev->hf_size_tx = struct_size(hf, canfd_quirk, 1);
 		else
@@ -915,14 +913,14 @@ static int gs_can_open(struct net_device *netdev)
 	if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		flags |= GS_CAN_MODE_LISTEN_ONLY;
 
-	/* Controller is not allowed to retry TX
-	 * this mode is unavailable on atmels uc3c hardware
-	 */
+	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
+
 	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		flags |= GS_CAN_MODE_ONE_SHOT;
 
-	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
+	if (ctrlmode & CAN_CTRLMODE_FD)
+		flags |= GS_CAN_MODE_FD;
 
 	/* if hardware supports timestamps, enable it */
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-- 
2.35.1


