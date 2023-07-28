Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CBFC04A94
	for <linux-can@archiver.kernel.org>; Fri, 28 Jul 2023 08:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjG1IAC (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 28 Jul 2023 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjG1H7b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2023 03:59:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42673A8C
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 00:58:59 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qPIMu-0008KR-Ek
        for linux-can@vger.kernel.org; Fri, 28 Jul 2023 09:58:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A3C941FD262
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 07:56:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E951A1FD1DF;
        Fri, 28 Jul 2023 07:56:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5b617956;
        Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 13/21] can: gs_usb: gs_usb_receive_bulk_callback(): make use of stats
Date:   Fri, 28 Jul 2023 09:56:06 +0200
Message-Id: <20230728075614.1014117-14-mkl@pengutronix.de>
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

Make use the previously assigned variable stats instead of using
netdev->stats.

Link: https://lore.kernel.org/all/20230718-gs_usb-cleanups-v1-6-c3b9154ec605@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 04cbe949c290..0d0a3405ba19 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -594,8 +594,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		gs_usb_set_timestamp(dev, skb, hf);
 
-		netdev->stats.rx_packets++;
-		netdev->stats.rx_bytes += hf->can_dlc;
+		stats->rx_packets++;
+		stats->rx_bytes += hf->can_dlc;
 
 		netif_rx(skb);
 	} else { /* echo_id == hf->echo_id */
@@ -619,9 +619,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		skb = dev->can.echo_skb[hf->echo_id];
 		gs_usb_set_timestamp(dev, skb, hf);
 
-		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += can_get_echo_skb(netdev, hf->echo_id,
-							   NULL);
+		stats->tx_packets++;
+		stats->tx_bytes += can_get_echo_skb(netdev, hf->echo_id,
+						    NULL);
 
 		gs_free_tx_context(txc);
 
-- 
2.40.1


