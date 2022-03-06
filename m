Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CCFC433EF
	for <linux-can@archiver.kernel.org>; Sun,  6 Mar 2022 10:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiCFKOQ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 6 Mar 2022 05:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiCFKOP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 6 Mar 2022 05:14:15 -0500
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE941F85
        for <linux-can@vger.kernel.org>; Sun,  6 Mar 2022 02:13:22 -0800 (PST)
Received: from localhost.localdomain ([106.133.32.90])
        by smtp.orange.fr with ESMTPA
        id Qnsun8hn1tSo5Qnt6nrJUj; Sun, 06 Mar 2022 11:13:20 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Sun, 06 Mar 2022 11:13:20 +0100
X-ME-IP: 106.133.32.90
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        kernel test robot <yujie.liu@intel.com>
Subject: [PATCH] can: etas_es58x: initialize rx_event_msg before calling es58x_check_msg_len()
Date:   Sun,  6 Mar 2022 19:13:02 +0900
Message-Id: <20220306101302.708783-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Function es58x_fd_rx_event() invokes the es58x_check_msg_len() macro:
| 	ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
While doing so, it deferences an uninitialized variable: *rx_event_msg.

This is actually harmless because es58x_check_msg_len() only uses
preprocessors macro (sizeof() and __stringify()) on
*rx_event_msg. c.f. [1].

Nonetheless, this pattern is confusing so the lines are reordered to
make sure that rx_event_msg is correctly initialized.

This patch also fixes a false positive warning reported by cppcheck:

| cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)
|
|     In file included from drivers/net/can/usb/etas_es58x/es58x_fd.c:
|  >> drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning: Uninitialized variable: rx_event_msg [uninitvar]
|      ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
|            ^

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/etas_es58x/es58x_core.h#L467

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
As discussed in
https://lore.kernel.org/linux-can/20220302130423.ddd2ulldffpo5lb2@pengutronix.de/T/#u,
no need to backport this patch because this is not a fix.

@Yujie Liu: I added the "Reported-by: kernel test robot". This being a
false positive, let me know if you would like to remove the tag in
order not to mess with you statistics.
---
 drivers/net/can/usb/etas_es58x/es58x_fd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index 88d2540abbbe..c97ffa71fd75 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -173,12 +173,11 @@ static int es58x_fd_rx_event_msg(struct net_device *netdev,
 	const struct es58x_fd_rx_event_msg *rx_event_msg;
 	int ret;
 
+	rx_event_msg = &es58x_fd_urb_cmd->rx_event_msg;
 	ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
 	if (ret)
 		return ret;
 
-	rx_event_msg = &es58x_fd_urb_cmd->rx_event_msg;
-
 	return es58x_rx_err_msg(netdev, rx_event_msg->error_code,
 				rx_event_msg->event_code,
 				get_unaligned_le64(&rx_event_msg->timestamp));
-- 
2.34.1

