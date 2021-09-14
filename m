Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CA9C433EF
	for <linux-can@archiver.kernel.org>; Tue, 14 Sep 2021 10:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C538610CE
	for <linux-can@archiver.kernel.org>; Tue, 14 Sep 2021 10:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhINKLb (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhINKL3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Sep 2021 06:11:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF3EC061574
        for <linux-can@vger.kernel.org>; Tue, 14 Sep 2021 03:10:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mQ5OC-0000Ml-G2
        for linux-can@vger.kernel.org; Tue, 14 Sep 2021 12:10:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AF37467DA05
        for <linux-can@vger.kernel.org>; Tue, 14 Sep 2021 10:10:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 57C9667DA02;
        Tue, 14 Sep 2021 10:10:07 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a31ce124;
        Tue, 14 Sep 2021 10:10:06 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Roman Valls <brainstorm@nopcode.org>
Subject: [PATCH] can: gs_usb: use %u to print unsigned values
Date:   Tue, 14 Sep 2021 12:10:05 +0200
Message-Id: <20210914101005.84394-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch changes printf modifier to an unsigned int, as the printed
variables are unsigned.

Cc: Roman Valls <brainstorm@nopcode.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5e892bef46b0..1b400de00f51 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -352,7 +352,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	} else { /* echo_id == hf->echo_id */
 		if (hf->echo_id >= GS_MAX_TX_URBS) {
 			netdev_err(netdev,
-				   "Unexpected out of range echo id %d\n",
+				   "Unexpected out of range echo id %u\n",
 				   hf->echo_id);
 			goto resubmit_urb;
 		}
@@ -365,7 +365,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		/* bad devices send bad echo_ids. */
 		if (!txc) {
 			netdev_err(netdev,
-				   "Unexpected unused echo id %d\n",
+				   "Unexpected unused echo id %u\n",
 				   hf->echo_id);
 			goto resubmit_urb;
 		}
@@ -458,7 +458,7 @@ static void gs_usb_xmit_callback(struct urb *urb)
 	struct net_device *netdev = dev->netdev;
 
 	if (urb->status)
-		netdev_info(netdev, "usb xmit fail %d\n", txc->echo_id);
+		netdev_info(netdev, "usb xmit fail %u\n", txc->echo_id);
 
 	usb_free_coherent(urb->dev,
 			  urb->transfer_buffer_length,
@@ -501,7 +501,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	idx = txc->echo_id;
 
 	if (idx >= GS_MAX_TX_URBS) {
-		netdev_err(netdev, "Invalid tx context %d\n", idx);
+		netdev_err(netdev, "Invalid tx context %u\n", idx);
 		goto badidx;
 	}
 
@@ -964,11 +964,11 @@ static int gs_usb_probe(struct usb_interface *intf,
 	}
 
 	icount = dconf->icount + 1;
-	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
+	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
 	if (icount > GS_MAX_INTF) {
 		dev_err(&intf->dev,
-			"Driver cannot handle more that %d CAN interfaces\n",
+			"Driver cannot handle more that %u CAN interfaces\n",
 			GS_MAX_INTF);
 		kfree(dconf);
 		return -EINVAL;
-- 
2.33.0


