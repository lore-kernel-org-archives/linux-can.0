From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH 1/2] can: sunxi: Allwinner A10/A20 CAN Controller
Date: Fri, 25 Sep 2015 18:58:38 +0200
Message-ID: <1443200319-16655-1-git-send-email-info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:33534 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932234AbbIYQ6q (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 25 Sep 2015 12:58:46 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

fixes a bug in arbitration error reporting

e9d2d74 sun4i_can_err: fix arbitration lost error reporting

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
---

 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
