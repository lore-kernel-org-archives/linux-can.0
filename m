From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 3/6] sllin: slave: don't forget to wait for the checksum
Date: Tue, 10 Dec 2013 18:16:14 +0100
Message-ID: <1386695777-18463-4-git-send-email-alexander.stein@systec-electronic.com>
References: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:60306 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755123Ab3LJR2U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 12:28:20 -0500
In-Reply-To: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index cf3cd75..b97219e 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -550,7 +550,7 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 
 			/* Is the length of data set in frame cache? */
 			if (sce->frame_fl & LIN_CACHE_RESPONSE) {
-				sl->rx_expect += sce->dlc;
+				sl->rx_expect += sce->dlc + 1; /* + checksum */
 				sl->rx_len_unknown = false;
 			} else {
 				sl->rx_expect += SLLIN_DATA_MAX + 1; /* + checksum */
-- 
1.8.3.2

