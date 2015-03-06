From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [PATCH 1/3] janitorial: asc2log: properly close infile
Date: Fri,  6 Mar 2015 09:17:16 +0100
Message-ID: <1425629838-27641-1-git-send-email-r.schwebel@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40570 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243AbbCFIRb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Mar 2015 03:17:31 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Robert Schwebel <r.schwebel@pengutronix.de>

outfile is closed as well, so do this symmetrically for infile.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
---
 asc2log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/asc2log.c b/asc2log.c
index 548fc7e..ae78a41 100644
--- a/asc2log.c
+++ b/asc2log.c
@@ -343,5 +343,6 @@ int main(int argc, char **argv)
 		}
 	}
 	fclose(outfile);
+	fclose(infile);
 	return 0;
 }
-- 
2.1.4

