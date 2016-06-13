From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH] at91_can: RX queue could get stuck at high bus load
Date: Mon, 13 Jun 2016 15:44:19 +0200
Message-ID: <575EB8B3.6050502@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.151]:49488 "EHLO
	mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423299AbcFMNoZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jun 2016 09:44:25 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Amr Bekhit <amrbekhit@gmail.com>

At high bus load it could happen that "at91_poll()" enters with all RX
message boxes filled up. If then at the end the "quota" is exceeded as
well, "rx_next" will not be reset to the first RX mailbox and hence the
interrupts remain disabled.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Tested-by: Amr Bekhit <amrbekhit@gmail.com>
---
 drivers/net/can/at91_can.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 8b3275d..8f5e93c 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -712,9 +712,10 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 
 	/* upper group completed, look again in lower */
 	if (priv->rx_next > get_mb_rx_low_last(priv) &&
-	    quota > 0 && mb > get_mb_rx_last(priv)) {
+	    mb > get_mb_rx_last(priv)) {
 		priv->rx_next = get_mb_rx_first(priv);
-		goto again;
+		if (quota > 0)
+			goto again;
 	}
 
 	return received;
-- 
1.9.1

