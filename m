From: uescher <linux-can_ger.kernel.org@myvdr.de>
Subject: [PATCH 2/2] slcanpty: code-style: add braces
Date: Sun, 24 Feb 2013 16:31:56 +0100
Message-ID: <512A326C.4030300@myvdr.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070606050204050702020601"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:37855 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868Ab3BXPjg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Feb 2013 10:39:36 -0500
Received: from [176.34.235.140] (helo=[0.0.0.0])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <linux-can_ger.kernel.org@myvdr.de>)
	id 1U9dYU-0004J0-5Y
	for linux-can@vger.kernel.org; Sun, 24 Feb 2013 16:31:58 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------070606050204050702020601
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

slcanpty: code-style: add braces

Signed-off-by: Ulrich Escher <git@myvdr.de>


--------------070606050204050702020601
Content-Type: text/x-patch;
 name="0002-slcanpty-code-style-add-braces.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-slcanpty-code-style-add-braces.patch"

From 0db3dba7450c5ec9f6fa31ff7686f7ed3536fe8d Mon Sep 17 00:00:00 2001
From: ulrich <git@myvdr.de>
Date: Sun, 24 Feb 2013 15:57:05 +0100
Subject: [PATCH 2/2] slcanpty: code-style: add braces

Signed-off-by: Ulrich Escher <git@myvdr.de>
---
 slcanpty.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/slcanpty.c b/slcanpty.c
index 037edf5..b176498 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -508,16 +508,18 @@ int main(int argc, char **argv)
 			continue;
 		}
 
-		if (FD_ISSET(p, &rdfs))
+		if (FD_ISSET(p, &rdfs)) {
 			if (pty2can(p, s, &fi, &is_open, &tstamp)) {
-			running = 0;
-			continue;
+				running = 0;
+				continue;
+			}
 		}
 
-		if (FD_ISSET(s, &rdfs))
+		if (FD_ISSET(s, &rdfs)) {
 			if (can2pty(p, s, &tstamp)) {
-			running = 0;
-			continue;
+				running = 0;
+				continue;
+			}
 		}
 	}
 
-- 
1.7.9.5


--------------070606050204050702020601--
