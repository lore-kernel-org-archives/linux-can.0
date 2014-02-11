From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH] can: kvaser_usb: check number of channels returned by HW
Date: Tue, 11 Feb 2014 11:01:23 +0100
Message-ID: <1392112884-27101-1-git-send-email-olivier@sobrie.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:40781 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaBKKC6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2014 05:02:58 -0500
Received: by mail-ea0-f175.google.com with SMTP id n15so787293ead.34
        for <linux-can@vger.kernel.org>; Tue, 11 Feb 2014 02:02:56 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

It is needed to check the number of channels returned by the HW
because it cannot be greater than MAX_NET_DEVICES otherwise
it will crash.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/net/can/usb/kvaser_usb.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 4b2d5ed..cc3df8a 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -474,6 +474,8 @@ static int kvaser_usb_get_card_info(struct kvaser_usb *dev)
 		return err;
 
 	dev->nchannels = msg.u.cardinfo.nchannels;
+	if (dev->nchannels > MAX_NET_DEVICES)
+		return -EINVAL;
 
 	return 0;
 }
-- 
1.7.9.5

