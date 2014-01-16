From: yegorslists@googlemail.com
Subject: [PATCH] README: typos and beautification
Date: Thu, 16 Jan 2014 09:45:00 +0100
Message-ID: <1389861900-29467-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:47887 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbaAPIp0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 16 Jan 2014 03:45:26 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: u.kleine-koenig@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 README |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 6293959..02b2453 100644
--- a/README
+++ b/README
@@ -1,18 +1,18 @@
 libsocketcan
-----------------------------------------------------
-This library allows you to control some basic functions in socketcan from
+-------------------------------------------------------------------------------
+This library allows you to control some basic functions in SocketCAN from
 userspace.
 
 Dependencies:
-----------------------------------------------------
+-------------------------------------------------------------------------------
 A recent kernel with integrated SocketCAN (at least 2.6.30)
 
 Building:
-----------------------------------------------------
-Please refert to the INSTALL file
+-------------------------------------------------------------------------------
+Please refer to the INSTALL file
 
 Documentation:
-----------------------------------------------------
-Make sure you have oxygen installed on your host. If yes simply Run
+-------------------------------------------------------------------------------
+Make sure you have Doxygen installed on your host. If yes simply run:
 make docs
 and look for the API doc in Documentation/html.
-- 
1.7.7

