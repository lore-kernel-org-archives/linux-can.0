From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH 2/3] can: ti_hecc: fix invalid error codes
Date: Fri, 18 Jan 2013 09:32:40 +0100
Message-ID: <1358497961-9080-2-git-send-email-olivier@sobrie.be>
References: <1358497961-9080-1-git-send-email-olivier@sobrie.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:55195 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab3ARIem (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Jan 2013 03:34:42 -0500
Received: by mail-ee0-f47.google.com with SMTP id e52so1594628eek.6
        for <linux-can@vger.kernel.org>; Fri, 18 Jan 2013 00:34:40 -0800 (PST)
In-Reply-To: <1358497961-9080-1-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Olivier Sobrie <olivier@sobrie.be>, Anant Gole <anantgole@ti.com>

Errors in CAN protocol (location) are reported in data[3] of the can
frame instead of data[2].

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Cc: Anant Gole <anantgole@ti.com>
---
 drivers/net/can/ti_hecc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index f898c63..300581b 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -746,12 +746,12 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
 		}
 		if (err_status & HECC_CANES_CRCE) {
 			hecc_set_bit(priv, HECC_CANES, HECC_CANES_CRCE);
-			cf->data[2] |= CAN_ERR_PROT_LOC_CRC_SEQ |
+			cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ |
 					CAN_ERR_PROT_LOC_CRC_DEL;
 		}
 		if (err_status & HECC_CANES_ACKE) {
 			hecc_set_bit(priv, HECC_CANES, HECC_CANES_ACKE);
-			cf->data[2] |= CAN_ERR_PROT_LOC_ACK |
+			cf->data[3] |= CAN_ERR_PROT_LOC_ACK |
 					CAN_ERR_PROT_LOC_ACK_DEL;
 		}
 	}
-- 
1.7.9.5

