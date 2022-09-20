Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF0ECAAD8
	for <linux-can@archiver.kernel.org>; Tue, 20 Sep 2022 10:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiITKE4 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 20 Sep 2022 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiITKEx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 06:04:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BA02B1BA
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 03:04:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oaa7V-0003qx-M9
        for linux-can@vger.kernel.org; Tue, 20 Sep 2022 12:04:49 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4464BE7476
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 10:04:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 914EEE746B;
        Tue, 20 Sep 2022 10:04:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2e5c3a6b;
        Tue, 20 Sep 2022 10:04:47 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] can: gs_usb: gs_can_open(): initialize time counter before starting device
Date:   Tue, 20 Sep 2022 12:04:17 +0200
Message-Id: <20220920100416.959226-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920100416.959226-1-mkl@pengutronix.de>
References: <20220920100416.959226-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On busy networks the CAN controller might receive CAN frames directly
after starting it but before the timecounter is setup. This will lead
to NULL pointer deref while converting the converting the CAN frame's
timestamp with the timecounter.

Close the race window by setting up the timecounter before starting
the CAN controller.

Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
Cc: John Whittington <git@jbrengineering.co.uk
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index fe4116bf925b..d3e229c62389 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -972,6 +972,10 @@ static int gs_can_open(struct net_device *netdev)
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 		flags |= GS_CAN_MODE_HW_TIMESTAMP;
 
+	/* start polling timestamp */
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_init(dev);
+
 	/* finally start device */
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 	dm->mode = cpu_to_le32(GS_CAN_MODE_START);
@@ -991,10 +995,6 @@ static int gs_can_open(struct net_device *netdev)
 
 	kfree(dm);
 
-	/* start polling timestamp */
-	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-		gs_usb_timestamp_init(dev);
-
 	parent->active_channels++;
 	if (!(dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
 		netif_start_queue(netdev);
-- 
2.35.1


