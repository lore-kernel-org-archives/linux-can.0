Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5DAC433E9
	for <linux-can@archiver.kernel.org>; Wed, 20 Jan 2021 10:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8110A23331
	for <linux-can@archiver.kernel.org>; Wed, 20 Jan 2021 10:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbhATKNF (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 20 Jan 2021 05:13:05 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:32358 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbhATJMo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jan 2021 04:12:44 -0500
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d39 with ME
        id JxAu2400a3PnFJp03xAzb7; Wed, 20 Jan 2021 10:11:02 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 20 Jan 2021 10:11:02 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Loris Fauster <loris.fauster@ttcontrol.com>,
        Alejandro Concepcion Rodriguez <alejandro@acoro.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 3/3] can: peak_usb: fix use after free bugs
Date:   Wed, 20 Jan 2021 18:09:30 +0900
Message-Id: <20210120090930.137581-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210120090930.137581-1-mailhol.vincent@wanadoo.fr>
References: <20210120090930.137581-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

After calling peak_usb_netif_rx_ni(skb), dereferencing skb is unsafe.
Especially, the can_frame cf which aliases skb memory is accessed
after the peak_usb_netif_rx_ni().

Reordering the lines solves the issue.

fixes: 0a25e1f4f185 ("can: peak_usb: add support for PEAK new CANFD USB adapters")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 61631f4fd92a..f347ecc79aef 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -514,11 +514,11 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 	else
 		memcpy(cfd->data, rm->d, cfd->len);
 
-	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(rm->ts_low));
-
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += cfd->len;
 
+	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(rm->ts_low));
+
 	return 0;
 }
 
@@ -580,11 +580,11 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	if (!skb)
 		return -ENOMEM;
 
-	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(sm->ts_low));
-
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += cf->len;
 
+	peak_usb_netif_rx(skb, &usb_if->time_ref, le32_to_cpu(sm->ts_low));
+
 	return 0;
 }
 
-- 
2.26.2

