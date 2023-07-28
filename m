Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE8C001E0
	for <linux-can@archiver.kernel.org>; Fri, 28 Jul 2023 07:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjG1H7k (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 28 Jul 2023 03:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjG1H7U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2023 03:59:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16BC4695
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 00:58:49 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qPIMr-0008Gm-Lp
        for linux-can@vger.kernel.org; Fri, 28 Jul 2023 09:58:33 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 75E151FD252
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 07:56:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 76B931FD1C2;
        Fri, 28 Jul 2023 07:56:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6d8b9cd1;
        Fri, 28 Jul 2023 07:56:16 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/21] can: gs_usb: gs_usb_probe(): align block comment
Date:   Fri, 28 Jul 2023 09:56:02 +0200
Message-Id: <20230728075614.1014117-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728075614.1014117-1-mkl@pengutronix.de>
References: <20230728075614.1014117-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Indent block comment so that it aligns the * on each line.

Link: https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-2-c3b9154ec605@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c604377138fd..966e00ea768d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1443,8 +1443,8 @@ static int gs_usb_probe(struct usb_interface *intf,
 		dev->canch[i]->parent = dev;
 
 		/* set RX packet size based on FD and if hardware
-                * timestamps are supported.
-		*/
+		 * timestamps are supported.
+		 */
 		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
 			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 				hf_size_rx = struct_size(hf, canfd_ts, 1);
-- 
2.40.1


