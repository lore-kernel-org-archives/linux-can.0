From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH 3/3] can: pch_can: fix invalid error codes
Date: Fri, 18 Jan 2013 09:32:41 +0100
Message-ID: <1358497961-9080-3-git-send-email-olivier@sobrie.be>
References: <1358497961-9080-1-git-send-email-olivier@sobrie.be>
 <1358497961-9080-2-git-send-email-olivier@sobrie.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42163 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab3ARIes (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Jan 2013 03:34:48 -0500
Received: by mail-ee0-f46.google.com with SMTP id e49so1596955eek.5
        for <linux-can@vger.kernel.org>; Fri, 18 Jan 2013 00:34:46 -0800 (PST)
In-Reply-To: <1358497961-9080-2-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Olivier Sobrie <olivier@sobrie.be>

Errors in CAN protocol (location) are reported in data[3] of the can
frame instead of data[2].

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/net/can/pch_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 7d17485..5c314a9 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -560,7 +560,7 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		stats->rx_errors++;
 		break;
 	case PCH_CRC_ERR:
-		cf->data[2] |= CAN_ERR_PROT_LOC_CRC_SEQ |
+		cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ |
 			       CAN_ERR_PROT_LOC_CRC_DEL;
 		priv->can.can_stats.bus_error++;
 		stats->rx_errors++;
-- 
1.7.9.5

