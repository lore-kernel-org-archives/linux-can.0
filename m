From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] Use strcmp instead of sizeof on char* string
Date: Wed, 14 Nov 2012 12:13:06 +0100
Message-ID: <1352891586-17729-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:56377 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755134Ab2KNLNK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 06:13:10 -0500
Received: from comm.systec-electronic.de (95-91-81-39-dynip.superkabel.de [95.91.81.39])
	by webbox1416.server-home.net (Postfix) with ESMTPA id AE29727A5A5
	for <linux-can@vger.kernel.org>; Wed, 14 Nov 2012 12:16:14 +0100 (CET)
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
 src/libsocketcan.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index fedcbdc..841c2ed 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -379,9 +379,8 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
 				nl_msg->nlmsg_len - NLMSG_LENGTH(sizeof(struct ifaddrmsg));
 			parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), len);
 
-			if (strncmp
-			    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
-			     sizeof(name)) != 0)
+			if (strcmp
+			    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name) != 0)
 				continue;
 
 			if (tb[IFLA_LINKINFO])
-- 
1.7.8.6

