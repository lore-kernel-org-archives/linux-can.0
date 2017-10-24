From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH 1/2] can: kvaser_usb: Correct return value in printout
Date: Tue, 24 Oct 2017 12:23:28 +0200
Message-ID: <20171024102329.28526-2-jimmyassarsson@gmail.com>
References: <20171024102329.28526-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:50325 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbdJXKYW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Oct 2017 06:24:22 -0400
Received: by mail-lf0-f65.google.com with SMTP id a132so23376662lfa.7
        for <linux-can@vger.kernel.org>; Tue, 24 Oct 2017 03:24:21 -0700 (PDT)
In-Reply-To: <20171024102329.28526-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>

If the return value from kvaser_usb_send_simple_msg() was non-zero, the
return value from kvaser_usb_flush_queue() was printed in the kernel
warning.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
 drivers/net/can/usb/kvaser_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 18cc529fb807..861e90efab86 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1609,7 +1609,8 @@ static int kvaser_usb_close(struct net_device *netdev)
 	if (err)
 		netdev_warn(netdev, "Cannot flush queue, error %d\n", err);
 
-	if (kvaser_usb_send_simple_msg(dev, CMD_RESET_CHIP, priv->channel))
+	err = kvaser_usb_send_simple_msg(dev, CMD_RESET_CHIP, priv->channel);
+	if (err)
 		netdev_warn(netdev, "Cannot reset card, error %d\n", err);
 
 	err = kvaser_usb_stop_chip(priv);
-- 
2.14.2

