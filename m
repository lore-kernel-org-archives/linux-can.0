From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 05/11] sllin: Fix checksum mode decision
Date: Mon, 16 Dec 2013 08:54:08 +0100
Message-ID: <1387180454-1738-6-git-send-email-alexander.stein@systec-electronic.com>
References: <2633616.0o8t6AGOQY@ws-stein>
 <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46051 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752658Ab3LPHzy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 02:55:54 -0500
In-Reply-To: <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

rx_buff[SLLIN_BUFF_ID] only holds LIN ID + parity bits, but never internal
bits like LIN_CHECKSUM_EXTENDED.
Use correct value from internal cache entry.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index e05564c..487b72a 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -1216,7 +1216,7 @@ slstate_response_wait:
 				tx_bytes = lin_dlc;
 
 				mode = SLLIN_STPMSG_RESPONLY;
-				if (sl->rx_buff[SLLIN_BUFF_ID] & LIN_CHECKSUM_EXTENDED)
+				if (sce->frame_fl & LIN_CHECKSUM_EXTENDED)
 					mode |= SLLIN_STPMSG_CHCKSUM_ENH;
 
 				if (sllin_setup_msg(sl, mode, lin_id & LIN_ID_MASK,
-- 
1.8.3.2

