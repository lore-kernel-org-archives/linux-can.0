From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] cangen: Support RTR frames with random or increment CAN IDs
Date: Wed,  7 Nov 2012 09:14:08 +0100
Message-ID: <1352276048-21299-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46849 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751747Ab2KGIOO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 03:14:14 -0500
Received: from comm.systec-electronic.de (95-91-81-39-dynip.superkabel.de [95.91.81.39])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 352C927A5C8
	for <linux-can@vger.kernel.org>; Wed,  7 Nov 2012 09:18:11 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 cangen.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/cangen.c b/cangen.c
index efb8251..0037605 100644
--- a/cangen.c
+++ b/cangen.c
@@ -339,6 +339,9 @@ int main(int argc, char **argv)
 				frame.can_id |= CAN_EFF_FLAG;
 			} else
 				frame.can_id &= CAN_SFF_MASK;
+
+			if (rtr_frame)
+				frame.can_id |= CAN_RTR_FLAG;
 		}
 
 		if (dlc_mode == MODE_RANDOM) {
@@ -412,6 +415,9 @@ resend:
 				frame.can_id |= CAN_EFF_FLAG;
 			} else
 				frame.can_id &= CAN_SFF_MASK;
+
+			if (rtr_frame)
+				frame.can_id |= CAN_RTR_FLAG;
 		}
 
 		if (dlc_mode == MODE_INCREMENT) {
-- 
1.7.8.6

