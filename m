From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH 1/1] can: Allwinner A10/A20 CAN Controller
Date: Thu, 24 Sep 2015 07:54:08 +0200
Message-ID: <1443074048-31307-1-git-send-email-info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:50289 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbbIXFyO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 24 Sep 2015 01:54:14 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

This patch set (linux-next) fixes a bug in arbitration error reporting found by
Dan Carpenter and the modinfo name (thx to Peter Koorsgard) of the module.

ef9bd57 general: fix driver info
e9d2d74 sun4i_can_err: fix arbitration lost error reporting

Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
---

 drivers/net/can/sun4i_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 10d8497..d9a42c6 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -601,7 +601,7 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		stats->tx_errors++;
 		if (likely(skb)) {
 			cf->can_id |= CAN_ERR_LOSTARB;
-			cf->data[0] = (alc & 0x1f) >> 8;
+			cf->data[0] = (alc >> 8) & 0x1f;
 		}
 	}
 
@@ -854,4 +854,4 @@ module_platform_driver(sun4i_can_driver);
 MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
 MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION(DRV_NAME "CAN driver for Allwinner SoCs (A10/A20)");
+MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20)");
