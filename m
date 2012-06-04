From: Rostislav Lisovy <lisovy@gmail.com>
Subject: [PATCH 1/2] can: Add constants containing length of CAN identifiers
Date: Mon,  4 Jun 2012 18:09:35 +0200
Message-ID: <1338826176-11646-1-git-send-email-lisovy@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50274 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760781Ab2FDQJt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jun 2012 12:09:49 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, lartc@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz, Rostislav Lisovy <lisovy@gmail.com>

The necessary information might be determined out of the CAN_*_MASK,
however it is undesirable to misuse masks for such purpose.

Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
---
 include/linux/can.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/can.h b/include/linux/can.h
index 9a19bcb..08d1610 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -38,6 +38,9 @@
  */
 typedef __u32 canid_t;
 
+#define CAN_SFF_ID_BITS		11
+#define CAN_EFF_ID_BITS		29
+
 /*
  * Controller Area Network Error Frame Mask structure
  *
-- 
1.7.9.5

