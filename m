From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] README: fix mainline linux typo + add linebreak
Date: Tue, 18 Jun 2013 22:33:42 +0200
Message-ID: <1371587622-21734-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36459 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274Ab3FRUdp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Jun 2013 16:33:45 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

---
Hello Bernd,

that was my first markdown patch, doesn't look as expected :( The documentation
says two or more tailing spaces will be converted into <br />. And I wanted to
say mainline linux.

regards,
Marc

 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 2b80717..8a32d0f 100644
--- a/README.md
+++ b/README.md
@@ -3,7 +3,7 @@ CAN driver for UAB "8 devices" USB2CAN converter
 
 Note
 ----
-The "8 devices" USB2CAN converter is supported by main linux since version 3.9.
+The "8 devices" USB2CAN converter is supported by mainline linux since version 3.9.  
 THIS SOFTWARE COMES WITHOUT ANY WARRANTY!
 
 
-- 
1.8.3.1

