From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] Use strlen instead of sizeof on char* string
Date: Tue, 13 Nov 2012 16:47:22 +0100
Message-ID: <1352821642-18791-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:37446 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751662Ab2KMPr0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Nov 2012 10:47:26 -0500
Received: from comm.systec-electronic.de (95-91-81-39-dynip.superkabel.de [95.91.81.39])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 3CC1527A5AE
	for <linux-can@vger.kernel.org>; Tue, 13 Nov 2012 16:50:36 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

This bug was detected by the clang warning:
libsocketcan.c:384:16: warning: argument to 'sizeof' in 'strncmp' call
is the same expression as the source; did you mean to provide an
explicit length? [-Wsizeof-pointer-memaccess]
sizeof(name)) != 0)
~~~~~~~^~~~~~

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 src/libsocketcan.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index fedcbdc..3ad2a6c 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -364,6 +364,7 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
 		     nl_msg = NLMSG_NEXT(nl_msg, u_msglen)) {
 			int type = nl_msg->nlmsg_type;
 			int len;
+			int namelen = strlen(name);
 
 			if (type == NLMSG_DONE) {
 				done++;
@@ -381,7 +382,7 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
 
 			if (strncmp
 			    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
-			     sizeof(name)) != 0)
+			     namelen) != 0)
 				continue;
 
 			if (tb[IFLA_LINKINFO])
-- 
1.7.8.6

