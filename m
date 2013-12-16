From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 08/11] sllin: signal timeout if there are less than configured characters
Date: Mon, 16 Dec 2013 08:54:11 +0100
Message-ID: <1387180454-1738-9-git-send-email-alexander.stein@systec-electronic.com>
References: <2633616.0o8t6AGOQY@ws-stein>
 <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46054 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627Ab3LPHzz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 02:55:55 -0500
In-Reply-To: <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

We will hit the timeout if there is a larger length configured than
actually received or none at all. Signal this to userspace.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index 457788c..ffbdf01 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -949,7 +949,16 @@ static enum hrtimer_restart sllin_rx_timeout_handler(struct hrtimer *hrtimer)
 {
 	struct sllin *sl = container_of(hrtimer, struct sllin, rx_timer);
 
-	if (sl->lin_master) {
+	/*
+	 * Signal timeout when:
+	 * master: We did not receive as much characters as expected
+	 * slave: * we did not receive any data bytes at all
+	 *        * we know the length and didn't receive enough
+	 */
+	if ((sl->lin_master) ||
+			(sl->rx_cnt <= SLLIN_BUFF_DATA) ||
+			((!sl->rx_len_unknown) &&
+			(sl->rx_cnt < sl->rx_expect))) {
 		sllin_report_error(sl, LIN_ERR_RX_TIMEOUT);
 		set_bit(SLF_TMOUTEVENT, &sl->flags);
 	} else {
-- 
1.8.3.2

