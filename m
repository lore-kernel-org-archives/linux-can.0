From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: kvaser_usb: check number of channels returned by HW
Date: Wed, 12 Feb 2014 11:35:40 +0100
Message-ID: <1392201340-6909-2-git-send-email-mkl@pengutronix.de>
References: <1392201340-6909-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35994 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbaBLKfp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Feb 2014 05:35:45 -0500
In-Reply-To: <1392201340-6909-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Olivier Sobrie <olivier@sobrie.be>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Olivier Sobrie <olivier@sobrie.be>

It is needed to check the number of channels returned by the HW because it
cannot be greater than MAX_NET_DEVICES otherwise it will crash.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 6c859bb..e77d110 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -473,6 +473,8 @@ static int kvaser_usb_get_card_info(struct kvaser_usb *dev)
 		return err;
 
 	dev->nchannels = msg.u.cardinfo.nchannels;
+	if (dev->nchannels > MAX_NET_DEVICES)
+		return -EINVAL;
 
 	return 0;
 }
-- 
1.8.5.3

