Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7578FC43461
	for <linux-can@archiver.kernel.org>; Wed, 14 Apr 2021 20:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5158460E08
	for <linux-can@archiver.kernel.org>; Wed, 14 Apr 2021 20:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhDNUEW (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 14 Apr 2021 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353743AbhDNUEV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Apr 2021 16:04:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D52C06175F
        for <linux-can@vger.kernel.org>; Wed, 14 Apr 2021 13:03:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lWljy-0006k2-8k
        for linux-can@vger.kernel.org; Wed, 14 Apr 2021 22:03:58 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C19E160EC99
        for <linux-can@vger.kernel.org>; Wed, 14 Apr 2021 20:03:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E507960EC8E;
        Wed, 14 Apr 2021 20:03:55 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8dd2a3b8;
        Wed, 14 Apr 2021 20:03:55 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next] can: etas_es58x: fix null pointer dereference when handling error frames
Date:   Wed, 14 Apr 2021 22:03:52 +0200
Message-Id: <20210414200352.2473363-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414200352.2473363-1-mkl@pengutronix.de>
References: <20210414200352.2473363-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

During the handling of CAN bus errors, a CAN error SKB is allocated
using alloc_can_err_skb(). Even if the allocation of the SKB fails,
the function continues in order to do the stats handling.

All access to the can_frame pointer (cf) should be guarded by an if
statement:
	if (cf)

However, the increment of the rx_bytes stats:
	netdev->stats.rx_bytes += cf->can_dlc;
dereferences the cf pointer and was not guarded by an if condition
leading to a NULL pointer dereference if the can_err_skb() function
failed.

Replacing the cf->can_dlc by the macro CAN_ERR_DLC (which is the
length of any CAN error frames) solves this NULL pointer dereference.

Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
Link: https://lore.kernel.org/r/20210413114242.2760-1-mailhol.vincent@wanadoo.fr
Reported-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 7222b3b6ca46..57e5f94468e9 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -856,7 +856,7 @@ int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
 	 * consistency.
 	 */
 	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += cf->can_dlc;
+	netdev->stats.rx_bytes += CAN_ERR_DLC;
 
 	if (cf) {
 		if (cf->data[1])

base-commit: 5871d0c6b8ea805916c3135d0c53b095315bc674
-- 
2.30.2


