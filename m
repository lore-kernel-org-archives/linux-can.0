From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [PATCH 2/3] janitorial: log2asc: properly close infile and outfile
Date: Fri,  6 Mar 2015 09:17:17 +0100
Message-ID: <1425629838-27641-2-git-send-email-r.schwebel@pengutronix.de>
References: <1425629838-27641-1-git-send-email-r.schwebel@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40572 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243AbbCFIRe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Mar 2015 03:17:34 -0500
In-Reply-To: <1425629838-27641-1-git-send-email-r.schwebel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Robert Schwebel <r.schwebel@pengutronix.de>

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
---
 log2asc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/log2asc.c b/log2asc.c
index 446c0b6..29d13e8 100644
--- a/log2asc.c
+++ b/log2asc.c
@@ -198,6 +198,8 @@ int main(int argc, char **argv)
 		}
 	}
 	fflush(outfile);
+	fclose(outfile);
+	fclose(infile);
 
 	return 0;
 }
-- 
2.1.4

