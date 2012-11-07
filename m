From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] candump: Mark local CAN frames
Date: Wed,  7 Nov 2012 08:53:51 +0100
Message-ID: <1352274831-20551-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:52053 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751285Ab2KGIEF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 03:04:05 -0500
Received: from comm.systec-electronic.de (95-91-81-39-dynip.superkabel.de [95.91.81.39])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 8BC0C27A5C8
	for <linux-can@vger.kernel.org>; Wed,  7 Nov 2012 08:57:56 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

Mark CAN frames with an * after the CAN interface to indicate it
originates from the same host.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
I've chosen * instead of something like l (for local) as * cannot be part
of the interface name.
If someone comes up with a better char or better location to put,
please comment.

 candump.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/candump.c b/candump.c
index ac51192..4916fa7 100644
--- a/candump.c
+++ b/candump.c
@@ -734,6 +734,7 @@ int main(int argc, char **argv)
 
 				printf(" %s", (color && (color<3))?col_on[idx%MAXCOL]:"");
 				printf("%*s", max_devname_len, devname[idx]);
+				printf("%s", msg.msg_flags & MSG_DONTROUTE ? "*" : " ");
 				printf("%s  ", (color==1)?col_off:"");
 
 				fprint_long_canframe(stdout, &frame, NULL, view);
-- 
1.7.8.6

