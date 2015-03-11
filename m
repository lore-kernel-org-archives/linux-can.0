From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: [PATCH v2 3/3] can: kvaser_usb: Use can-dev unregistration mechanism
Date: Wed, 11 Mar 2015 11:30:55 -0400
Message-ID: <20150311153055.GC12260@linux>
References: <20150226152011.GA6075@linux>
 <20150311152353.GA12260@linux>
 <20150311152811.GB12260@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:35896 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbbCKPa7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Mar 2015 11:30:59 -0400
Content-Disposition: inline
In-Reply-To: <20150311152811.GB12260@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

From: Ahmed S. Darwish <ahmed.darwish@valeo.com>

Use can-dev's unregister_candev() instead of directly calling
networking unregister_netdev(). While both are functionally
equivalent, unregister_candev() might do extra stuff in the
future than just calling networking layer unregistration code.

Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
---
 drivers/net/can/usb/kvaser_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 0742d53..f9c14e8 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1866,7 +1866,7 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 		if (!dev->nets[i])
 			continue;
 
-		unregister_netdev(dev->nets[i]->netdev);
+		unregister_candev(dev->nets[i]->netdev);
 	}
 
 	kvaser_usb_unlink_all_urbs(dev);
-- 
1.9.1

