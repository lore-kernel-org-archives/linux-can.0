From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [PATCH 3/3] gitignore: add isotpperf
Date: Fri,  6 Mar 2015 09:17:18 +0100
Message-ID: <1425629838-27641-3-git-send-email-r.schwebel@pengutronix.de>
References: <1425629838-27641-1-git-send-email-r.schwebel@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40574 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301AbbCFIRf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Mar 2015 03:17:35 -0500
In-Reply-To: <1425629838-27641-1-git-send-email-r.schwebel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Robert Schwebel <r.schwebel@pengutronix.de>

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 746b676..b7d9cbd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -34,6 +34,7 @@ GNUmakefile.in
 /cansend
 /cansniffer
 /isotpdump
+/isotpperf
 /isotprecv
 /isotpsend
 /isotpserver
-- 
2.1.4

