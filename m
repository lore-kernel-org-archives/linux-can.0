Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B63BC49361
	for <linux-can@archiver.kernel.org>; Mon, 28 Jun 2021 15:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472C461A1D
	for <linux-can@archiver.kernel.org>; Mon, 28 Jun 2021 15:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhF1P5d (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:57:33 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:26805 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbhF1P46 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:56:58 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfu82501E0zjR6y03fuWtc; Mon, 28 Jun 2021 17:54:31 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:54:31 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 3/6] can: etas_es58x: use devm_kzalloc() to allocate device resources
Date:   Tue, 29 Jun 2021 00:54:17 +0900
Message-Id: <20210628155420.1176217-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
References: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Replace kzalloc() with devm_kzalloc(). By doing this, we do not need
to care anymore about having to call kfree(). This result in a
simpler and more easy to read code.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 7650e349cae1..d2bb1b56f962 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2185,7 +2185,8 @@ static struct es58x_device *es58x_init_es58x_dev(struct usb_interface *intf,
 		ops = &es581_4_ops;
 	}
 
-	es58x_dev = kzalloc(es58x_sizeof_es58x_device(param), GFP_KERNEL);
+	es58x_dev = devm_kzalloc(dev, es58x_sizeof_es58x_device(param),
+				 GFP_KERNEL);
 	if (!es58x_dev)
 		return ERR_PTR(-ENOMEM);
 
@@ -2235,7 +2236,7 @@ static int es58x_probe(struct usb_interface *intf,
 
 	ret = es58x_get_product_info(es58x_dev);
 	if (ret)
-		goto cleanup_es58x_dev;
+		return ret;
 
 	for (ch_idx = 0; ch_idx < es58x_dev->num_can_ch; ch_idx++) {
 		ret = es58x_init_netdev(es58x_dev, ch_idx);
@@ -2251,8 +2252,6 @@ static int es58x_probe(struct usb_interface *intf,
 			unregister_candev(es58x_dev->netdev[ch_idx]);
 			free_candev(es58x_dev->netdev[ch_idx]);
 		}
- cleanup_es58x_dev:
-	kfree(es58x_dev);
 
 	return ret;
 }
@@ -2283,8 +2282,6 @@ static void es58x_disconnect(struct usb_interface *intf)
 	}
 
 	es58x_free_urbs(es58x_dev);
-
-	kfree(es58x_dev);
 	usb_set_intfdata(intf, NULL);
 }
 
-- 
2.31.1

