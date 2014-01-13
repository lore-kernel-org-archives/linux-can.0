From: yegorslists@googlemail.com
Subject: [PATCH] slcanpty: declare command buffer static
Date: Mon, 13 Jan 2014 14:29:16 +0100
Message-ID: <1389619756-28940-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:50973 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662AbaAMN3m (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 13 Jan 2014 08:29:42 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

ASCII command buffer char buf[200] must be declared as static,
because it holds incomplete commands between pty2can() calls.
Without static it is not guaranteed, that buf retains the same
data between calls.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 slcanpty.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/slcanpty.c b/slcanpty.c
index 2c1cabe..c062a02 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -68,7 +68,7 @@ int pty2can(int pty, int socket, struct can_filter *fi,
 {
 	int nbytes;
 	char cmd;
-	char buf[200];
+	static char buf[200];
 	char replybuf[10]; /* for answers to received commands */
 	int ptr;
 	struct can_frame frame;
-- 
1.7.7

